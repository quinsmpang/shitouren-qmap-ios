#import "TopicCell.h"

@implementation TopicCell

@synthesize uiTopicchannel,uiTopichot,uiTopictitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        uiTopichot = [[UILabel alloc] init];
        [uiTopichot setTextColor:UIColorFromRGB(0x8fce4a,1.0f)];
        [uiTopichot setBackgroundColor:[UIColor clearColor]];
        [uiTopichot setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [uiTopichot setTextAlignment:NSTextAlignmentRight];
        
        uiTopictitle = [[UILabel alloc] init];
        [uiTopictitle setTextColor:UIColorFromRGB(0xa4866c,1.0f)];
        [uiTopictitle setBackgroundColor:[UIColor clearColor]];
        [uiTopictitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [uiTopictitle setTextAlignment:NSTextAlignmentLeft];
        
        uiTopicchannel = [[UILabel alloc] init];
        [uiTopicchannel setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiTopicchannel setBackgroundColor:[UIColor clearColor]];
        [uiTopicchannel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [uiTopictitle setTextAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:uiTopichot];
        [self.contentView addSubview:uiTopictitle];
        [self.contentView addSubview:uiTopicchannel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)start:(TopicItem*)pTopic
{
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    uiTopichot.frame = CGRectMake(0, 15, 45, 35);
    uiTopichot.text = [NSString stringWithFormat:@"%d",pTopic.hot];
    
    uiTopictitle.frame = CGRectMake(50, 15, mainFrame.size.width-50*2, 32);
    [uiTopictitle setNumberOfLines:0];
    [uiTopictitle setLineBreakMode:NSLineBreakByWordWrapping];
    NSString *text = [NSString stringWithFormat:@"#%@#",pTopic.title];
    uiTopictitle.text = text;
    //设置一个行高上限
    CGSize maxSize = CGSizeMake(mainFrame.size.width-50*2,64);
    NSDictionary *attribute = @{NSFontAttributeName: uiTopictitle.font};
    CGSize labelsize = [uiTopictitle.text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    uiTopictitle.frame = CGRectMake(50, 24, labelsize.width, labelsize.height);
    
    uiTopicchannel.frame = CGRectMake(50, uiTopictitle.frame.origin.y+uiTopictitle.frame.size.height, mainFrame.size.width-50, 22);
    uiTopicchannel.text = pTopic.channel;
    self.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, uiTopicchannel.frame.origin.y+uiTopicchannel.frame.size.height+15);
}

@end
