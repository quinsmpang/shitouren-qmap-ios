#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "LoginViewController.h"
#import "TopicViewController.h"
#import "LoggerClient.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewDeckController;
@synthesize cocosViewController;
@synthesize iosNavController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:screenFrame];
    [self.window setBackgroundColor:[UIColor clearColor]];
    
    self.window.rootViewController.view.layer.cornerRadius = 4;
    self.window.rootViewController.view.layer.masksToBounds = YES;
    
    self.iosNavController = [[UINavigationController alloc] init];
    
    self.cocosViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    self.cocosViewController.owner = self;
    
    //用viewDeck实现切换
    iosNavController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    viewDeckController =  [[IIViewDeckController alloc] initWithCenterViewController:iosNavController topViewController:cocosViewController bottomViewController:nil];
    viewDeckController.topSize = 0.0;
    viewDeckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    viewDeckController.panningMode = IIViewDeckNoPanning;
    viewDeckController.shadowEnabled = NO;
    //    /* To adjust speed of open/close animations, set either of these two properties. */
    viewDeckController.openSlideAnimationDuration = 0.2f;
    viewDeckController.closeSlideAnimationDuration = 0.2f;
    self.window.rootViewController = viewDeckController;
    
    LoggerSetOptions(NULL, kLoggerOption_LogToConsole);
    
    [self.window makeKeyAndVisible];
    
    [viewDeckController toggleTopViewAnimated:NO];
    
    [[UIApplication sharedApplication] setStatusBarHidden: NO];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}


-(void)toIOS:(UIViewController *)vc
{
    //    //ctrol现在是UITabBarController
    //    UITabBarController* ctrol=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    //切换第二视图
    //    [ctrol setSelectedIndex:1];
    //    UINavigationController *nav = (UINavigationController*)([ctrol.childViewControllers objectAtIndex:1]);
    //    //现在用push而不是present将视图压栈
    //    [nav pushViewController:vc animated:NO];
    
    //ctrol现在是IIViewDeckController
    IIViewDeckController* ctrol=(IIViewDeckController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    //切换第二视图
    [ctrol toggleTopViewAnimated:YES];
    UINavigationController *nav = (UINavigationController*)(ctrol.centerController);
    //现在用push而不是present将视图压栈
    [nav pushViewController:vc animated:NO];
}

- (void)MVCgoLogin {
    LoginViewController *vc = [[LoginViewController alloc]  init];
    [self toIOS:vc];
}
- (void)MVCgoBrief {
    
}
- (void)MVCgoDetail {
    
}
- (void)MVCgoTopic {
    TopicViewController *vc = [[TopicViewController alloc]  init];
    [self toIOS:vc];
}
- (void)MVCgoFeed {
    
}
- (void)MVCgoBuddy {
    
}
- (void)MVCgoVisit {
    
}
- (void)MVCgoAbout {
    
}
- (void)MVCgoMessage {
    
}

@end
