#import "FXLabel.h"
#import "MBProgressHUD.h"

typedef void(*CocosCallback)(int ret);
typedef void(*ToCocosCallback)(long , NSString* , NSString* , NSString* , NSString*, NSString*);

static ToCocosCallback toCocosCallback;
@interface BaseUIViewController : UIViewController <MBProgressHUDDelegate,UIActionSheetDelegate> {
    UIImageView             *baseNavBarHairlineImageView;
    MBProgressHUD           *baseHud;
    UIButton                *baseBackBtn;
    UIBarButtonItem         *baseBackBarBtn;
    FXLabel                 *baseTitle;
    UIBarButtonItem         *baseTitleBarBtn;
    CocosCallback           callback;
    
    //    UIButton                *funcBtn;
    //    UIBarButtonItem         *funcBarBtn;
    
}

- (void)setCocosCallback:(CocosCallback)pCocosCallback;
- (void)baseShowTopHud:(NSString *)text;
- (void)baseShowMidHud:(NSString *)text;
- (void)baseShowBotHud:(NSString *)text;
- (void)baseDeckAndNavBack;
- (void)baseDeckBack;
- (void)baseNavBack;
- (void)baseBack:(id)sender;
- (void)toCocos : (long) userID
                : (NSString *)name
                : (NSString *)intro
                : (NSString *)zone
                : (NSString *)thumblink
                : (NSString *)imglink;

+ (void)setToCocosCallback:(ToCocosCallback)pToCocosCallback;

@end
