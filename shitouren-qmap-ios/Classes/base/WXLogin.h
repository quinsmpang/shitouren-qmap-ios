#import "WXApi.h"

@interface WXLoginInfo : NSObject
@property NSString *nickName;
@property NSString *headUrl;
@property NSString *openId;
@property NSString *unionId;
@end

typedef void (^Result)(WXLoginInfo *loginInfo);

@interface WXLogin : NSObject
/**
 *  设置单例模式
 */
+ (instancetype)sharedInstance;
@property(strong, nonatomic) UIViewController *delegate;
/**
 *  向微信发送结构体消息
 */
- (void)sendAuthRequest:(UIViewController*)pDelegate;
/**
 *  通过code换取access_token
 */
- (void)getAccess_TokenWithCode:(NSString *)code withResult:(Result)result;

@end