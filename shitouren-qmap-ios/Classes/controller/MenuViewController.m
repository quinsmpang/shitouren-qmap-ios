#import "MenuViewController.h"
#import "UserManager.h"

@implementation MenuViewController

@synthesize owner;
@synthesize userStateLogin,userStateLogout,currentUserState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userStateLogin =[[LVCUserStateLogin alloc]init:self];
    self.userStateLogout =[[LVCUserStateLogout alloc]init:self];
    [self getOn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UserManager *userManager = [UserManager sharedInstance];
//    if (userManager.base.userid != 0 ) {
//        [self setUserState:self.userStateLogin];
//    }else{
        [self setUserState:self.userStateLogout];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self getOff];
}

- (void)setUserState:(LVCUserStateBase *)newState {
    dispatch_async(dispatch_get_main_queue(), ^{
        currentUserState = newState;
        [currentUserState LVCstart];
    });
}

- (IBAction)goUser:(id)sender {
    [currentUserState LVCclick];
}
- (void)goLogin:(id)sender {
    [owner MVCgoLogin];
}
- (void)goBrief:(id)sender {
    [owner MVCgoBrief];
}
- (IBAction)goDetail:(id)sender {
    [owner MVCgoDetail];
}
- (IBAction)goTopic:(id)sender {
    [owner MVCgoTopic];
}
- (IBAction)goFeed:(id)sender {
    [owner MVCgoFeed];
}
- (IBAction)goBuddy:(id)sender {
    [owner MVCgoBuddy];
}
- (IBAction)goVisit:(id)sender {
    [owner MVCgoVisit];
}
- (IBAction)goAbout:(id)sender {
    [owner MVCgoAbout];
}
- (IBAction)goMessage:(id)sender {
    [owner MVCgoMessage];
}

- (void)getOn {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(login)
                                                 name: @"SHITOUREN_USER_SIGNIN_POST_SUCC"
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(logout)
                                                 name: @"SHITOUREN_USER_SIGNOUT_POST_SUCC"
                                               object: nil];
}

- (void)getOff {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHITOUREN_USER_SIGNIN_POST_SUCC" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHITOUREN_USER_SIGNOUT_POST_SUCC" object:nil];
}

- (void)login {
    [self setUserState:self.userStateLogin];
}

- (void)logout {
    [self setUserState:self.userStateLogout];
}

@end

#pragma mark -------LVCUserStateBase Class-------
@implementation LVCUserStateBase

-(id)init:(MenuViewController *)pOwner {
    self = [super init];
    if (self) {
        owner = pOwner;
    }
    return self;
}
@end

@implementation LVCUserStateLogin
-(void)LVCstart{
}
-(void)LVCclick{
    [owner.owner MVCgoBrief];
}
@end

@implementation LVCUserStateLogout
-(void)LVCstart{
}
-(void)LVCclick{
    [owner.owner MVCgoLogin];
}
@end

