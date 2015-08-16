#import "FXLabel.h"
#import "MBProgressHUD.h"

typedef void(*CocosCallback)(int ret);

@interface BaseUIViewController : UIViewController <MBProgressHUDDelegate> {
    UIImageView             *baseNavBarHairlineImageView;
    MBProgressHUD           *baseHud;
    UIButton                *baseBackBtn;
    UIBarButtonItem         *baseBackBarBtn;
    FXLabel                 *baseTitle;
    UIBarButtonItem         *baseTitleBarBtn;
    CocosCallback           callback;
}

- (void)setCocosCallback:(CocosCallback)pCocosCallback;
- (void)baseShowTopHud:(NSString *)text;
- (void)baseShowMidHud:(NSString *)text;
- (void)baseShowBotHud:(NSString *)text;
- (void)baseDeckBack;
- (void)baseNavBack;
- (void)baseBack:(id)sender;

@end
