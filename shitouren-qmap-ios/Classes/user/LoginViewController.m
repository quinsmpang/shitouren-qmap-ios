#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserManager.h"
#import "NetworkManager.h"
#import "LoggerClient.h"
#import "AppDelegate+WXLogin.h"

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColorFromRGB(0xEBEEF0, 1.0f)];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    baseTitle.text = @"登录";
    
    uiPhoto = [[UIImageView alloc] initWithFrame:CGRectMake((applicationFrame.size.width-70)/2, 75, 70, 70)];
    uiPhoto.image = [UIImage imageNamed:@"register-done-2-1.png"];
    
    uiBg = [[UIImageView alloc] initWithFrame:CGRectMake(0,170,applicationFrame.size.width, 100)];
    uiBg.image = [UIImage imageNamed:@"login-3-1.png"];
    
    uiPhoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12,182,23,23)];
    uiPhoneIcon.image = [UIImage imageNamed:@"login-4-1.png"];
    
    uiPasswdIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12,230,23,23)];
    uiPasswdIcon.image = [UIImage imageNamed:@"login-5-1.png"];
    
    uiPhone = [[UITextField alloc] initWithFrame:CGRectMake(uiBg.frame.origin.x+50, uiBg.frame.origin.y+7, 230, 40)];
    uiPhone.delegate = self;
    uiPhone.keyboardType = UIKeyboardTypeNumberPad;
    uiPhone.returnKeyType = UIReturnKeyNext;
    uiPhone.borderStyle = UITextBorderStyleNone;
    uiPhone.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    if( [UserManager sharedInstance].base.phone != nil ){
        uiPhone.text = [UserManager sharedInstance].base.phone;
    }else{
        uiPhone.placeholder = @"手机号";
    }
    [uiPhone addTarget:self action:@selector(textFieldGoToNext:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    uiPasswd = [[UITextField alloc] initWithFrame:CGRectMake(uiBg.frame.origin.x+50, uiBg.frame.origin.y+57, 230, 40)];
    uiPasswd.delegate = self;
    uiPasswd.returnKeyType = UIReturnKeyDone;
    uiPasswd.borderStyle = UITextBorderStyleNone;
    uiPasswd.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    uiPasswd.placeholder = @"密码";
    [uiPasswd setSecureTextEntry:YES];
    [uiPasswd addTarget:self action:@selector(textFieldGoToNext:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    uiLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 290, applicationFrame.size.width-10, 48)];
    [uiLoginBtn setBackgroundImage:[UIImage imageNamed:@"login-6-1.png"] forState:UIControlStateNormal];
    [uiLoginBtn setBackgroundImage:[UIImage imageNamed:@"login-6-2.png"] forState:UIControlStateHighlighted];
    [uiLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    uiResetBtn = [[UIButton alloc]initWithFrame:CGRectMake(applicationFrame.size.width-110,uiLoginBtn.frame.origin.y+uiLoginBtn.frame.size.height+10, 100,30)];
    [uiResetBtn setTitle:@"登录遇到问题?" forState:UIControlStateNormal];
    [uiResetBtn setTitleColor:UIColorFromRGB(0x929292, 1.0f) forState:UIControlStateNormal];
    uiResetBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14.0f];
    
    uiRegisterBtn = [[UIButton alloc]initWithFrame:CGRectMake((applicationFrame.size.width-150)/2,applicationFrame.size.height-140, 150,40)];
    [uiRegisterBtn setTitle:@"用微信账号登录" forState:UIControlStateNormal];
    [uiRegisterBtn setTitleColor:UIColorFromRGB(0x51BFB1, 1.0f) forState:UIControlStateNormal];
    [uiRegisterBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    uiRegisterBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:16.0f];
    
    [self.view addSubview:uiPhoto];
    [self.view addSubview:uiBg];
    [self.view addSubview:uiPhoneIcon];
    [self.view addSubview:uiPasswdIcon];
    [self.view addSubview:uiPhone];
    [self.view addSubview:uiPasswd];
    [self.view addSubview:uiLoginBtn];
//    [self.view addSubview:uiResetBtn];
    [self.view addSubview:uiRegisterBtn];
    
    [uiLoginBtn addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    [uiResetBtn addTarget:self action:@selector(goReset:) forControlEvents:UIControlEventTouchUpInside];
    [uiRegisterBtn addTarget:self action:@selector(goWXLogin:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if( [UserManager sharedInstance].userid != 0 ){
        [self baseBack:nil];
    }else{
        [self getOn];
    }
}

-(void)textFieldGoToNext:(id)sender
{
    if( sender == uiPhone ){
        [sender resignFirstResponder];
        [uiPasswd becomeFirstResponder];
    }else if(sender == uiPasswd){
        [sender resignFirstResponder];
    }
}

- (void)goReset:(id)sender {
    [uiPhone resignFirstResponder];
    [uiPasswd resignFirstResponder];
}

-(void)goWXLogin:(id)sender {
    [uiPhone resignFirstResponder];
    [uiPasswd resignFirstResponder];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate WXLogin:self];
}

-(void)wxCallback:(WXLoginInfo*)pWXLoginInfo
{
    hudLoading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudLoading.labelText = @"正在验证...";
    hudLoading.opacity = 0.7;
    [[UserManager sharedInstance] signinWithWXLoginInfo:pWXLoginInfo];
}

- (void)doLogin:(id)sender
{
    [uiPhone resignFirstResponder];
    [uiPasswd resignFirstResponder];
    
    NSString *phoneRegex = @"^1[358][0-9]{9}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isPhoneValid = [phonePredicate evaluateWithObject:uiPhone.text];
    if (!isPhoneValid){
        [self baseShowBotHud:NSLocalizedString(@"请输入正确的手机号", @"")];
        [uiPhone becomeFirstResponder];
        return;
    }
    
    NSString *uiPasswdRegex = @"^\\S{6,20}$";
    NSPredicate *uiPasswdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", uiPasswdRegex];
    BOOL isuiPasswdValid = [uiPasswdPredicate evaluateWithObject:uiPasswd.text];
    //密码验证
    if (!isuiPasswdValid) {
        [self baseShowBotHud:NSLocalizedString(@"请使用6~20位的密码", @"")];
        [uiPasswd becomeFirstResponder];
        uiPasswd.text = nil;
        return;
    }
    
    if (![[NetworkManager sharedInstance]hasNetwork]) {
        [self baseShowBotHud:@"没有网络连接"];
        return;
    }
    
    hudLoading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudLoading.labelText = @"正在登录...";
    hudLoading.opacity = 0.7;
    [[UserManager sharedInstance] signinWithPhone:uiPhone.text passwd:uiPasswd.text];

}

- (void)getOn {
    AddObserver(nsSigninSucc:,@"SHITOUREN_USER_SIGNIN_PHONE_POST_SUCC");
    AddObserver(nsSigninFail:,@"SHITOUREN_USER_SIGNIN_PHONE_POST_FAIL");
    AddObserver(nsSigninErr:,@"SHITOUREN_USER_SIGNIN_PHONE_POST_ERR");
    AddObserver(nsSigninTimeout:,@"SHITOUREN_USER_SIGNIN_PHONE_POST_TIMEOUT");
    AddObserver(nsSigninSucc:,@"SHITOUREN_USER_SIGNIN_WX_POST_SUCC");
    AddObserver(nsSigninFail:,@"SHITOUREN_USER_SIGNIN_WX_POST_FAIL");
    AddObserver(nsSigninErr:,@"SHITOUREN_USER_SIGNIN_WX_POST_ERR");
    AddObserver(nsSigninTimeout:,@"SHITOUREN_USER_SIGNIN_WX_POST_TIMEOUT");
    AddObserver(nsSigninNeedSignup:,@"SHITOUREN_USER_SIGNIN_NEED_SIGNUP");
}

- (void)getOff {
    DelObserver(@"SHITOUREN_USER_SIGNIN_PHONE_POST_SUCC");
    DelObserver(@"SHITOUREN_USER_SIGNIN_PHONE_POST_FAIL");
    DelObserver(@"SHITOUREN_USER_SIGNIN_PHONE_POST_ERR");
    DelObserver(@"SHITOUREN_USER_SIGNIN_PHONE_POST_TIMEOUT");
    DelObserver(@"SHITOUREN_USER_SIGNIN_WX_POST_SUCC");
    DelObserver(@"SHITOUREN_USER_SIGNIN_WX_POST_FAIL");
    DelObserver(@"SHITOUREN_USER_SIGNIN_WX_POST_ERR");
    DelObserver(@"SHITOUREN_USER_SIGNIN_WX_POST_TIMEOUT");
    DelObserver(@"SHITOUREN_USER_SIGNIN_NEED_SIGNUP");
}

-(void)nsSigninSucc:(NSNotification *)notification {
    [hudLoading hide:YES];
    [self baseBack:nil];
}
-(void)nsSigninFail:(NSNotification *)notification {
    [hudLoading hide:YES];
    NSString *msg = (NSString*)(notification.object);
    [self baseShowBotHud:NSLocalizedString(msg, @"")];
}
-(void)nsSigninErr:(NSNotification *)notification {
    [hudLoading hide:YES];
}
-(void)nsSigninTimeout:(NSNotification *)notification {
    [hudLoading hide:YES];
}
-(void)nsSigninNeedSignup:(NSNotification *)notification {
    [hudLoading hide:YES];
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    WXLoginInfo *loginInfo = (WXLoginInfo*)(notification.object);
    registerVC.loginInfo = loginInfo;
    [[WXLogin sharedInstance].delegate.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        switch (indexPath.row) {
            case 0://
                cell.accessoryView = uiPhone;
                break;
            case 1://
                cell.accessoryView = uiPasswd;
                break;
            default://
                break;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)baseBack:(id)sender
{
    [uiPhone resignFirstResponder];
    [uiPasswd resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        if( callback ){
            callback( ([UserManager sharedInstance].userid>0) );
        }
    }];
}

@end
