//
//  BuddyManager.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/22.
//
//

#import "BuddyManager.h"
#import "LoggerClient.h"
#import "UserManager.h"


@implementation BuddyManager

@synthesize frendList, fansList, ortherList, mainUser;

-(id)init {
    self = [super init];
    if (self) {
        frendList = [[NSMutableArray alloc] init];
        fansList = [[NSMutableArray alloc] init];
        ortherList = [[NSMutableArray alloc] init];
        mainUser = [[BuddyItem alloc]init];
    }
    return self;
}

NSString *testfrendData = @" \
{\"idx\":0,\"ret\":0,\"msg\":\"ok\",\"res\":[ \
{ \
\"userid\":100000, \
\"username\":\"大嘴鸟\", \
\"intro\":\"我的长项是低空飞行\", \
\"zone\":\"Home\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100001, \
\"username\":\"乱画师\", \
\"intro\":\"听说仰望天空能看到未来\", \
\"zone\":\"仰望之地\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100002, \
\"username\":\"摄手\", \
\"intro\":\"在很久以前其实叫处男座\", \
\"zone\":\"灵感的空间\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100003, \
\"username\":\"叶湘\", \
\"intro\":\"单核大萝卜\", \
\"zone\":\"大萝卜帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100004, \
\"username\":\"高翔\", \
\"intro\":\"群居为主单约为辅\", \
\"zone\":\"这个岛还缺一个女岛主\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100005, \
\"username\":\"岚妹子\", \
\"intro\":\"总是在累觉不爱的时候来桃花\", \
\"zone\":\"暮光之城\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100006, \
\"username\":\"无名\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100007, \
\"username\":\"张三\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100007, \
\"username\":\"李四\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100007, \
\"username\":\"王五\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100010, \
\"username\":\"赵六\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100011, \
\"username\":\"马大\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100012, \
\"username\":\"牛二\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
]} \
";

NSString *testfansData = @" \
{\"idx\":0,\"ret\":0,\"msg\":\"ok\",\"res\":[ \
{ \
\"userid\":100013, \
\"username\":\"宋江\", \
\"intro\":\"我的长项是低空飞行\", \
\"zone\":\"Home\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100014, \
\"username\":\"卢俊义\", \
\"intro\":\"听说仰望天空能看到未来\", \
\"zone\":\"仰望之地\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100015, \
\"username\":\"吴用\", \
\"intro\":\"在很久以前其实叫处男座\", \
\"zone\":\"灵感的空间\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100016, \
\"username\":\"公孙胜\", \
\"intro\":\"单核大萝卜\", \
\"zone\":\"大萝卜帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100017, \
\"username\":\"关胜\", \
\"intro\":\"群居为主单约为辅\", \
\"zone\":\"这个岛还缺一个女岛主\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100018, \
\"username\":\"林冲\", \
\"intro\":\"总是在累觉不爱的时候来桃花\", \
\"zone\":\"暮光之城\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100019, \
\"username\":\"鲁智深\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100020, \
\"username\":\"武松\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100021, \
\"username\":\"花荣\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100022, \
\"username\":\"李逵\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100023, \
\"username\":\"燕青\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100025, \
\"username\":\"呼延灼\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100031, \
\"username\":\"时迁\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
]} \
";

