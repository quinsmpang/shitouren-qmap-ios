//
//  CalloutViewController.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/5.
//
//

#import "CalloutViewController.h"
#import "UserManager.h"

@interface CalloutViewController ()

@end

@implementation CalloutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    baseTitle.text = @"喊话内容";
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    [self.view setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
    
    CGFloat h = mainRect.size.height - 200;
    CGFloat contentH = (h - 50)/3;
    uiContent1 = [[UITextView alloc]initWithFrame:CGRectMake(20, 20, mainRect.size.width-40, contentH)];
    uiContent2 = [[UITextView alloc]initWithFrame:CGRectMake(20, 20+contentH, mainRect.size.width-40, contentH)];
    uiContent3 = [[UITextView alloc]initWithFrame:CGRectMake(20, 20 +contentH*2, mainRect.size.width-40, contentH)];
    
    uiBtnOK = [[UIButton alloc]initWithFrame:CGRectMake(50, h, mainRect.size.width - 100, 48)];
    [uiBtnOK setTitle:@"发布" forState:UIControlStateNormal];
    //    [uiSend setBackgroundColor:UIColorFromRGB(0x00ff00, 1.0f)];
    [uiBtnOK setBackgroundImage:[UIImage imageNamed:@"login-6-1.png" ] forState:UIControlStateNormal];
    [uiBtnOK setBackgroundImage:[UIImage imageNamed:@"login-6-2.png"] forState:UIControlStateHighlighted];
    [uiBtnOK addTarget:self action:@selector(onIssue:) forControlEvents:UIControlEventTouchUpInside];

    [self initTextView:uiContent1];
    [self initTextView:uiContent2];
    [self initTextView:uiContent3];
    [self.view addSubview:uiBtnOK];
    
    uiContent1.text = [UserManager sharedInstance].callout1;
    uiContent2.text = [UserManager sharedInstance].callout2;
    uiContent3.text = [UserManager sharedInstance].callout3;
}

- (void)initTextView:(UITextView*)uiTV
{
    [uiTV setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
    [uiTV setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [uiTV setTextAlignment:NSTextAlignmentLeft];
    uiTV.returnKeyType = UIReturnKeyDefault;//return键的类型
    uiTV.keyboardType = UIKeyboardTypeDefault;//键盘类型、
    //    uiContent1.text = @"";//设置显示的文本内容
    [uiTV.layer setCornerRadius:10];
    uiTV.delegate = self;
    uiTV.dataDetectorTypes = UIDataDetectorTypeAll;
    [uiTV becomeFirstResponder];
    uiTV.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    uiTV.scrollEnabled = YES;
    //    uiMsg.inputDelegate = self;
    uiTV.placeholder = @"喊话内容。。。";
    
    [self.view addSubview:uiTV];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        callback( 0 );
    }
}

- (void)onIssue:(id)sender
{
    NSString *text1 = uiContent1.text;
    NSString *text2 = uiContent2.text;
    NSString *text3 = uiContent3.text;
    
    [UserManager sharedInstance].callout1 = text1;
    [UserManager sharedInstance].callout2 = text2;
    [UserManager sharedInstance].callout3 = text3;
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:text1 forKey:@"SHITOUREN_UD_CALLOUT1"];
    [defaults setObject:text2 forKey:@"SHITOUREN_UD_CALLOUT2"];
    [defaults setObject:text3 forKey:@"SHITOUREN_UD_CALLOUT3"];
    
    [self baseDeckAndNavBack];
    if( callback ){
        callback( 1 );
    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    return  (range.location < 20);
    return text.length < 20;
}

@end
