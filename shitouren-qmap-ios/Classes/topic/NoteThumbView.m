#import "NoteThumbView.h"
#import "NoteThumbCell.h"
#import "LoggerClient.h"

@implementation NoteThumbView

@synthesize uiNoteImgMain,uiNoteTagView,uiNoteThumbList,note;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        note = nil;
        
        uiNoteImgMain = [[UIImageView alloc] init];
        [uiNoteImgMain setBackgroundColor:[UIColor clearColor]];
        uiNoteImgMain.contentMode = UIViewContentModeScaleAspectFill;
        uiNoteImgMain.clipsToBounds = YES;
        UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        [uiNoteImgMain addGestureRecognizer:imgTap];
        
        CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
        CGRect tagFrame = CGRectMake(10, 10, mainFrame.size.width-10*2, 50);
        uiNoteTagView = [[NoteTagView alloc] initWithFrame:tagFrame];
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        uiNoteThumbList = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) collectionViewLayout:flowLayout];
        [uiNoteThumbList setBackgroundColor:[UIColor purpleColor]];
        [uiNoteThumbList setBackgroundColor:[UIColor clearColor]];
        uiNoteThumbList.clipsToBounds = YES;
        uiNoteThumbList.delegate = self;
        uiNoteThumbList.dataSource = self;
        [uiNoteThumbList registerClass:[NoteThumbCell class] forCellWithReuseIdentifier:@"NoteThumbCell"];
        
        [self addSubview:uiNoteImgMain];
        [self addSubview:uiNoteTagView];
        [self addSubview:uiNoteThumbList];
    }
    return self;
}

-(void)start:(NoteItem*)pNote :(id<NoteListViewDelegate,NoteTagViewDelegate,NotePlaceViewDelegate>)pDelegate
{
    self.note = pNote;
    self.delegate = pDelegate;
    CGRect mainFrame = self.frame;
    
    int imgWidth = mainFrame.size.width-10*2;
    int imgHeight = imgWidth / 2;
    CGRect imgFrame = CGRectMake(10, 10, imgWidth, imgHeight);
    uiNoteImgMain.frame = imgFrame;
    uiNoteImgMain.layer.cornerRadius = 5;
    uiNoteImgMain.layer.masksToBounds = YES;
    uiNoteImgMain.layer.borderColor = [UIColor whiteColor].CGColor;
    uiNoteImgMain.userInteractionEnabled = YES;
    
    CGSize imageSize = CGSizeMake(uiNoteImgMain.frame.size.width, uiNoteImgMain.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor grayColor] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *placeholderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [uiNoteImgMain sd_setImageWithURL:[NSURL URLWithString:[pNote.imgs objectAtIndex:pNote.uiClickIndex]] placeholderImage:placeholderImage];
    
    [uiNoteTagView start:self.delegate :[UIColor greenColor] :pNote.tags];
    CGFloat tagWidth = uiNoteTagView.frame.size.width;
    CGFloat tagHeight = uiNoteTagView.frame.size.height;
    uiNoteTagView.frame = CGRectMake(10, uiNoteImgMain.frame.origin.y+uiNoteImgMain.frame.size.height-tagHeight, tagWidth, tagHeight);
    
    uiNoteThumbList.frame = CGRectMake(10, uiNoteImgMain.frame.origin.y+uiNoteImgMain.frame.size.height+10, imgWidth, 50);
    [uiNoteThumbList reloadData];
    
    mainFrame.size.height = uiNoteThumbList.frame.origin.y+uiNoteThumbList.frame.size.height;
    self.frame = mainFrame;
}

-(void)stop {
    CGSize imageSize = CGSizeMake(uiNoteImgMain.frame.size.width, uiNoteImgMain.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor grayColor] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *placeholderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [uiNoteImgMain setImage:placeholderImage];
}

-(void)imgClick:(id)sender {
    if( self.delegate ){
        [self.delegate NLVDclick:self.note];
    }
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if( self.note == nil ){
        return 0;
    }
    return self.note.thumbs.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"NoteThumbCell";
    NoteThumbCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if( self.note == nil ){
        return cell;
    }
    CGSize imageSize = CGSizeMake(cell.uiImgView.frame.size.width, cell.uiImgView.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor grayColor] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *placeholderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [cell.uiImgView sd_setImageWithURL:[NSURL URLWithString:[self.note.thumbs objectAtIndex:indexPath.row]] placeholderImage:placeholderImage];
    if( self.note.uiClickIndex == indexPath.row ){
        [cell start];
    }else{
        [cell stop];
    }
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//定义每个UICollectionView 横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteThumbCell * oldCell = (NoteThumbCell *)[self.uiNoteThumbList cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.note.uiClickIndex inSection:0]];
    [oldCell stop];
    NoteThumbCell * newCell = (NoteThumbCell *)[self.uiNoteThumbList cellForItemAtIndexPath:indexPath];
    [newCell start];
    self.note.uiClickIndex = indexPath.row;
    CGSize imageSize = CGSizeMake(uiNoteImgMain.frame.size.width, uiNoteImgMain.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor grayColor] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *placeholderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [uiNoteImgMain sd_setImageWithURL:[NSURL URLWithString:[self.note.imgs objectAtIndex:indexPath.row]] placeholderImage:placeholderImage];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
