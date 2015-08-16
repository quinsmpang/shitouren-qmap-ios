#import "UserManager.h"
#import "LoggerClient.h"
#import "NSString+MD5HMAC.h"

@implementation UserManager
SYNTHESIZE_SINGLETON_FOR_CLASS(UserManager);

@synthesize userid,base,ss,brief,detail;

-(id)init{
    self = [super init];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *tUserid = [defaults stringForKey:@"SHITOUREN_UD_USERID"];
    if( [tUserid isEqualToString:@"null"] ){
        userid = 0;
    }else{
        userid = [tUserid intValue];
    }
    index = 0;
    ss = [[UserSsItem alloc] init:userid];
    base = [[UserBaseItem alloc] init:userid];
    brief = [[UserBriefItem alloc] init:userid];
    detail = [[UserDetailItem alloc] init:userid];
    return self;
}

-(BOOL)validate:(void (^)(int ret)) loginCallback {
    if( [ss.ssid_check isEqualToString:@""] || [ss.ssid_verify isEqualToString:@""] ) {
        Log(@"no record");
        loginCallback(0);
        return NO;
    }
//    loginCallback(1);
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_VALIDATE] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"shitouren_qmap_ios" forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *dictCookiessid = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_ssid", NSHTTPCookieName,
                                    ss.ssid, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiessid = [NSHTTPCookie cookieWithProperties:dictCookiessid];
    
    NSDictionary *dictCookiecheck = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_check", NSHTTPCookieName,
                                    ss.ssid_check, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiecheck = [NSHTTPCookie cookieWithProperties:dictCookiecheck];
    
    NSDictionary *dictCookieverify = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"shitouren_verify", NSHTTPCookieName,
                                     ss.ssid_verify, NSHTTPCookieValue,
                                     @"/", NSHTTPCookiePath,
                                     SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                     nil];
    NSHTTPCookie *cookieverify = [NSHTTPCookie cookieWithProperties:dictCookieverify];
    
    NSArray *arrCookies = [NSArray arrayWithObjects: cookiessid,cookiecheck,cookieverify,nil];
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:arrCookies];
    [request setValue:[dictCookies objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    [NSURLConnection
     sendAsynchronousRequest  : request
     queue : [NSOperationQueue mainQueue]
     completionHandler : ^(NSURLResponse* response, NSData* data, NSError* error) {
         //         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         //         int responseStatusCode = [httpResponse statusCode];
         //         Log(@"status code : %d",responseStatusCode);
         if (error == nil) {
             NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             int resIdx = [[resDict objectForKey:@"idx"] intValue];
             int resRet = [[resDict objectForKey:@"ret"] intValue];
             NSString *msg = [resDict objectForKey:@"msg"];
             NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
             for (NSHTTPCookie *cookie in [cookieJar cookies]) {
                 if( [[cookie name] isEqualToString:@"shitouren_check"] ){
                     ss.ssid_check = [cookie value];
                     NSLog(@"test1 --- %@", [cookie value]);
                 }
                 if( [[cookie name] isEqualToString:@"shitouren_verify"] ){
                     ss.ssid_verify = [cookie value];
                     NSLog(@"test2 --- %@", [cookie value]);
                 }
             }
             if (resRet == 0 ) {
                 if ( resIdx == index ) {
                     loginCallback(1);
                     return;
                 } else {
                     // 已经是过期的请求
                 }
             } else {
                 Log(@"request false : %@",msg);
             }
         } else {
             if( [error code] == NSURLErrorTimedOut ){
                 Log(@"request timeout");
             } else {
                 Log(@"request err");
             }
         }
         loginCallback(0);
     }];
//    printBlock(0);
    return YES;
}

#pragma ----------登录方法----------
-(BOOL)signinWithPhone:(NSString *)pPhone passwd:(NSString *)pPasswd {
    NSString *md5hmacPasswd = [pPasswd MD5HMACWithKey:@"Sk4Ys7sPTx+gT5ssPHXV4ieKwPMKB0czjb+2rVfICMo="];
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"from\":\"phone\",\"phone\":\"%@\",\"passwd\":\"%@\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],pPhone,md5hmacPasswd];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_SIGNIN] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"shitouren_qmap_ios" forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *dictCookiessid = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_ssid", NSHTTPCookieName,
                                    ss.ssid, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiessid = [NSHTTPCookie cookieWithProperties:dictCookiessid];
    NSArray *arrCookies = [NSArray arrayWithObjects: cookiessid, nil];
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:arrCookies];
    [request setValue:[dictCookies objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    [NSURLConnection
     sendAsynchronousRequest  : request
     queue : [NSOperationQueue mainQueue]
     completionHandler : ^(NSURLResponse* response, NSData* data, NSError* error) {
         //         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         //         int responseStatusCode = [httpResponse statusCode];
         //         Log(@"status code : %d",responseStatusCode);
         if (error == nil) {
             NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             int resIdx = [[resDict objectForKey:@"idx"] intValue];
             int resRet = [[resDict objectForKey:@"ret"] intValue];
             NSString *msg = [resDict objectForKey:@"msg"];
             NSMutableDictionary *resRes = [resDict objectForKey:@"res"];
             NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
             for (NSHTTPCookie *cookie in [cookieJar cookies]) {
                 if( [[cookie name] isEqualToString:@"shitouren_check"] ){
                     ss.ssid_check = [cookie value];
                     NSLog(@"test1 --- %@", [cookie value]);
                 }
                 if( [[cookie name] isEqualToString:@"shitouren_verify"] ){
                     ss.ssid_verify = [cookie value];
                     NSLog(@"test2 --- %@", [cookie value]);
                 }
             }
             if (resRet == 0 ) {
                 if ( resIdx == index ) {
                     [self record:resRes];
                     SendNotify(@"SHITOUREN_USER_SIGNIN_PHONE_POST_SUCC",resRes);
                 } else {
                     // 已经是过期的请求
                 }
             } else {
                 Log(@"request false : %@",msg);
                 SendNotify(@"SHITOUREN_USER_SIGNIN_PHONE_POST_FAIL",msg);
             }
         } else {
             if( [error code] == NSURLErrorTimedOut ){
                 Log(@"request timeout");
                 SendNotify(@"SHITOUREN_USER_SIGNIN_PHONE_POST_TIMEOUT",nil);
             } else {
                 Log(@"request err");
                 SendNotify(@"SHITOUREN_USER_SIGNIN_PHONE_POST_ERR",nil);
             }
         }
     }];
    return YES;
}


#pragma ----------登录方法----------
-(BOOL)signinWithWXLoginInfo:(WXLoginInfo *)pWXLoginInfo
{
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"from\":\"weixin\",\"unionid\":\"%@\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],pWXLoginInfo.unionId];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_SIGNIN] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"shitouren_qmap_ios" forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *dictCookiessid = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_ssid", NSHTTPCookieName,
                                    ss.ssid, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiessid = [NSHTTPCookie cookieWithProperties:dictCookiessid];
    NSArray *arrCookies = [NSArray arrayWithObjects: cookiessid, nil];
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:arrCookies];
    [request setValue:[dictCookies objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    [NSURLConnection
     sendAsynchronousRequest  : request
     queue : [NSOperationQueue mainQueue]
     completionHandler : ^(NSURLResponse* response, NSData* data, NSError* error) {
         //         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         //         int responseStatusCode = [httpResponse statusCode];
         //         Log(@"status code : %d",responseStatusCode);
         if (error == nil) {
             NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             int resIdx = [[resDict objectForKey:@"idx"] intValue];
             int resRet = [[resDict objectForKey:@"ret"] intValue];
             NSString *msg = [resDict objectForKey:@"msg"];
             NSMutableDictionary *resRes = [resDict objectForKey:@"res"];
             NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
             for (NSHTTPCookie *cookie in [cookieJar cookies]) {
                 if( [[cookie name] isEqualToString:@"shitouren_check"] ){
                     ss.ssid_check = [cookie value];
                     NSLog(@"test1 --- %@", [cookie value]);
                 }
                 if( [[cookie name] isEqualToString:@"shitouren_verify"] ){
                     ss.ssid_verify = [cookie value];
                     NSLog(@"test2 --- %@", [cookie value]);
                 }
             }
             if (resRet == 0) {
                 if ( resIdx == index ) {
                     [self record:resRes];
                     SendNotify(@"SHITOUREN_USER_SIGNIN_WX_POST_SUCC",resRes);
                 } else {
                     // 已经是过期的请求
                 }
             } else if(resRet == 1){
                 if ( resIdx == index ) {
                     Log(@"this unionid needs signup : %@",pWXLoginInfo.unionId);
                     SendNotify(@"SHITOUREN_USER_SIGNIN_NEED_SIGNUP",pWXLoginInfo);
                 } else {
                     // 已经是过期的请求
                 }
             } else {
                 Log(@"request false : %@",msg);
                 SendNotify(@"SHITOUREN_USER_SIGNIN_WX_POST_FAIL",msg);
             }
         } else {
             if( [error code] == NSURLErrorTimedOut ){
                 Log(@"request timeout");
                 SendNotify(@"SHITOUREN_USER_SIGNIN_WX_POST_TIMEOUT",nil);
             } else {
                 Log(@"request err");
                 SendNotify(@"SHITOUREN_USER_SIGNIN_WX_POST_ERR",nil);
             }
         }
     }];
    return YES;
}


#pragma ----------发送手机验证码----------
-(BOOL)signupVerify:(NSString *)pPhone
{
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"phone\":\"%@\",\"type\":\"register\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],pPhone];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_SENDSMS] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"shitouren_qmap_ios" forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *dictCookiessid = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_ssid", NSHTTPCookieName,
                                    ss.ssid, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiessid = [NSHTTPCookie cookieWithProperties:dictCookiessid];
    NSArray *arrCookies = [NSArray arrayWithObjects: cookiessid, nil];
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:arrCookies];
    [request setValue:[dictCookies objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    [NSURLConnection
     sendAsynchronousRequest  : request
     queue : [NSOperationQueue mainQueue]
     completionHandler : ^(NSURLResponse* response, NSData* data, NSError* error) {
         //         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         //         int responseStatusCode = [httpResponse statusCode];
         //         Log(@"status code : %d",responseStatusCode);
         if (error == nil) {
             NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             int resIdx = [[resDict objectForKey:@"idx"] intValue];
             int resRet = [[resDict objectForKey:@"ret"] intValue];
             NSString *msg = [resDict objectForKey:@"msg"];
             NSMutableDictionary *resRes = [resDict objectForKey:@"res"];
             if (resRet == 0) {
                 if ( resIdx == index ) {
                     SendNotify(@"SHITOUREN_USER_SIGNUP_VERIFY_SUCC",resRes);
                 } else {
                     // 已经是过期的请求
                 }
             } else {
                 Log(@"request false : %@",msg);
                 SendNotify(@"SHITOUREN_USER_SIGNUP_VERIFY_FAIL",msg);
             }
         } else {
             if( [error code] == NSURLErrorTimedOut ){
                 Log(@"request timeout");
                 SendNotify(@"SHITOUREN_USER_SIGNUP_VERIFY_TIMEOUT",nil);
             } else {
                 Log(@"request err");
                 SendNotify(@"SHITOUREN_USER_SIGNUP_VERIFY_ERR",nil);
             }
         }
     }];
    return YES;
}

#pragma ---------注册方法----------
-(BOOL)signupWithPhone:(NSString *)pPhone passwd:(NSString *)pPasswd verify:(NSString *)pVerify WXLoginInfo:(WXLoginInfo *)pWXLoginInfo
{
    NSString *md5hmacPasswd = [pPasswd MD5HMACWithKey:@"Sk4Ys7sPTx+gT5ssPHXV4ieKwPMKB0czjb+2rVfICMo="];
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"from\":\"weixin\",\"phone\":\"%@\",\"passwd\":\"%@\",\"verify\":\"%@\",\"name\":\"%@\",\"headurl\":\"%@\",\"openid\":\"%@\",\"unionid\":\"%@\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],pPhone,md5hmacPasswd,pVerify,pWXLoginInfo.nickName,pWXLoginInfo.headUrl,pWXLoginInfo.openId,pWXLoginInfo.unionId];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_SIGNUP] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"shitouren_qmap_ios" forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *dictCookiessid = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_ssid", NSHTTPCookieName,
                                    ss.ssid, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiessid = [NSHTTPCookie cookieWithProperties:dictCookiessid];
    NSArray *arrCookies = [NSArray arrayWithObjects: cookiessid, nil];
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:arrCookies];
    [request setValue:[dictCookies objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    [NSURLConnection
     sendAsynchronousRequest  : request
     queue : [NSOperationQueue mainQueue]
     completionHandler : ^(NSURLResponse* response, NSData* data, NSError* error) {
         //         NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
         //         long responseStatusCode = [httpResponse statusCode];
         //         Log(@"status code : %ld %@",responseStatusCode,error.description);
         if (error == nil) {
             NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             int resIdx = [[resDict objectForKey:@"idx"] intValue];
             int resRet = [[resDict objectForKey:@"ret"] intValue];
             NSString *msg = [resDict objectForKey:@"msg"];
             NSMutableDictionary *resRes = [resDict objectForKey:@"res"];
             if (resRet == 0 ) {
                 if ( resIdx == index ) {
                     [self record:resRes];
                     SendNotify(@"SHITOUREN_USER_SIGNUP_POST_SUCC",resRes);
                     SendNotify(@"SHITOUREN_USER_SIGNIN_PHONE_POST_SUCC",resRes);
                 } else {
                     // 已经是过期的请求
                 }
             } else {
                 Log(@"request false : %@",msg);
                 SendNotify(@"SHITOUREN_USER_SIGNUP_POST_FAIL",msg);
             }
         } else {
             if( [error code] == NSURLErrorTimedOut ){
                 Log(@"request timeout");
                 SendNotify(@"SHITOUREN_USER_SIGNUP_POST_TIMEOUT",nil);
             } else {
                 Log(@"request err");
                 SendNotify(@"SHITOUREN_USER_SIGNUP_POST_ERR",nil);
             }
         }
     }];
    return YES;
}

-(void)record:(NSDictionary *)resRes
{
    long resUserid = [[(NSDictionary *)resRes objectForKey:@"userid"] longValue];
    self.userid = resUserid;
    ss.userid = resUserid;
    base.userid = resUserid;
    base.phone = [(NSDictionary *)resRes objectForKey:@"phone"];
    base.passwd = @"";
    brief.userid = resUserid;
    brief.name = [(NSDictionary *)resRes objectForKey:@"name"];
    brief.intro = [(NSDictionary *)resRes objectForKey:@"intro"];
    brief.zone = [(NSDictionary *)resRes objectForKey:@"zone"];
    brief.imglink = [(NSDictionary *)resRes objectForKey:@"imglink"];
    brief.thumblink = [(NSDictionary *)resRes objectForKey:@"thumblink"];
    brief.thumbdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:brief.thumblink]];
    detail.userid = resUserid;
    detail.sex = [(NSDictionary *)resRes objectForKey:@"sex"];
    detail.sexot = [(NSDictionary *)resRes objectForKey:@"sexot"];
    detail.love = [(NSDictionary *)resRes objectForKey:@"love"];
    detail.horo = [(NSDictionary *)resRes objectForKey:@"horo"];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%ld",ss.userid] forKey:@"SHITOUREN_UD_USERID"];
    [defaults setObject:ss.ssid_check forKey:@"SHITOUREN_UD_SSID_CHECK"];
    [defaults setObject:ss.ssid_verify forKey:@"SHITOUREN_UD_SSID_VERIFY"];
    [defaults setObject:base.phone forKey:@"SHITOUREN_UD_PHONE"];
    [defaults setObject:brief.name forKey:@"SHITOUREN_UD_NAME"];
    [defaults setObject:brief.intro forKey:@"SHITOUREN_UD_INTRO"];
    [defaults setObject:brief.zone forKey:@"SHITOUREN_UD_ZONE"];
    [defaults setObject:brief.imglink forKey:@"SHITOUREN_UD_IMGLINK"];
    [defaults setObject:brief.thumblink forKey:@"SHITOUREN_UD_THUMBLINK"];
    [defaults setObject:brief.thumbdata forKey:@"SHITOUREN_UD_THUMBDATA"];
    [defaults setObject:detail.sex forKey:@"SHITOUREN_UD_SEX"];
    [defaults setObject:detail.sexot forKey:@"SHITOUREN_UD_SEXOT"];
    [defaults setObject:detail.love forKey:@"SHITOUREN_UD_LOVE"];
    [defaults setObject:detail.horo forKey:@"SHITOUREN_UD_HORO"];
    Log ( @"userid=%ld,phone=%@,name=%@,sex=%@",self.userid,base.phone,brief.name,detail.sex);
}

-(void)signout{
    self.userid = 0;
    ss.userid = 0;
    ss.ssid_check = @"";
    ss.ssid_verify = @"";
    base.userid = 0;
    base.phone = @"";
    base.passwd = @"";
    brief.userid = 0;
    brief.name = @"";
    brief.intro = @"";
    brief.zone = @"";
    brief.imglink = @"";
    brief.thumblink = @"";
    brief.thumbdata = nil;
    detail.userid = 0;
    detail.sex = @"";
    detail.sexot = @"";
    detail.love = @"";
    detail.horo = @"";
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_PASSWD"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_SSID_CHECK"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_SSID_VERIFY"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_PHONE"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_PASSWD"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_NAME"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_INTRO"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_ZONE"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_IMGLINK"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_THUMBLINK"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_THUMBDATA"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_SEX"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_SEXOT"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_LOVE"];
    [defaults setObject:@"null" forKey:@"SHITOUREN_UD_HORO"];
    SendNotify(@"SHITOUREN_USER_SIGNOUT_POST_SUCC",self);
}

@end
