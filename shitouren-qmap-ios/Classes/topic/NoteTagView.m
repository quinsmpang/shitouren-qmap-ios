#import "NoteTagView.h"
#import "LoggerClient.h"
#import "TagItem.h"
#import "CWDLeftAlignedCollectionViewFlowLayout.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation NoteTagView

@synthesize tags,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect mainFrame = self.frame;
        mainFrame.origin = CGPointMake(0, 0);
        mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        uiTagLabels = [[NSMutableArray alloc] init];
        tags = [[NSMutableArray alloc] init];
        
        uiTagBg = [[UIImageView alloc] init];
        uiTagBg.backgroundColor = UIColorFromRGB(0x000000, 0.3f);
        uiTagBg.layer.masksToBounds = YES;
        
        CWDLeftAlignedCollectionViewFlowLayout *flowLayout=[[CWDLeftAlignedCollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        uiTagColl = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 50) collectionViewLayout:flowLayout];
        [uiTagColl setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [uiTagColl setScrollEnabled:NO];
        [uiTagColl setBackgroundColor:[UIColor blueColor]];
        [uiTagColl setBackgroundColor:[UIColor clearColor]];
        uiTagColl.dataSource = self;
        uiTagColl.delegate = self;
        [uiTagColl registerClass:[NoteTagCell class] forCellWithReuseIdentifier:@"NoteTagCell"];
        
        [self addSubview:uiTagBg];
        [self addSubview:uiTagColl];
    }
    return self;
}

-(void)start:(id<NoteTagViewDelegate>)pDelegate :(UIColor*)pColor :(NSMutableArray*)pTags
{
    self.delegate = pDelegate;
    uiTagColor = pColor;
    
    [tags removeAllObjects];
    [uiTagLabels removeAllObjects];
    
    for( TagItem *tTag in pTags ){
        UILabel *uiText  = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,20)];
        [uiText setTextColor:UIColorFromRGB(0xa4866c, 1.0f)];
        [uiText setBackgroundColor:[UIColor clearColor]];
        [uiText setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [uiText setNumberOfLines:1];
        [uiText setTextAlignment:NSTextAlignmentCenter];
        [uiText setLineBreakMode:NSLineBreakByWordWrapping];
        uiText.layer.masksToBounds = YES;
        uiText.layer.cornerRadius = 5;
        uiText.layer.borderWidth = 1;
        uiText.layer.borderColor = [UIColor greenColor].CGColor;
        
        uiText.text = tTag.text;
        //设置一个行高上限
        CGSize textMaxSize = CGSizeMake(300,20);
        NSDictionary *textAttribute = @{NSFontAttributeName: uiText.font};
        CGSize textLabelsize = [uiText.text boundingRectWithSize:textMaxSize options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:textAttribute context:nil].size;
        uiText.frame = CGRectMake(0,0,textLabelsize.width+5,textLabelsize.height+5);
        
        [tags addObject:tTag.text];
        [uiTagLabels addObject:uiText];
    }
    
    [uiTagColl reloadData];
    
    CGRect mainFrame = self.frame;
    
    CGRect tagCollFrame = CGRectMake(0, 0, mainFrame.size.width, uiTagColl.collectionViewLayout.collectionViewContentSize.height+20);
    uiTagColl.frame = tagCollFrame;
    
    CGRect tagBgFrame = CGRectMake(0, 0, mainFrame.size.width, tagCollFrame.origin.y+tagCollFrame.size.height-15);
    uiTagBg.frame = tagBgFrame;
    
    mainFrame.size.height = tagBgFrame.origin.y+tagBgFrame.size.height;
    self.frame = mainFrame;
}

#pragma mark -
#pragma mark ---UICollectionViewDataSource delegate---

//定义展示的Section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return tags.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"NoteTagCell";
    NoteTagCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell startLabel:self :indexPath :[tags objectAtIndex:indexPath.row] :uiTagColor];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *one = [uiTagLabels objectAtIndex:indexPath.row];
    return CGSizeMake(one.frame.size.width, one.frame.size.height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
//定义每个UICollectionView 横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

#pragma mark -
#pragma mark ---UICollectionViewDelegate delegate---

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark -
#pragma mark ---NotePlaceCellDelegate delegate---

- (void)NTCDclick:(NSIndexPath *)indexPath {
    if( delegate!= nil){
        [delegate NTVDclick:[tags objectAtIndex:indexPath.row]];
    }
}

@end
