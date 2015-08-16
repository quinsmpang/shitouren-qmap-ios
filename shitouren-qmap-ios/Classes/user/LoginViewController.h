#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BaseUIViewController.h"
#import "WXLogin.h"

@interface LoginViewController : BaseUIViewController <UITextFieldDelegate>{
    MBProgressHUD       *hudLoading;
    UITextField         *uiPhone;
    UITextField         *uiPasswd;
    
    UIImageView *uiPhoto;
    UIImageView *uiBg;
    UIImageView *uiPhoneIcon;
    UIImageView *uiPasswdIcon;
    UIButton   *uiLoginBtn;
    UIButton   *uiRegisterBtn;
    UIButton   *uiResetBtn;
}

-(void)doLogin:(id)sender;
-(void)goWXLogin:(id)sender;
-(void)wxCallback:(WXLoginInfo*)pWXLoginInfo;

@end