NSString *testortherData = @" \
{\"idx\":0,\"ret\":0,\"msg\":\"ok\",\"res\":[ \
{ \
\"userid\":100101, \
\"username\":\"诸葛亮\", \
\"intro\":\"我的长项是低空飞行\", \
\"zone\":\"Home\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100099, \
\"username\":\"刘备\", \
\"intro\":\"听说仰望天空能看到未来\", \
\"zone\":\"仰望之地\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100098, \
\"username\":\"曹操\", \
\"intro\":\"在很久以前其实叫处男座\", \
\"zone\":\"灵感的空间\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100050, \
\"username\":\"孙权\", \
\"intro\":\"单核大萝卜\", \
\"zone\":\"大萝卜帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100054, \
\"username\":\"关羽\", \
\"intro\":\"群居为主单约为辅\", \
\"zone\":\"这个岛还缺一个女岛主\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100065, \
\"username\":\"张飞\", \
\"intro\":\"总是在累觉不爱的时候来桃花\", \
\"zone\":\"暮光之城\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100206, \
\"username\":\"赵云\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100207, \
\"username\":\"吕布\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100407, \
\"username\":\"周瑜\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100507, \
\"username\":\"张郃\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100110, \
\"username\":\"鲁肃\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100111, \
\"username\":\"孙策\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
{ \
\"userid\":100112, \
\"username\":\"孙坚\", \
\"intro\":\"有时候想一句话很费劲\", \
\"zone\":\"桃花帝国\", \
\"imglink\":\"http://wx.qlogo.cn/mmopen/wcib2GksmGOkGrCbUocCQiaricFExz41y44ibJ2R1BH72aFrsY7iaabru23jORGhibCXrnIhDicMBLBP4Y0RUf0ums6mA/0\", \
}, \
]} \
";

- (void)requestData:(long)userid :(NSURL*)strUrl :(NSString*)type
{
    int index = 0;
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"userid\":\"%ld\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], userid];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:strUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"shitouren_qmap_ios" forHTTPHeaderField:@"User-Agent"];
    
    NSString *ssid = [UserManager sharedInstance].ss.ssid;
    NSString *ssid_check = [UserManager sharedInstance].ss.ssid_check;
    NSString *ssid_verify = [UserManager sharedInstance].ss.ssid_verify;
    NSDictionary *dictCookiessid = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_ssid", NSHTTPCookieName,
                                    ssid, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiessid = [NSHTTPCookie cookieWithProperties:dictCookiessid];
    
    NSDictionary *dictCookiecheck = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"shitouren_check", NSHTTPCookieName,
                                     ssid_check, NSHTTPCookieValue,
                                     @"/", NSHTTPCookiePath,
                                     SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                     nil];
    NSHTTPCookie *cookiecheck = [NSHTTPCookie cookieWithProperties:dictCookiecheck];
    
    NSDictionary *dictCookieverify = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"shitouren_verify", NSHTTPCookieName,
                                      ssid_verify, NSHTTPCookieValue,
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
             NSMutableDictionary *resRes = [resDict objectForKey:@"res"];
             if (resRet == 0 ) {
                 if ( resIdx == index ) {
                     for (NSDictionary* itemDict in resRes) {
                         BuddyItem *item = [[BuddyItem alloc] init];
                         item.userid = [[itemDict objectForKey:@"userid"] longValue];
                         item.name = [itemDict objectForKey:@"name"];
                         item.intro = [itemDict objectForKey:@"intro"];
                         item.zone = [itemDict objectForKey:@"zone"];
                         item.imglink = [itemDict objectForKey:@"imglink"];
                         item.relationship = [[itemDict objectForKey:@"type"] longValue];
                         if ([type isEqualToString:@"follow"]) {
                             [frendList addObject:item];
                         } else if ([type isEqualToString:@"fans"]){
                             [fansList addObject:item];
                         }
                         
                     }
                     
                     SendNotify(@"SHITOUREN_BUDDY_LIST_SUCC",type);
                     return;
                 } else {
                     // 已经是过期的请求
                 }
             } else {
                 NSLog(@"request false : %@",msg);
             }
         } else {
             if( [error code] == NSURLErrorTimedOut ){
                 //                 Log(@"request timeout");
             } else {
                 //                 Log(@"request err");
             }
         }
         //         loginCallback(0);
     }];
}

-(void)requestfrendData {
    
    [self requestData:20000007 :[NSURL URLWithString:SHITOUREN_API_USER_GETFOLLOW] :@"follow"];
    [self requestData:20000007 :[NSURL URLWithString:SHITOUREN_API_USER_GETFANS] :@"fans"];
    [self requestortherData];

}

-(void)requestfansData {
    NSError *error;
    NSData *testData = [testfansData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:&error ];
    //    int resIdx = [[resDict objectForKey:@"idx"] intValue];
    int resRet = [[resDict objectForKey:@"ret"] intValue];
    NSString *msg = [resDict objectForKey:@"msg"];
    NSArray *resRes = [resDict objectForKey:@"res"];
    if (resRet == 0){
        if (YES) {
            //      if ( resIdx == index ) {
            for (NSDictionary* itemDict in resRes) {
                BuddyItem *item = [[BuddyItem alloc] init];
                item.userid = [[itemDict objectForKey:@"userid"] longValue];
                item.name = [itemDict objectForKey:@"username"];
                item.intro = [itemDict objectForKey:@"intro"];
                item.zone = [itemDict objectForKey:@"zone"];
                item.imglink = [itemDict objectForKey:@"imglink"];
                [fansList addObject:item];
            }
        }
    }else {
        Log(@"request false : %@",msg);
        //        SendNotify(@"SHITOUREN_TOPIC_LIST_FAIL",resDict);
    }
    
    
}


