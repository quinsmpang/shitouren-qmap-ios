//
//  UserDetailController.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/30.
//
//

#import "UserDetailController.h"


@interface UserDetailController ()

@end

@implementation UserDetailController

//NSArray *arrySex = [NSArray arrayWithObjects:@"男", @"女", @"双性恋", @"不确定", nil];

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arySex = [[NSArray alloc] initWithObjects:@"男", @"女", nil];
    arySexOT = [[NSArray alloc] initWithObjects:@"男", @"女", @"双性恋", @"不确定", nil];
    aryLove = [[NSArray alloc] initWithObjects:@"单身", @"非单身", @"保密", nil];
    aryHoro = [[NSArray alloc] initWithObjects:@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座", @"射手座", @"魔蝎座", @"水瓶座", @"双鱼座", nil];
    
    [self.view setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0)];
    baseTitle.text = @"个人详情";
    
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    
    uiUserImage = [[UIImageView alloc]initWithFrame:CGRectMake((mainRect.size.width-70)/2, 50, 70, 70)];
    uiUserImage.layer.cornerRadius = uiUserImage.frame.size.width/2;
    uiUserImage.layer.backgroundColor = UIColorFromRGB(0xe6be78, 1.0f).CGColor;
    uiUserImage.layer.borderWidth = 3.0f;
    uiUserImage.layer.borderColor = UIColorFromRGB(0xff0000, 1.0f).CGColor;
    uiUserImage.clipsToBounds = YES;
    //    [uiUserImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[UserManager sharedInstance].brief.imglink]]] forState:UIControlStateNormal];
    if (userBrief.thumbdata != nil)
    {
        [uiUserImage setImage:[UIImage imageWithData:userBrief.thumbdata]];
    }else
    {
        [uiUserImage setImage:[UIImage imageNamed:@"res/user/0.png"]];
    }
    
    uiUserName = [[UILabel alloc]initWithFrame:CGRectMake(0, 125, mainRect.size.width, 25)];
//    CGSize size = [[UserManager sharedInstance].brief.name sizeWithFont:uiUserName.font];
//    uiUserName.frame = CGRectMake((mainRect.size.width-size.width)/2, 125, size.width, size.height);
    uiUserName.textAlignment = NSTextAlignmentCenter;
    uiUserName.text = userBrief.name;
    
    NSString *strIntro = userBrief.intro;
//    strIntro = @"这家伙很懒，什么也没有留下";
    uiUserIntro = [[UILabel alloc]initWithFrame:CGRectMake(0, 155, mainRect.size.width, 25)];
    uiUserIntro.textAlignment = NSTextAlignmentCenter;
