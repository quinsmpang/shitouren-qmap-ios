//
//  UserBaseInfoController.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/30.
//
//

#import "UserBaseInfoController.h"
#import "UserManager.h"

@interface UserBaseInfoController ()

@end

@implementation UserBaseInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0)];
    baseTitle.text = @"基本资料";
    
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    
    bEditState = NO;
    
    uiEditBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [uiEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [uiEditBtn setTitleColor:UIColorFromRGB(0x000000, 1.0f) forState:UIControlStateNormal];
    [uiEditBtn addTarget:self action:@selector(onEditInfo:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:uiEditBtn];
    
    uiEditBarBtn = [[UIBarButtonItem alloc] initWithCustomView:uiEditBtn];
    if (mainUser.userid == [UserManager sharedInstance].brief.userid)
    {
        self.navigationItem.rightBarButtonItem = uiEditBarBtn;
    }
    
    uiUserImage = [[UIImageView alloc]initWithFrame:CGRectMake((mainRect.size.width-70)/2, 50, 70, 70)];
    uiUserImage.layer.cornerRadius = uiUserImage.frame.size.width/2;
    uiUserImage.layer.backgroundColor = UIColorFromRGB(0xe6be78, 1.0f).CGColor;
    uiUserImage.layer.borderWidth = 3.0f;
    uiUserImage.layer.borderColor = UIColorFromRGB(0xff0000, 1.0f).CGColor;
    uiUserImage.clipsToBounds = YES;
//    [uiUserImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[UserManager sharedInstance].brief.imglink]]] forState:UIControlStateNormal];
    [uiUserImage setImage:[UIImage imageWithData:[UserManager sharedInstance].brief.thumbdata]];

    uiUserName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    CGSize size = [mainUser.name sizeWithFont:uiUserName.font];
    uiUserName.frame = CGRectMake((mainRect.size.width-size.width)/2, 125, size.width, size.height);
    uiUserName.text = mainUser.name;
    
    uiInfoView = [[UserBaseInfoView alloc]initWithFrame:CGRectMake(0, 180, mainRect.size.width, 200)];
    [uiInfoView setInfo:mainUser.zone :mainUser.intro ];
    
    
    uiEditView = [[UserBaseInfoEditView alloc]initWithFrame:CGRectMake(0, 180, mainRect.size.width, 200)];
    uiEditView.alpha = 0.0f;
    
    [self.view addSubview:uiUserImage];
    [self.view addSubview:uiUserName];
    
    [self.view addSubview:uiInfoView];
    [self.view addSubview:uiEditView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUserData:(long)userID :(NSString*) name :(NSString*)intro : (NSString*)zonename : (NSString*)thumblink : (NSString*)imglink
{
    mainUser = [[UserBriefItem alloc]init];
    mainUser.userid = userID;
    mainUser.name = name;
    mainUser.intro = intro;
    mainUser.zone = zonename;
    mainUser.thumblink = thumblink;
    mainUser.imglink = imglink;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)baseBack:(id)sender
{
    [self baseDeckAndNavBack];
    if( callback ){
        callback( 1 );
    }
}

- (void)onEditInfo:(id)sender
{
    NSLog(@"编辑。。。。。");
    if (bEditState)
    {
        // 提交修改的内容
        NSString *strIntro = [uiEditView getIntro];
        NSString *strZone = [uiEditView getZone];
        [self updateUserData:strIntro :strZone];
        
        
//        bEditState = NO;
//        [uiEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        
//        uiInfoView.alpha = 1.0f;
//        uiInfoView.transform = CGAffineTransformTranslate(uiInfoView.transform, uiInfoView.frame.size.width, 0.0f);
//        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(){
////            uiEditView.transform = CGAffineTransformScale(uiEditView.transform, 1.0f, 0.8f);
//            uiEditView.alpha = 0.0f;
//            uiInfoView.transform = CGAffineTransformTranslate(uiInfoView.transform, -uiInfoView.frame.size.width, 0.0f);
//            
//        } completion:^(BOOL bl){
//            
//        }];
    }else
    {
        bEditState = YES;
        [uiEditBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        uiEditView.alpha = 1.0f;
        uiEditView.transform = CGAffineTransformTranslate(uiEditView.transform, uiEditView.frame.size.width, 0.0f);
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(){
//            uiInfoView.transform = CGAffineTransformScale(uiInfoView.transform, 1.0f, 1.0f);
            uiInfoView.alpha = 0.0f;
            uiEditView.transform = CGAffineTransformTranslate(uiEditView.transform, -uiEditView.frame.size.width, 0.0f);
            
        } completion:^(BOOL bl){
            
        }];
    }
}

- (void)refreshUI
{
    bEditState = NO;
    [uiEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    NSString *strIntro = [uiEditView getIntro];
    NSString *strZone = [uiEditView getZone];
    [uiInfoView setInfo:strZone :strIntro];
    
    [UserManager sharedInstance].brief.intro = strIntro;
    [UserManager sharedInstance].brief.zone = strZone;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:strIntro forKey:@"SHITOUREN_UD_INTRO"];
    [defaults setObject:strZone forKey:@"SHITOUREN_UD_ZONE"];
    
    
    uiInfoView.alpha = 1.0f;
    uiInfoView.transform = CGAffineTransformTranslate(uiInfoView.transform, uiInfoView.frame.size.width, 0.0f);
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(){
        //            uiEditView.transform = CGAffineTransformScale(uiEditView.transform, 1.0f, 0.8f);
        uiEditView.alpha = 0.0f;
        uiInfoView.transform = CGAffineTransformTranslate(uiInfoView.transform, -uiInfoView.frame.size.width, 0.0f);
        
    } completion:^(BOOL bl){
        
    }];

}

- (void)updateUserData:(NSString*)intro :(NSString*)zone
{
    int index = 0;
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"intro\":\"%@\",\"zone\":\"%@\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], intro, zone];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_UPDATEBRIEF] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
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
//             NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//             for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//                 if( [[cookie name] isEqualToString:@"shitouren_check"] ){
//                     ss.ssid_check = [cookie value];
//                     NSLog(@"test1 --- %@", [cookie value]);
//                 }
//                 if( [[cookie name] isEqualToString:@"shitouren_verify"] ){
//                     ss.ssid_verify = [cookie value];
//                     NSLog(@"test2 --- %@", [cookie value]);
//                 }
//             }
             if (resRet == 0 ) {
                 if ( resIdx == index ) {
                     //                     loginCallback(1);
                     //                     [self refreshUI:resRes];
                     [self refreshUI];
                     
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

@end