-(void)requestortherData {
    NSError *error;
    NSData *testData = [testortherData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:testData options:NSJSONReadingMutableContainers error:&error ];
    //    int resIdx = [[resDict objectForKey:@"idx"] intValue];
    int resRet = [[resDict objectForKey:@"ret"] intValue];
    NSString *msg = [resDict objectForKey:@"msg"];
    NSArray *resRes = [resDict objectForKey:@"res"];
    if (resRet == 0){
        if (YES) {
            //      if ( resIdx == index ) {
            for (NSDictionary* itemDict in resRes) {
                BuddyItem *item = [[BuddyItem alloc] init];
                item.userid = [[itemDict objectForKey:@"userid"] longValue];
                item.name = [itemDict objectForKey:@"username"];
                item.intro = [itemDict objectForKey:@"intro"];
                item.zone = [itemDict objectForKey:@"zone"];
                item.imglink = [itemDict objectForKey:@"imglink"];
                [ortherList addObject:item];
            }
        }
    }else {
        Log(@"request false : %@",msg);
        //        SendNotify(@"SHITOUREN_TOPIC_LIST_FAIL",resDict);
    }
    
    
}


-(void)requestFollow:(long)userID
{
    int index = 0;
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"userid\":\"%ld\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], userID];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_FOLLOW] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"shitouren_qmap_ios" forHTTPHeaderField:@"User-Agent"];
    
    NSString *ssid = [UserManager sharedInstance].ss.ssid;
    NSString *ssid_check = [UserManager sharedInstance].ss.ssid_check;
    NSString *ssid_verify = [UserManager sharedInstance].ss.ssid_verify;
    NSDictionary *dictCookiessid = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"shitouren_ssid", NSHTTPCookieName,
                                    ssid, NSHTTPCookieValue,
                                    @"/", NSHTTPCookiePath,
                                    SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                    nil];
    NSHTTPCookie *cookiessid = [NSHTTPCookie cookieWithProperties:dictCookiessid];
    
    NSDictionary *dictCookiecheck = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"shitouren_check", NSHTTPCookieName,
                                     ssid_check, NSHTTPCookieValue,
                                     @"/", NSHTTPCookiePath,
                                     SHITOUREN_DOMAIN, NSHTTPCookieDomain,
                                     nil];
    NSHTTPCookie *cookiecheck = [NSHTTPCookie cookieWithProperties:dictCookiecheck];
    
    NSDictionary *dictCookieverify = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"shitouren_verify", NSHTTPCookieName,
                                      ssid_verify, NSHTTPCookieValue,
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
//             NSMutableDictionary *resRes = [resDict objectForKey:@"res"];
             if (resRet == 0 ) {
                 if ( resIdx == index ) {
//                     long relation =
//                     for (NSDictionary* itemDict in resRes) {
//                         BuddyItem *item = [[BuddyItem alloc] init];
//                         item.userid = [[itemDict objectForKey:@"userid"] longValue];
//                         item.name = [itemDict objectForKey:@"name"];
//                         item.intro = [itemDict objectForKey:@"intro"];
//                         item.zone = [itemDict objectForKey:@"zone"];
//                         item.imglink = [itemDict objectForKey:@"imglink"];
//                         item.relationship = [[itemDict objectForKey:@"type"] longValue];
//                         if ([type isEqualToString:@"follow"]) {
//                             [frendList addObject:item];
//                         } else if ([type isEqualToString:@"fans"]){
//                             [fansList addObject:item];
//                         }
//                         
//                     }
                     
//                     SendNotify(@"SHITOUREN_BUDDY_LIST_SUCC",type);
                     return;
                 } else {
                     // 已经是过期的请求
                 }
             } else {
                 NSLog(@"request false : %@",msg);
             }
         } else {
             if( [error code] == NSURLErrorTimedOut ){
                 //                 Log(@"request timeout");
             } else {
                 //                 Log(@"request err");
             }
         }
         //         loginCallback(0);
     }];
}

-(void)requestUnFollow:(long)userID
{
    
}

-(NSMutableArray*) getTableData:(int)index
{
    
    if (index == 1)
    {
        curList = fansList;
    }else if (index == 2)
    {
        curList = frendList;
    }else //if (index == 3)
    {
        curList = ortherList;
    }
    return curList;
}

-(BuddyItem*) getBoddyItem:(NSInteger)index
{
    BuddyItem *item = [curList objectAtIndex:index];
    return item;
}

@end
