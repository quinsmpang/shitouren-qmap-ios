#import "RegisterViewController.h"
#import "UserManager.h"
#import "NetworkManager.h"
#import "UIImageView+WebCache.h"

@implementation RegisterViewController

@synthesize loginInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColorFromRGB(0xEBEEF0, 1.0f)];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    baseTitle.text = @"注册";
    
    uiPhoto = [[UIButton alloc]initWithFrame:CGRectMake((applicationFrame.size.width-80)/2, 80, 80, 80)];
    //告诉layer将位于它之下的layer都遮盖住
    uiPhoto.layer.masksToBounds = YES;
    //设置layer的圆角,刚好是自身宽度的一半，这样就成了圆形
    uiPhoto.layer.cornerRadius = uiPhoto.bounds.size.width * 0.5;
    //设置边框的宽度为20
    uiPhoto.layer.borderWidth = 2.0;
    //设置边框的颜色
    uiPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    
    uiName = [[UILabel alloc]initWithFrame:CGRectMake((applicationFrame.size.width-160)/2,uiPhoto.frame.origin.y+uiPhoto.frame.size.height+10,160,30)];
    [uiName setTextColor:UIColorFromRGB(0x929292, 1.0f)];
    [uiName setTextAlignment:NSTextAlignmentCenter];
    uiName.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:13.0f];
    
    uiBg = [[UIImageView alloc] initWithFrame:CGRectMake(0,uiName.frame.origin.y+uiName.frame.size.height+10,applicationFrame.size.width, 150)];
    uiBg.image = [UIImage imageNamed:@"register-2-1.png"];
    
    uiPhone = [[UITextField alloc] initWithFrame:CGRectMake(uiBg.frame.origin.x +20, uiBg.frame.origin.y+7, 230, 40)];
    uiPhone.delegate = self;
    uiPhone.keyboardType = UIKeyboardTypeNumberPad;
    uiPhone.returnKeyType = UIReturnKeyNext;
    uiPhone.borderStyle = UITextBorderStyleNone;
    uiPhone.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    if( [UserManager sharedInstance].base.phone != nil ){
        uiPhone.text = [UserManager sharedInstance].base.phone;
    }else{
        uiPhone.placeholder = @"请输入手机号";
    }
    [uiPhone addTarget:self action:@selector(textFieldGoToNext:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    uiVerify = [[UITextField alloc] initWithFrame:CGRectMake(uiBg.frame.origin.x +20, uiBg.frame.origin.y+57, 130, 40)];
    uiVerify.delegate = self;
    uiVerify.keyboardType = UIKeyboardTypeNumberPad;
    uiVerify.returnKeyType = UIReturnKeyDone;
    uiVerify.borderStyle = UITextBorderStyleNone;
    uiVerify.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    uiVerify.placeholder = @"请输入验证码";
    [uiVerify setSecureTextEntry:YES];
    [uiVerify addTarget:self action:@selector(textFieldGoToNext:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    uiVerifyBtn = [[UIButton alloc]initWithFrame:CGRectMake(uiBg.frame.origin.x+uiBg.frame.size.width-105, uiBg.frame.origin.y+57, 100, 40)];
    [uiVerifyBtn setBackgroundImage:[UIImage imageNamed:@"register-3-1.png"] forState:UIControlStateNormal];
    [uiVerifyBtn setBackgroundImage:[UIImage imageNamed:@"register-3-2.png"] forState:UIControlStateHighlighted];
    [uiVerifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    uiPasswd = [[UITextField alloc] initWithFrame:CGRectMake(uiBg.frame.origin.x +20, uiBg.frame.origin.y+107, 230, 40)];
    uiPasswd.delegate = self;
    uiPasswd.returnKeyType = UIReturnKeyDone;
    uiPasswd.borderStyle = UITextBorderStyleNone;
    uiPasswd.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    uiPasswd.placeholder = @"请输入您的密码";
    [uiPasswd setSecureTextEntry:YES];
    [uiPasswd addTarget:self action:@selector(textFieldGoToNext:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    uiRegisterBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, uiBg.frame.origin.y+167, applicationFrame.size.width-10, 48)];
    [uiRegisterBtn setBackgroundImage:[UIImage imageNamed:@"register-3-1.png"] forState:UIControlStateNormal];
    [uiRegisterBtn setBackgroundImage:[UIImage imageNamed:@"register-3-2.png"] forState:UIControlStateHighlighted];
    [uiRegisterBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    uiProtocolLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,uiRegisterBtn.frame.origin.y+uiRegisterBtn.frame.size.height+5, 160,30)];
    [uiProtocolLabel setText:@"注册代表您已经阅读并同意"];
    [uiProtocolLabel setTextColor:UIColorFromRGB(0x929292, 1.0f)];
    uiProtocolLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:13.0f];
    
    uiProtocolBtn = [[UIButton alloc]initWithFrame:CGRectMake(165,uiRegisterBtn.frame.origin.y+uiRegisterBtn.frame.size.height+5, 60,30)];
    [uiProtocolBtn setTitle:@"用户协议" forState:UIControlStateNormal];
    [uiProtocolBtn setTitleColor:UIColorFromRGB(0x929292, 1.0f) forState:UIControlStateNormal];
    uiProtocolBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14.0f];
    
    [self.view addSubview:uiPhoto];
    [self.view addSubview:uiName];
    [self.view addSubview:uiBg];
    [self.view addSubview:uiPhone];
    [self.view addSubview:uiVerify];
    [self.view addSubview:uiVerifyBtn];
    [self.view addSubview:uiPasswd];
    [self.view addSubview:uiRegisterBtn];
    [self.view addSubview:uiProtocolLabel];
    [self.view addSubview:uiProtocolBtn];
    
    [uiVerifyBtn addTarget:self action:@selector(doVerify:) forControlEvents:UIControlEventTouchUpInside];
    [uiRegisterBtn addTarget:self action:@selector(doRegister:) forControlEvents:UIControlEventTouchUpInside];
    [uiProtocolBtn addTarget:self action:@selector(goProtocol:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getOn];
    if( self.loginInfo != nil ){
        [uiName setText:loginInfo.nickName];
    }
    if( self.loginInfo != nil ){
        [uiPhoto setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:loginInfo.headUrl]]] forState:UIControlStateNormal];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)textFieldGoToNext:(id)sender
{
    if( sender == uiPhone ){
        [sender resignFirstResponder];
        [uiPasswd becomeFirstResponder];
    }else if( sender == uiPasswd ){
        [sender resignFirstResponder];
        [uiVerify becomeFirstResponder];
    }else{
        [sender resignFirstResponder];
    }
}

