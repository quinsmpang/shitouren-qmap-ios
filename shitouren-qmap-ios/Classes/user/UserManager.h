#import "WXLogin.h"
#import "UserBaseItem.h"
#import "UserSsItem.h"
#import "UserBriefItem.h"
#import "UserDetailItem.h"


@interface UserManager : NSObject
{
    int index;
}
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(UserManager);

@property (assign, atomic) long             userid;
@property (copy, atomic) UserBaseItem       *base;
@property (copy, atomic) UserSsItem         *ss;
@property (copy, atomic) UserBriefItem      *brief;
@property (copy, atomic) UserDetailItem     *detail;

-(BOOL)validate:(void (^)(int ret)) loginCallback;
-(BOOL)signinWithPhone:(NSString *)pPhone passwd:(NSString *)pPasswd;
-(BOOL)signinWithWXLoginInfo:(WXLoginInfo *)pWXLoginInfo;
-(BOOL)signupVerify:(NSString *)pPhone;
-(BOOL)signupWithPhone:(NSString *)pPhone passwd:(NSString *)pPasswd verify:(NSString *)pVerify WXLoginInfo:(WXLoginInfo *)pWXLoginInfo;
-(void)signout;

@end
