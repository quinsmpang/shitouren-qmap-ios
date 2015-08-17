#import "TopicViewController.h"
#import "PostViewController.h"
#import "UserManager.h"
#import "NetworkManager.h"
#import "LoggerClient.h"

@implementation TopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    [self getOn];
    
    topicViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height)];
    [topicViewContainer setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [topicViewContainer setBackgroundColor:[UIColor clearColor]];
    self.view = topicViewContainer;
    
    topicView = [[TopicView alloc] initWithFrame:topicViewContainer.frame];
    topicView.delegate = self;
    [topicViewContainer addSubview:topicView];
    
    [topicView startList];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [topicView.listView.banner openTimer];//开启定时器
    });
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [topicView.listView.banner closeTimer];//关闭定时器
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)TVDback {
    [baseBackBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [self baseBack:nil];
}

- (void)TVDlist {
    baseTitle.text = @"发现";
    [baseBackBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [baseBackBtn addTarget:self action: @selector(baseBack:) forControlEvents: UIControlEventTouchUpInside];
}

- (void)TVDnote {
    baseTitle.text = @"话题";
    [baseBackBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [baseBackBtn addTarget: topicView action: @selector(back2list) forControlEvents: UIControlEventTouchUpInside];
}

- (void)TVDgallery {
    baseTitle.text = @"";
    [baseBackBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [baseBackBtn addTarget: topicView action: @selector(back2note) forControlEvents: UIControlEventTouchUpInside];
}

- (void)TVDpost:(TopicItem*)pNote {
    PostViewController *postVC = [[PostViewController alloc]  init];
    postVC.note = pNote;
    [self.navigationController pushViewController:postVC animated:NO];
}

- (void)TVDlike:(TopicItem*)pNote {
    
}

//- (void)TVDshare:(RongoShareItem*)pItem {
////    [self presentPopupViewController:RONGO_ARC_AUTORELEASE([[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil]) animationType:MJPopupViewAnimationFade];
////    [[ShareManager sharedInstance] shareRongo:pItem :self];
//}


- (void)baseBack:(id)sender
{
    [self getOff];
    [self baseDeckAndNavBack];
    if( callback ){
        callback( YES );
    }
}

- (void)getOn {
    AddObserver(nsFail:, @"SHITOUREN_TOPIC_LIST_FAIL");
    AddObserver(nsFail:, @"SHITOUREN_TOPIC_LIKE_POST_FAIL");
    AddObserver(nsFail:, @"SHITOUREN_TOPIC_LIKE_DEL_FAIL");
}

- (void)getOff {
    DelObserver(@"SHITOUREN_TOPIC_LIST_FAIL");
    DelObserver(@"SHITOUREN_TOPIC_LIKE_POST_FAIL");
    DelObserver(@"SHITOUREN_TOPIC_LIKE_DEL_FAIL");
}


-(void)nsFail:(NSNotification *)notification {
    NSString *msg = (NSString*)(notification.object);
    [self baseShowBotHud:NSLocalizedString(msg, @"")];
}

@end
