//
//  SendMsgController.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/28.
//
//

#import "SendMsgController.h"

@interface SendMsgController ()

@end

@implementation SendMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    baseTitle.text = @"消息";
    [self.view setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
    [self getOn];
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    
    manager = [[MsgManager alloc]init];
    
    uiMsg = [[UITextView alloc]initWithFrame:CGRectMake(20, 60, mainRect.size.width-40, 200)];
    [uiMsg setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
    [uiMsg setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [uiMsg setTextAlignment:NSTextAlignmentLeft];
    uiMsg.returnKeyType = UIReturnKeyDefault;//return键的类型
    uiMsg.keyboardType = UIKeyboardTypeDefault;//键盘类型、
    uiMsg.text = @"";//设置显示的文本内容
//    uiMsg          //.placeholder = @"填写内容…………";
//    uiMsg.borderStyle = UITextBorderStyleRoundedRect;
//    uiMsg.b
    uiMsg.delegate = self;
    uiMsg.dataDetectorTypes = UIDataDetectorTypeAll;
    [uiMsg becomeFirstResponder];
    uiMsg.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    uiMsg.scrollEnabled = YES;
//    uiMsg.inputDelegate = self;
    uiMsg.placeholder = @"";
    
    uiSend = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, mainRect.size.width - 100, 48)];
    [uiSend setTitle:@"确定" forState:UIControlStateNormal];
//    [uiSend setBackgroundColor:UIColorFromRGB(0x00ff00, 1.0f)];
    [uiSend setBackgroundImage:[UIImage imageNamed:@"login-6-1.png" ] forState:UIControlStateNormal];
    [uiSend setBackgroundImage:[UIImage imageNamed:@"login-6-2.png"] forState:UIControlStateHighlighted];
//    uiSend.buttonType = UIButtonTypeRoundedRect;
    [uiSend addTarget:self action:@selector(onSend:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:uiMsg];
    [self.view addSubview:uiSend];
    
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];

    
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    
}

-(void)keyboardDidHidden
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUserInfo:(long)userID
{
    userid = userID;
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
    [self getOff];
    [self baseDeckAndNavBack];
    if( callback ){
        callback( 1 );
    }
}

- (void)onSend:(id)sender
{
    NSString *strMsg = uiMsg.text;
    
    NSLog(@"send.to %ld...%@", userid, strMsg);
    [manager sendMsg:userid :strMsg];
}

- (void)getOn
{
    AddObserver(nsSucc:, @"SHITOUREN_MSG_SEND_SUCC");
}

- (void)getOff
{
    DelObserver(@"SHITOUREN_MSG_SEND_SUCC");
}

-(void)nsSucc:(NSNotification *)notification {
    NSString *msg = (NSString*)(notification.object);
    //    [self baseShowBotHud:NSLocalizedString(msg, @"")];
    NSLog(@"%@", msg);
    //    CGRect mainFrame = buddyViewContainer.frame;
    //    CGFloat w = mainFrame.size.width;
    [self baseBack:nil];
}


//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
}

//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView
{
    
}

//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
}

@end
