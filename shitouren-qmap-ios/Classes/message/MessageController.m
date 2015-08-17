//
//  MessageController.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/28.
//
//

#import "MessageController.h"
#import "MsgCell.h"
#import "MsgItem.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    baseTitle.text = @"消息";
    [self getOn];
    
    manager = [[MsgManager alloc]init];
    [manager requestMyMsgDate:0 :20];
    
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    
    mainView = [[MainMsgView alloc]initWithFrame:mainRect];
    mainView.delegate = self;
    
    myMsgView = [[MyMsgView alloc]initWithFrame:mainRect];
    myMsgView.manager = manager;
    myMsgView.delegate = self;
    myMsgView.alpha = 0.0f;
    
    petMsgView = [[PetMsgView alloc]initWithFrame:mainRect];
    petMsgView.manager = manager;
    petMsgView.delegate = self;
    petMsgView.alpha = 0.0f;
    [manager requestPetData:0 :20];
    
    supportMsgView = [[SupportMsgView alloc]initWithFrame:mainRect];
    supportMsgView.alpha = 0.0f;
    
    systemMsgView = [[SystemMsgView alloc]initWithFrame:mainRect];
    systemMsgView.alpha = 0.0f;
    systemMsgView.manager = manager;
    systemMsgView.delegate = self;
    [manager requestSystemData:0 :20];
    
    uiBtnClean = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    [uiBtnClean setTitle:@"..." forState:UIControlStateNormal];
    [uiBtnClean.titleLabel setFont:[UIFont boldSystemFontOfSize:20] ];
    //    [uiBtnClean setImage:[UIImage imageNamed:@"collect_6.png"] forState:UIControlStateNormal];
    [uiBtnClean setTitleColor:UIColorFromRGB(0x000000, 1.0f) forState:UIControlStateNormal];
    uiBtnClean.alpha = 0.0f;
    [uiBtnClean addTarget:self action:@selector(onClean:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:uiEditBtn];
    
    uiBtnBarClean = [[UIBarButtonItem alloc] initWithCustomView:uiBtnClean];
    //    self.navigationItem.rightBarButtonItem = uiBtnBarClean;
    
    menuView = [[UIMsgMenuView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
    menuView.delegate = self;
    
    uiMenuView = [[UIMenuAlertView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
    
    [menuView setHidden:YES];
    
    [self.view addSubview:mainView];
    
    [self.view addSubview:myMsgView];
    [self.view addSubview:petMsgView];
    [self.view addSubview:supportMsgView];
    [self.view addSubview:systemMsgView];
    
    [self.view addSubview:menuView];
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
    if (msgView) {
        baseTitle.text = @"消息";
        msgView.alpha = 0.0f;
        msgView = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }else
    {
        [self getOff];
        [self baseDeckAndNavBack];
        if( callback ){
            callback( 1 );
        }
    }
}

- (void)onClean:(id)sender
{
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Default Alert View" message:@"Defalut" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //    [alertView show];
    //    [uiMenuView show];
    [menuView setHidden:NO];
    //    if (msgView == myMsgView) {
    //        NSLog(@"mymessage clean....");
    //    }else if (msgView == petMsgView) {
    //        NSLog(@"pet message clean....");
    //    }else if (msgView == supportMsgView) {
    //        NSLog(@"support message clean...");
    //    }else if (msgView == systemMsgView) {
    //        NSLog(@"system message clean...");
    //    }
}

- (void)getOn
{
    AddObserver(nsSucc:, @"SHITOUREN_MSG_LIST_SUCC");
}

- (void)getOff
{
    DelObserver(@"SHITOUREN_MSG_LIST_SUCC");
}

-(void)nsSucc:(NSNotification *)notification {
    NSString *msg = (NSString*)(notification.object);
    //    [self baseShowBotHud:NSLocalizedString(msg, @"")];
    NSLog(@"%@", msg);
    //    CGRect mainFrame = buddyViewContainer.frame;
    //    CGFloat w = mainFrame.size.width;
    if ([msg isEqualToString:@"user"]) {
        [myMsgView refreshTabelView];
    }else if ([msg isEqualToString:@"pet"]) {
        [petMsgView refreshTabelView];
    }else if ([msg isEqualToString:@"system"]) {
        [systemMsgView refreshTabelView];
    }
    
}


#pragma TableView的处理

-(NSInteger)tableView:(UITableView *)pTableView numberOfRowsInSection:(NSInteger)section {
    //    return topicManager.listShow.count+1;
    //    NSInteger count = 0;
    //    if(manager.msgList.count != nil)
    //    {
    //        count = tableData.count;
    //    }
    return manager.msgList.count;
}

-(CGFloat)tableView:(UITableView *)pTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return 60+44;
    //    }
    UITableViewCell *cell = [self tableView:tvMsg cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)pTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if( [indexPath row] == topicManager.listShow.count ) {
    //        return loadMoreCell;
    //    }
    MsgCell *cell = [[MsgCell alloc] init];
    //    if (tableData != nil)
    //    {
    MsgItem *item =  [manager.msgList objectAtIndex:indexPath.row];
    [cell setCell:item];
    //    }
    return cell;
}

-(void)tableView:(UITableView *)pTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return;
    //    }
    //    if( self.delegate ){
    //        [self.delegate selectItem:indexPath.row];
    //    }
    return;
}

#pragma MainMsgView 处理
-(void)switchToMyMsg
{
    [self switchView:myMsgView :@"我的消息"];
}

-(void)switchToPetMsg
{
    [self switchView:petMsgView :@"宠物消息"];
}

-(void)switchToSupportMsg
{
    [self switchView:supportMsgView :@"收到的赞"];
}

-(void)switchToSystemMsg
{
    [self switchView:systemMsgView :@"系统消息"];
}

-(void)switchView:(UIView*)view :(NSString*)title
{
    view.alpha = 1.0f;
    view.transform = CGAffineTransformTranslate(view.transform, view.frame.size.width, 0.0f);
    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(){
        //            uiInfoView.transform = CGAffineTransformScale(uiInfoView.transform, 1.0f, 1.0f);
        //        mainView.alpha = 0.0f;
        view.transform = CGAffineTransformTranslate(view.transform, -view.frame.size.width, 0.0f);
        
    } completion:^(BOOL bl){
        msgView = view;
        baseTitle.text = title;
        self.navigationItem.rightBarButtonItem = uiBtnBarClean;
    }];
    
}

#pragma MSG处理

- (void)myMsgDelegate:(long)index
{
    MsgItem *item = [manager getMyMsgItem:index];
    
    [self baseDeckBack];
    
    [self toCocos:item.userItem.userid :item.userItem.name :item.userItem.intro :item.userItem.zone :item.userItem.thumblink :item.userItem.imglink ];
}
- (void)petMsgDelegate:(long)index
{
    MsgItem *item = [manager getPetMsgItem:index];
    
    [self baseDeckBack];
    
    [self toCocos:item.userItem.userid :item.userItem.name :item.userItem.intro :item.userItem.zone :item.userItem.thumblink :item.userItem.imglink ];
}
- (void)systemMsgDelegate:(long)index
{
    
}
- (void)supportMsgDelegate:(long)index
{
    
}

#pragma MSGMenu
-(void)onCleanAll
{
    if (msgView == myMsgView) {
        NSLog(@"mymessage clean....");
        [manager delMyMsgData];
    }else if (msgView == petMsgView) {
        NSLog(@"pet message clean....");
        [manager delPetMsgData];
    }else if (msgView == supportMsgView) {
        NSLog(@"support message clean...");
    }else if (msgView == systemMsgView) {
        NSLog(@"system message clean...");
        [manager delSystemMsgData];
    }
    [menuView setHidden:YES];
}
-(void)onHideMsgMenu
{
    [menuView setHidden:YES];
}

@end
