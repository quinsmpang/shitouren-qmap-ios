#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "MenuViewController.h"

@interface AppDelegate : UIResponder  <UIApplicationDelegate,MenuViewControllerDelegate> {
    UIImageView *splashView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IIViewDeckController       *viewDeckController;
@property (strong, nonatomic) MenuViewController         *cocosViewController;
@property (strong, nonatomic) UINavigationController     *iosNavController;

+ (AppDelegate *)sharedAppDelegate;
@end