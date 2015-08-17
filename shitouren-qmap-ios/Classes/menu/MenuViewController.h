#import "BaseUIViewController.h"
#import "WXLogin.h"

@protocol MenuViewControllerDelegate;
@protocol LVCUserStateDelegate;
@class LVCUserStateLogin;
@class LVCUserStateLogout;
@class LVCUserStateBase;
@protocol LVCSelectDelegate;

@interface MenuViewController : BaseUIViewController<UISearchBarDelegate>
{
    IBOutlet UIButton *btnUser;
    IBOutlet UIButton *btnDetail;
    IBOutlet UIButton *btnTopic;
    IBOutlet UIButton *btnFeed;
    IBOutlet UIButton *btnBuddy;
    IBOutlet UIButton *btnVisit;
    IBOutlet UIButton *btnAbout;
    IBOutlet UIButton *btnMessage;
    UITapGestureRecognizer *tapGesture;
}
@property (retain, nonatomic) LVCUserStateLogin             *userStateLogin;
@property (retain, nonatomic) LVCUserStateLogout            *userStateLogout;
@property (retain, nonatomic) LVCUserStateBase              *currentUserState;

- (IBAction)goUser:(id)sender;
- (void)goLogin:(id)sender;
- (void)goBrief:(id)sender;
- (IBAction)goDetail:(id)sender;
- (IBAction)goTopic:(id)sender;
- (IBAction)goFeed:(id)sender;
- (IBAction)goBuddy:(id)sender;
- (IBAction)goVisit:(id)sender;
- (IBAction)goAbout:(id)sender;
- (IBAction)goMessage:(id)sender;

- (void)setUserState:(LVCUserStateBase *)newState;

@property (assign, nonatomic) id <MenuViewControllerDelegate> owner;

@end

@protocol MenuViewControllerDelegate<NSObject>

@optional
- (void)MVCgoLogin;
- (void)MVCgoBrief;
- (void)MVCgoDetail;
- (void)MVCgoTopic;
- (void)MVCgoFeed;
- (void)MVCgoBuddy;
- (void)MVCgoVisit;
- (void)MVCgoAbout;
- (void)MVCgoMessage;

@end

#pragma mark ---------用户是否登录的状态机-----
@protocol LVCUserStateDelegate<NSObject>
@optional
-(void)LVCstart;
-(void)LVCclick;
@end

@interface LVCUserStateBase : NSObject<LVCUserStateDelegate>
{
    MenuViewController *owner;
}
-(id)init:(MenuViewController *)pOwner;
@end

@interface LVCUserStateLogin : LVCUserStateBase
@end

@interface LVCUserStateLogout : LVCUserStateBase
@end