- (void)getOn {
    AddObserver(nsSignupSucc:,@"SHITOUREN_USER_SIGNUP_POST_SUCC");
    AddObserver(nsSignupFail:,@"SHITOUREN_USER_SIGNUP_POST_FAIL");
    AddObserver(nsSignupErr:,@"SHITOUREN_USER_SIGNUP_POST_ERR");
    AddObserver(nsSignupTimeout:,@"SHITOUREN_USER_SIGNUP_POST_TIMEOUT");
    AddObserver(nsVerifySucc:,@"SHITOUREN_USER_SIGNUP_VERIFY_SUCC");
    AddObserver(nsVerifyFail:,@"SHITOUREN_USER_SIGNUP_VERIFY_FAIL");
    AddObserver(nsVerifyErr:,@"SHITOUREN_USER_SIGNUP_VERIFY_ERR");
    AddObserver(nsVerifyTimeout:,@"SHITOUREN_USER_SIGNUP_VERIFY_TIMEOUT");
}

- (void)getOff {
    DelObserver(@"SHITOUREN_USER_SIGNUP_POST_SUCC");
    DelObserver(@"SHITOUREN_USER_SIGNUP_POST_FAIL");
    DelObserver(@"SHITOUREN_USER_SIGNUP_POST_ERR");
    DelObserver(@"SHITOUREN_USER_SIGNUP_POST_TIMEOUT");
    DelObserver(@"SHITOUREN_USER_SIGNUP_VERIFY_SUCC");
    DelObserver(@"SHITOUREN_USER_SIGNUP_VERIFY_FAIL");
    DelObserver(@"SHITOUREN_USER_SIGNUP_VERIFY_ERR");
    DelObserver(@"SHITOUREN_USER_SIGNUP_VERIFY_TIMEOUT");
}