//    CGSize introSize = [strIntro sizeWithFont:uiUserIntro.font];
//    uiUserIntro.frame = CGRectMake((mainRect.size.width-introSize.width)/2, 125+size.height+10, introSize.width, introSize.height);
    uiUserIntro.text = strIntro;    //[UserManager sharedInstance].brief.intro;
    
    uiSexCaption = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiSex = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiSexBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiSexSV = [[UISelectView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
    [uiSexSV addSubItem:arySex];
    uiSexSV.alpha = 0.0f;
    
//    uiSexAS = [[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
//    uiSexAS = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:Nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    UIView *sexView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, 300)];
//    [uiSexAS addSubview:sexView];
//    uiSexAS.frame = CGRectMake(0, mainRect.size.height - 300, mainRect.size.width, mainRect.size.height);
    
//    [uiSexAS showInView:self.view];
    
    uiSexOTCaption = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiSexOT = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiSexOTBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    uiSexOTAS = [[UIActionSheet alloc]initWithTitle:@"title" delegate:self cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
    uiSexOTSV = [[UISelectView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
    [uiSexOTSV addSubItem:arySexOT];
    uiSexOTSV.alpha = 0.0f;

    uiLoveCaption = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiLove = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiLoveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    uiLoveAS = [[UIActionSheet alloc]initWithTitle:@"title" delegate:self cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
    uiLoveSV = [[UISelectView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
    [uiLoveSV addSubItem:aryLove];
    uiLoveSV.alpha = 0.0f;

    uiHoroCaption = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiHoro = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiHoroBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    uiHoroSV = [[UISelectView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
    [uiHoroSV addSubItem:aryHoro];
    uiHoroSV.alpha = 0.0f;

//    uiHoroAS = [[UIActionSheet alloc]initWithTitle:@"title" delegate:self cancelButtonTitle:@"确定" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
//    uiHoroAS = [[UIPickerView alloc]initWithFrame:CGRectMake(0, mainRect.size.height - 300, mainRect.size.width, 300)];
//    [uiHoroAS setDataSource:self];
//    [uiHoroAS setDelegate:self];
//    uiHoroAS.showsSelectionIndicator = YES;
//    [self.view addSubview:uiHoroAS];
    
//    UserDetailItem *userDetailItem = [UserManager sharedInstance].detail;
//    isLoginUser =
    
    [self setUserItemWithCaption:uiSexCaption Label:uiSex Button:uiSexBtn UISelectView:uiSexSV CaptionValue:@"性别" LabelValue:userDetail.sex index:1 NSArray:arySex];
    [self setUserItemWithCaption:uiSexOTCaption Label:uiSexOT Button:uiSexOTBtn UISelectView:uiSexOTSV  CaptionValue:@"性取向" LabelValue:userDetail.sexot index:2 NSArray:arySexOT];
    [self setUserItemWithCaption:uiLoveCaption Label:uiLove Button:uiLoveBtn UISelectView:uiLoveSV CaptionValue:@"情感状态" LabelValue:userDetail.love index:3 NSArray:aryLove];
    [self setUserItemWithCaption:uiHoroCaption Label:uiHoro Button:uiHoroBtn UISelectView:uiHoroSV CaptionValue:@"星座" LabelValue:userDetail.horo index:4 NSArray:aryHoro];
    
    
    [self.view addSubview:uiUserImage];
    [self.view addSubview:uiUserName];
    [self.view addSubview:uiUserIntro];
    [self.view addSubview:uiSexSV];
    [self.view addSubview:uiSexOTSV];
    [self.view addSubview:uiLoveSV];
    [self.view addSubview:uiHoroSV];
    
//    selView = [[UISelectView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
//    [selView addSubItem:[NSArray arrayWithObjects:@"水瓶座", @"白羊座", @"金牛座", @"双子座", @"狮子座", @"天蝎座", nil]];
////    [selView addSubItem:[NSArray arrayWithObjects:@"男", @"女", nil]];
//    [self.view addSubview:selView];
}

- (void)setUserItemWithCaption:(UILabel*)caption
                         Label:(UILabel*)label
                        Button:(UIButton*)button
                  UISelectView:(UISelectView*)selView
                  CaptionValue:(NSString*)strCaption
                    LabelValue:(NSString*)strValue
                         index:(long)index
                       NSArray:(NSArray*)aryList
{
    caption.font = [UIFont boldSystemFontOfSize:16];
    label.font = [UIFont boldSystemFontOfSize:20];
    
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    CGSize captionSize = [strCaption sizeWithFont:caption.font];
    CGSize labelSize = [strValue sizeWithFont:label.font];
    CGFloat width = captionSize.width + labelSize.width + 10;
    
    caption.frame = CGRectMake((mainRect.size.width - width)/2, 250 + index*50 - captionSize.height, captionSize.width, captionSize.height);
    label.frame = CGRectMake((mainRect.size.width - width)/2 + captionSize.width + 10, 250 + index*50 - labelSize.height, labelSize.width, labelSize.height);
    button.frame = CGRectMake((mainRect.size.width + width)/2 + 20, 250 + index*50 - 30+2, 30, 30);
    [button setImage:[UIImage imageNamed:@"base-3-1.png"] forState:UIControlStateNormal];
    button.tag = index;
    [button addTarget:self action:@selector(onCommand:) forControlEvents:UIControlEventTouchUpInside];
    
    caption.text = strCaption;
    label.text = strValue;
    
    long sefaultItemIndex = 0;
    long tempIndex = 0;
    for (NSString *item in aryList) {
        if ([item isEqualToString:strValue])
        {
            sefaultItemIndex = tempIndex;
            break;
        }
        tempIndex = tempIndex + 1;
    }
    
//    for (NSString *item in arySex) {
//        NSLog(@"item ...%@",item);
//    }
    [selView setDefaultSelectItem:index :sefaultItemIndex];
    selView.delegate = self;
    
    [self.view addSubview:caption];
    [self.view addSubview:label];
    
    if (userDetail.userid == [UserManager sharedInstance].detail.userid)
    {
        [self.view addSubview:button];
    }
//    [self.view addSubview:selView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserData:(long)userid
{
//    userID = userid;
    ss = [[UserSsItem alloc] init:userid];
    userBrief = [[UserBriefItem alloc]init:0];
    userDetail = [[UserDetailItem alloc]init:0];
    userBrief.userid = userid;
    userDetail.userid = userid;
    if (userDetail.userid == [UserManager sharedInstance].detail.userid)
    {
        userBrief.name = [UserManager sharedInstance].brief.name;
        userBrief.zone = [UserManager sharedInstance].brief.zone;
        userBrief.intro = [UserManager sharedInstance].brief.intro;
        userBrief.imglink = [UserManager sharedInstance].brief.imglink;
        userBrief.thumblink = [UserManager sharedInstance].brief.thumblink;
        userBrief.thumbdata = [UserManager sharedInstance].brief.thumbdata;
        userDetail.sex = [UserManager sharedInstance].detail.sex;
        userDetail.sexot = [UserManager sharedInstance].detail.sexot;
        userDetail.love = [UserManager sharedInstance].detail.love;
        userDetail.horo = [UserManager sharedInstance].detail.horo;
    }else
    {
        [self getNetData:20000023];
        
    }
}

- (void)refreshUI:(NSDictionary *)resRes
{
    NSLog(@"返回成功，刷新界面。。。。");

    userBrief.name = [(NSDictionary *)resRes objectForKey:@"name"];
    userBrief.intro = [(NSDictionary *)resRes objectForKey:@"intro"];
    userBrief.zone = [(NSDictionary *)resRes objectForKey:@"zone"];
    userBrief.imglink = [(NSDictionary *)resRes objectForKey:@"imglink"];
    userBrief.thumblink = [(NSDictionary *)resRes objectForKey:@"thumblink"];
    userBrief.thumbdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:userBrief.thumblink]];

    userDetail.sex = [(NSDictionary *)resRes objectForKey:@"sex"];
    userDetail.sexot = [(NSDictionary *)resRes objectForKey:@"sexot"];
    userDetail.love = [(NSDictionary *)resRes objectForKey:@"love"];
    userDetail.horo = [(NSDictionary *)resRes objectForKey:@"horo"];
//    Log ( @"userid=%ld,phone=%@,name=%@,sex=%@",self.userid,base.phone,brief.name,detail.sex);
    
    uiUserName.text = userBrief.name;
    uiUserIntro.text = userBrief.intro;
    [uiUserImage setImage:[UIImage imageWithData:userBrief.thumbdata]];
    
    [self refreshUserWithCaption:uiSexCaption Label:uiSex CaptionValue:@"性别" LabelValue:userDetail.sex index:1];
    [self refreshUserWithCaption:uiSexOTCaption Label:uiSexOT CaptionValue:@"性取向" LabelValue:userDetail.sexot index:2];
    [self refreshUserWithCaption:uiLoveCaption Label:uiLove CaptionValue:@"情感状态" LabelValue:userDetail.love index:3];
    [self refreshUserWithCaption:uiHoroCaption Label:uiHoro CaptionValue:@"星座" LabelValue:userDetail.horo index:4];
}

- (void)refreshUserWithCaption:(UILabel*)caption
                         Label:(UILabel*)label
                  CaptionValue:(NSString*)strCaption
                    LabelValue:(NSString*)strValue
                         index:(long)index
{
    caption.font = [UIFont boldSystemFontOfSize:16];
    label.font = [UIFont boldSystemFontOfSize:20];
    
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    CGSize captionSize = [strCaption sizeWithFont:caption.font];
    CGSize labelSize = [strValue sizeWithFont:label.font];
    CGFloat width = captionSize.width + labelSize.width + 10;
    
    caption.frame = CGRectMake((mainRect.size.width - width)/2, 250 + index*50 - captionSize.height, captionSize.width, captionSize.height);
    label.frame = CGRectMake((mainRect.size.width - width)/2 + captionSize.width + 10, 250 + index*50 - labelSize.height, labelSize.width, labelSize.height);
    
    caption.text = strCaption;
    label.text = strValue;
    
//    for (NSString *item in arySex) {
//        NSLog(@"item ...%@",item);
//    }

}


- (void)getNetData:(long)userID
{
    int index = 0;
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"userid\":%ld}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], userID];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_DETAIL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
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
//                     loginCallback(1);
                     [self refreshUI:resRes];
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

- (void)updateUserData:(long)style :(NSString*)strKey :(NSString*)strValue
{
    int index = 0;
    NSString *postData = [NSString stringWithFormat:@"{\"idx\":%d,\"ver\":\"%@\",\"params\":{\"%@\":\"%@\"}}",((++index)%1000),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], strKey, strValue];
    NSString *postStr = [NSString stringWithFormat:@"postData=%@",postData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SHITOUREN_API_USER_UPDATEDETAIL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
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
//             NSMutableDictionary *resRes = [resDict objectForKey:@"res"];
//             NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];

             if (resRet == 0 ) {
                 if ( resIdx == index ) {
                     //                     loginCallback(1);
//                     [self refreshUI:resRes];
                     [self saveUserData:style :strValue];
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

- (void)saveUserData:(long)style :(NSString*)value
{
    NSLog(@"save data...%ld,%@", style, value);
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    switch (style) {
        case 1:
            [UserManager sharedInstance].detail.sex = value;
            userDetail.sex = value;
            [defaults setObject:value forKey:@"SHITOUREN_UD_SEX"];
            [self refreshUserWithCaption:uiSexCaption Label:uiSex CaptionValue:@"性别" LabelValue:value index:1];
            uiSexSV.alpha = 0.0f;
            break;
        case 2:
            [UserManager sharedInstance].detail.sexot = value;
            userDetail.sexot = value;
            [defaults setObject:value forKey:@"SHITOUREN_UD_SEXOT"];
            [self refreshUserWithCaption:uiSexOTCaption Label:uiSexOT CaptionValue:@"性取向" LabelValue:value index:2];
            uiSexOTSV.alpha = 0.0f;
            break;
        case 3:
            [UserManager sharedInstance].detail.love = value;
            userDetail.love = value;
            [defaults setObject:value forKey:@"SHITOUREN_UD_LOVE"];
            [self refreshUserWithCaption:uiLoveCaption Label:uiLove CaptionValue:@"情感状态" LabelValue:value index:3];
            uiLoveSV.alpha = 0.0f;
            break;
        case 4:
            [UserManager sharedInstance].detail.horo = value;
            userDetail.horo = value;
            [defaults setObject:value forKey:@"SHITOUREN_UD_HORO"];
            [self refreshUserWithCaption:uiHoroCaption Label:uiHoro CaptionValue:@"星座" LabelValue:value index:4];
            uiHoroSV.alpha = 0.0f;
            break;
        default:
            break;
    }
}

-(void)onCommand:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSLog(@"click button %ld", button.tag);
//    [uiSexAS showInView:self.view];
    switch (button.tag) {
        case 1:
            uiSexSV.alpha = 1.0f;
            [uiSexSV fadeIn];
            break;
        case 2:
            uiSexOTSV.alpha = 1.0f;
            [uiSexOTSV fadeIn];
            break;
        case 3:
            uiLoveSV.alpha = 1.0f;
            [uiLoveSV fadeIn];
            break;
        case 4:
            uiHoroSV.alpha = 1.0f;
            [uiHoroSV fadeIn];
            break;
        default:
            break;
    }
    
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

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    BOOL canPick = YES;
    if (buttonIndex == 0) { // pick from camera
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            self.imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        }
//        else {
//            canPick = NO;
//#if IMAGE_PICKER_ERRLOG > 0
//            NSLog(@"[ImagePicker Error]: camera source not available");
//#endif
//        }
    }
    else if (buttonIndex == 1) { // pick from photo library
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//            self.imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        }
//        else {
//            canPick = NO;
//#if IMAGE_PICKER_ERRLOG > 0
//            NSLog(@"[ImagePicker Error]: photo library source not available");
//#endif
//        }
    }
    else {
//        canPick = NO;
//        executePickImageDoneCallback(false);
    }
    
//    if (canPick) {
//        [self.rootViewController presentViewController:self.imagePickController animated:YES completion:nil];
//    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark UIPickerViewDelegate

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 200;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    
//}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) // attributed title is favored if both methods are implemented
//{
//    
//}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"ceshi";
    label.textColor = UIColorFromRGB(0xff0000, 1.0f);
    return label;
}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    
//}

#pragma mark UISelectViewDelegate

-(void)selItemForSelectView:(long)styleIndex :(long)index
{
    NSLog(@"当前选择了%ld,%ld", styleIndex, index);
    switch (styleIndex) {
        case 1:
            [self updateUserData:styleIndex :@"sex" :[arySex objectAtIndex:index]];
            break;
        case 2:
            [self updateUserData:styleIndex :@"sexot" :arySexOT[index]];
            break;
        case 3:
            [self updateUserData:styleIndex :@"love" :aryLove[index]];
            break;
        case 4:
            [self updateUserData:styleIndex :@"horo" :aryHoro[index]];
            break;
            
        default:
            break;
    }
}

@end
