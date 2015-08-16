#import "NoteTagCell.h"

@implementation NoteTagCell

@synthesize uiTagLabel,indexPath,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor yellowColor]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)startLabel:(id<NoteTagCellDelegate>)pDelegate :(NSIndexPath*)pIndexPath :(NSString*)pTag :(UIColor*)pColor {
    self.delegate = pDelegate;
    self.indexPath = pIndexPath;
    
    for( UIView* one in self.subviews ){
        [one removeFromSuperview];
    }
    uiTagLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 20)];
    [uiTagLabel setTextColor:pColor];
    [uiTagLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [uiTagLabel setBackgroundColor:[UIColor clearColor]];
    [uiTagLabel setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [uiTagLabel setNumberOfLines:1];
    [uiTagLabel setTextAlignment:NSTextAlignmentCenter];
    [uiTagLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [uiTagLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doClick:)];
    [uiTagLabel addGestureRecognizer:tap];
    uiTagLabel.layer.masksToBounds = YES;
    uiTagLabel.layer.cornerRadius = 5;
    uiTagLabel.layer.borderWidth = 1;
    uiTagLabel.layer.borderColor = pColor.CGColor;
    
    uiTagLabel.text = pTag;
    //设置一个行高上限
    CGSize textMaxSize = CGSizeMake(300,20);
    NSDictionary *textAttribute = @{NSFontAttributeName: uiTagLabel.font};
    CGSize textLabelsize = [uiTagLabel.text boundingRectWithSize:textMaxSize options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:textAttribute context:nil].size;
    uiTagLabel.frame = CGRectMake(0,0,textLabelsize.width+5,textLabelsize.height+5);
    
    [self addSubview:uiTagLabel];
}

-(void)doClick:(id)sender {
    if( self.delegate != nil ){
        [delegate NTCDclick:indexPath];
    }
}

@end
