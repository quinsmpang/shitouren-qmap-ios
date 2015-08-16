#import "NoteBanner.h"

@implementation NoteBanner

@synthesize uiBg, uiChannel,uiHot,uiLikeBtn,uiPostBtn,uiText,uiTitle;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
        mainFrame.origin = CGPointMake(0, 0);
        mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
        
        uiBg = [[UIImageView alloc] init];
        uiBg.backgroundColor = [UIColor whiteColor];
        uiBg.layer.cornerRadius = 10;
        uiBg.layer.masksToBounds = YES;
        
        uiChannel = [[UILabel alloc] init];
        [uiChannel setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiChannel setBackgroundColor:[UIColor greenColor]];
        [uiChannel setBackgroundColor:[UIColor clearColor]];
        [uiChannel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        
        uiTitle = [[UILabel alloc] init];
        [uiTitle setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiTitle setBackgroundColor:[UIColor greenColor]];
        [uiTitle setBackgroundColor:[UIColor clearColor]];
        [uiTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        
        uiText  = [[UILabel alloc] init];
        [uiText setTextColor:UIColorFromRGB(0xa4866c, 1.0f)];
        [uiText setBackgroundColor:[UIColor purpleColor]];
        [uiText setBackgroundColor:[UIColor clearColor]];
        [uiText setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        
        uiHot = [[UILabel alloc] init];
        [uiHot setTextColor:[UIColor orangeColor]];
        [uiHot setTextAlignment:NSTextAlignmentLeft];
        [uiHot setBackgroundColor:[UIColor blueColor]];
        [uiHot setBackgroundColor:[UIColor clearColor]];
        [uiHot setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        
        uiPostBtn = [[UIButton alloc] init];
        [uiPostBtn setBackgroundColor:[UIColor greenColor]];
        [uiPostBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [uiPostBtn setTitle:@"发表" forState:UIControlStateNormal];
        uiPostBtn.contentMode = UIViewContentModeScaleAspectFill;
        uiPostBtn.clipsToBounds = YES;
        uiPostBtn.layer.cornerRadius = 4;
        uiPostBtn.layer.masksToBounds = YES;
        [uiPostBtn addTarget:self action:@selector(goPost:) forControlEvents:UIControlEventTouchUpInside];
        
        uiLikeBtn = [[UIButton alloc] init];
        [uiLikeBtn setBackgroundColor:[UIColor grayColor]];
        [uiLikeBtn setBackgroundColor:[UIColor clearColor]];
        [uiLikeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [uiLikeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [uiLikeBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
        [uiLikeBtn setTitle:@"收藏" forState:UIControlStateNormal];
        uiLikeBtn.contentMode = UIViewContentModeScaleAspectFill;
        uiLikeBtn.clipsToBounds = YES;
        [uiLikeBtn addTarget:self action:@selector(goLike:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:uiBg];
        [self addSubview:uiChannel];
        [self addSubview:uiTitle];
        [self addSubview:uiText];
        [self addSubview:uiHot];
        [self addSubview:uiPostBtn];
        [self addSubview:uiLikeBtn];
    }
    return self;
}

- (void)start:(TopicItem *)pTopic :(id<NoteBannerDelegate>)pDelegate
{
    self.delegate = pDelegate;
    self.topic = pTopic;
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    
    uiChannel.frame = CGRectMake(20, 20, 100, 20);
    [uiChannel setNumberOfLines:1];
    [uiChannel setLineBreakMode:NSLineBreakByTruncatingTail];
    uiChannel.text = pTopic.channel;
    
    uiTitle.frame = CGRectMake(
                               50,
                               uiChannel.frame.origin.y+uiChannel.frame.size.height+5,
                               mainFrame.size.width-100,
                               60
                               );
    [uiTitle setNumberOfLines:0];
    [uiTitle setTextAlignment:NSTextAlignmentCenter];
    [uiTitle setLineBreakMode:NSLineBreakByWordWrapping];
    NSString *title = [NSString stringWithFormat:@"#%@#",pTopic.title];
    uiTitle.text = title;
    //设置一个行高上限
    CGSize titleMaxSize = CGSizeMake(
                                     mainFrame.size.width-100,
                                     60
                                     );
    NSDictionary *titleAttribute = @{NSFontAttributeName: uiTitle.font};
    CGSize titleLabelsize = [uiTitle.text boundingRectWithSize:titleMaxSize options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:titleAttribute context:nil].size;
    uiTitle.frame = CGRectMake(
                               (mainFrame.size.width-titleLabelsize.width)/2,
                               uiChannel.frame.origin.y+uiChannel.frame.size.height+5,
                               titleLabelsize.width,
                               titleLabelsize.height
                               );
    
    uiText.frame = CGRectMake(
                              20,
                              uiTitle.frame.origin.y+titleLabelsize.height+20,
                              mainFrame.size.width-40,
                              120
                              );
    [uiText setNumberOfLines:0];
    [uiText setTextAlignment:NSTextAlignmentCenter];
    [uiText setLineBreakMode:NSLineBreakByWordWrapping];
    NSString *summary = [NSString stringWithFormat:@"%@",pTopic.summary];
    uiText.text = summary;
    //设置一个行高上限
    CGSize textMaxSize = CGSizeMake(
                                    mainFrame.size.width-40,
                                    120
                                    );
    NSDictionary *textAttribute = @{NSFontAttributeName: uiText.font};
    CGSize textLabelsize = [uiText.text boundingRectWithSize:textMaxSize options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:textAttribute context:nil].size;
    uiText.frame = CGRectMake(
                              (mainFrame.size.width-textLabelsize.width)/2,
                              uiTitle.frame.origin.y+titleLabelsize.height+20,
                              textLabelsize.width,
                              textLabelsize.height
                              );
    
    uiHot.frame = CGRectMake(
                             20,
                             uiText.frame.origin.y+textLabelsize.height+20,
                             40,
                             24
                             );
    [uiHot setNumberOfLines:1];
    [uiHot setLineBreakMode:NSLineBreakByTruncatingTail];
    uiHot.text = [NSString stringWithFormat:@"%d",pTopic.hot];
    
    uiPostBtn.frame = CGRectMake(
                              uiHot.frame.origin.x+uiHot.frame.size.width,
                              uiText.frame.origin.y+textLabelsize.height+20,
                              80,
                              24
                              );
    uiLikeBtn.frame = CGRectMake(
                              mainFrame.size.width-80-20,
                              uiText.frame.origin.y+textLabelsize.height+20,
                              80,
                              24
                              );
    
    CGRect bgFrame = CGRectMake(10, 10, mainFrame.size.width-20, uiLikeBtn.frame.origin.y+uiLikeBtn.frame.size.height);
    uiBg.frame = bgFrame;
    
    self.frame = CGRectMake(0, 0, mainFrame.size.width, bgFrame.size.height+10);
}

-(void)goPost:(id)sender {
    if( delegate ){
        [delegate NBDpost:self.topic];
    }
}

-(void)goLike:(id)sender {
    if( delegate ){
        [delegate NBDlike:self.topic];
    }
}

@end
