#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BaseUIViewController.h"
#import "WXLogin.h"

@interface RegisterViewController : BaseUIViewController <UITextFieldDelegate>{
    MBProgressHUD       *hudLoading;
    UITextField         *uiPhone;
    UITextField         *uiVerify;
    UIButton            *uiVerifyBtn;
    UITextField         *uiPasswd;
    
    UIButton            *uiPhoto;
    UILabel             *uiName;
    
    UIImageView *uiBg;
    UIButton   *uiRegisterBtn;
    UILabel    *uiProtocolLabel;
    UIButton   *uiProtocolBtn;
}

@property (strong, atomic) WXLoginInfo *loginInfo;

@end