-(void)nsSignupSucc:(NSNotification *)notification {
    [hudLoading hide:YES];
    [self baseBack:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nsSignupFail:(NSNotification *)notification {
    [hudLoading hide:YES];
    NSString *msg = (NSString*)(notification.object);
    [self baseShowBotHud:NSLocalizedString(msg, @"")];
    
}
-(void)nsSignupErr:(NSNotification *)notification {
    [hudLoading hide:YES];
    [self baseShowBotHud:NSLocalizedString(@"网络出错，请稍后再试", @"")];
}
-(void)nsSignupTimeout:(NSNotification *)notification {
    [hudLoading hide:YES];
    [self baseShowBotHud:NSLocalizedString(@"请求超时，请稍后再试", @"")];
}

-(void)nsVerifySucc:(NSNotification *)notification {
    [hudLoading hide:YES];
    [self baseShowBotHud:NSLocalizedString(@"验证码已发送", @"")];
}
-(void)nsVerifyFail:(NSNotification *)notification {
    [hudLoading hide:YES];
    NSString *msg = (NSString*)(notification.object);
    [self baseShowBotHud:NSLocalizedString(msg, @"")];
    
}
-(void)nsVerifyErr:(NSNotification *)notification {
    [hudLoading hide:YES];
    [self baseShowBotHud:NSLocalizedString(@"网络出错，请稍后再试", @"")];
}
-(void)nsVerifyTimeout:(NSNotification *)notification {
    [hudLoading hide:YES];
    [self baseShowBotHud:NSLocalizedString(@"请求超时，请稍后再试", @"")];
}

-(void)doVerify:(id)sender {
    NSString *phoneRegex = @"^1[358][0-9]{9}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isPhoneValid = [phonePredicate evaluateWithObject:uiPhone.text];
    if (!isPhoneValid){
        [self baseShowBotHud:NSLocalizedString(@"请输入正确的手机号", @"")];
        [uiPhone becomeFirstResponder];
        return;
    } else {
        [[UserManager sharedInstance] signupVerify:uiPhone.text];
    }
}

- (void)doRegister:(id)sender
{
    [uiPhone resignFirstResponder];
    [uiPasswd resignFirstResponder];
    [uiVerify resignFirstResponder];
    
    NSString *phoneRegex = @"^1[358][0-9]{9}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isPhoneValid = [phonePredicate evaluateWithObject:uiPhone.text];
    if (!isPhoneValid){
        [self baseShowBotHud:NSLocalizedString(@"请输入正确的手机号", @"")];
        return;
    }
    
    NSString *confirmRegex = @"^[0-9]{6}$";
    NSPredicate *confirmPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", confirmRegex];
    BOOL isConfirmValid = [confirmPredicate evaluateWithObject:uiVerify.text];
    if (!isConfirmValid){
        [self baseShowBotHud:NSLocalizedString(@"请输入此手机收到6位验证码", @"")];
        return;
    }
    
    NSString *uiPasswdRegex = @"^\\S{6,20}$";
    NSPredicate *uiPasswdPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", uiPasswdRegex];
    BOOL isPasswdValid = [uiPasswdPredicate evaluateWithObject:uiPasswd.text];
    //密码验证
    if (!isPasswdValid) {
        [self baseShowBotHud:NSLocalizedString(@"请使用6~20位的密码", @"")];
        uiPasswd.text = @"";
        return;
    }
    
    if (![[NetworkManager sharedInstance]hasNetwork]) {
        [self baseShowBotHud:NSLocalizedString(@"网络出错，请稍后再试", @"")];
        return;
    }
    
    hudLoading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudLoading.labelText = @"正在注册...";
    hudLoading.opacity = 0.7;
    
    [[UserManager sharedInstance] signupWithPhone:uiPhone.text passwd:uiPasswd.text verify:uiVerify.text WXLoginInfo:self.loginInfo];
}

-(void)goProtocol:(id)sender {
    
}

- (void)baseBack:(id)sender
{
    [uiPhone resignFirstResponder];
    [uiPasswd resignFirstResponder];
    [uiVerify resignFirstResponder];
    [self baseNavBack];
}

@end
