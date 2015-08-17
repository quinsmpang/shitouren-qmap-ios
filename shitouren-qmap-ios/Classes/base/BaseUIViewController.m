#import "BaseUIViewController.h"
#import "AppDelegate.h"
#import "LoggerClient.h"
#import "IIViewDeckController.h"

@implementation BaseUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    baseNavBarHairlineImageView = [self baseFindHairlineImageViewUnder:self.navigationController.navigationBar];
    
    baseHud = [[MBProgressHUD alloc] initWithView:self.view];
    baseHud.mode = MBProgressHUDModeText;
    baseHud.removeFromSuperViewOnHide = YES;
    
    baseBackBtn= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    //    [baseBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [baseBackBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-5,0,0)];
    //    [baseBackBtn setTitleColor:UIColorFromRGB(0x7F7F7F, 1.0f) forState:UIControlStateNormal];
    //    [baseBackBtn setImageEdgeInsets:UIEdgeInsetsMake(0,-10,0,0)];
    [baseBackBtn setImage:[UIImage imageNamed:@"base-1-1.png"] forState:UIControlStateNormal];
    [baseBackBtn addTarget:self action:@selector(baseBack:) forControlEvents:UIControlEventTouchUpInside];
    baseBackBarBtn = [[UIBarButtonItem alloc] initWithCustomView:baseBackBtn];
    
    baseTitle = [[FXLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    baseTitle.font = [UIFont boldSystemFontOfSize:20.0f];
    
    baseTitle.backgroundColor = [UIColor clearColor];
    baseTitle.textColor = UIColorFromRGB(0x7F7F7F, 1.0f);
    baseTitle.textAlignment = NSTextAlignmentCenter;
    baseTitleBarBtn = [[UIBarButtonItem alloc] initWithCustomView:baseTitle];
    
    //    funcBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 45, 30)];
    //    [funcBtn setTitle:@"完成" forState:UIControlStateNormal];
    //    funcBarBtn = [[UIBarButtonItem alloc] initWithCustomView:funcBtn];
    
    self.navigationItem.leftBarButtonItem = baseBackBarBtn;
    //    self.navigationItem.rightBarButtonItem = funcBarBtn;
    self.navigationItem.hidesBackButton  = YES;
    self.navigationItem.titleView = baseTitle;
    
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.size.height = 64;
    self.navigationController.navigationBar.frame = frame;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];  //设置背景
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    baseNavBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    baseNavBarHairlineImageView.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIImageView *)baseFindHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self baseFindHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setCocosCallback:(CocosCallback)pCocosCallback {
    callback = pCocosCallback;
}

- (void)baseShowTopHud:(NSString *)text {
    baseHud.yOffset = -180.0f;
    baseHud.labelText = text;
    [self.view addSubview:baseHud];
    baseHud.opacity = 0.7;
    [baseHud show:YES];
    [baseHud hide:YES afterDelay:1.5];
}

- (void)baseShowMidHud:(NSString *)text {
    baseHud.labelText = text;
    [self.view addSubview:baseHud];
    baseHud.opacity = 0.7;
    [baseHud show:YES];
    [baseHud hide:YES afterDelay:1.5];
}

- (void)baseShowBotHud:(NSString *)text {
    baseHud.yOffset = 180.0f;
    baseHud.labelText = text;
    [self.view addSubview:baseHud];
    baseHud.opacity = 0.7;
    [baseHud show:YES];
    [baseHud hide:YES afterDelay:1.5];
}
- (void)baseDeckAndNavBack {
    //    //ctrol现在是UITabBarController
    //    UITabBarController* ctrol=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    //切换第二视图
    //    [ctrol setSelectedIndex:0];
    
    //ctrol现在是IIViewDeckController
    IIViewDeckController* ctrol=(IIViewDeckController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    //切换第二视图
    [ctrol toggleTopViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
        [self baseNavBack];
    }];
}
- (void)baseDeckBack {
    //    //ctrol现在是UITabBarController
    //    UITabBarController* ctrol=(UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    //切换第二视图
    //    [ctrol setSelectedIndex:0];
    
    //ctrol现在是IIViewDeckController
    IIViewDeckController* ctrol=(IIViewDeckController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    //切换第二视图
    [ctrol toggleTopViewAnimated:YES];
}
- (void)baseNavBack {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)baseBack:(id)sender
{
    [self baseNavBack];
}

- (void)toCocos : (long) userID
                : (NSString *) name
                : (NSString *) intro
                : (NSString *) zone
                : (NSString *) thumblink
                : (NSString *) imglink
{
    if(toCocosCallback)
    {
        toCocosCallback(userID, name, intro, zone, thumblink, imglink);
    }
}

+ (void)setToCocosCallback:(ToCocosCallback)pToCocosCallback
{
    toCocosCallback = pToCocosCallback;
}

@end
