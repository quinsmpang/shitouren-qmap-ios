//
//  MessageController.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/28.
//
//

#import "BaseUIViewController.h"
#import "MsgManager.h"
#import "MyMsgView.h"
#import "PetMsgView.h"
#import "SupportMsgView.h"
#import "SystemMsgView.h"
#import "MainMsgView.h"
#import "UIMsgMenuView.h"
#import "UIMenuAlertView.h"

@interface MessageController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate, MainMsgViewDelegate, MsgDelegate, UIMsgMenuViewDelegate>
{
    UITableView *tvMsg;
    MsgManager *manager;
    
    MainMsgView *mainView;
    UIView      *msgView;
    
    MyMsgView *myMsgView;
    PetMsgView *petMsgView;
    SupportMsgView *supportMsgView;
    SystemMsgView *systemMsgView;
    
    UIButton    *uiBtnClean;
    UIBarButtonItem         *uiBtnBarClean;
    
    UIMsgMenuView *menuView;
    
    UIMenuAlertView *uiMenuView;
}
@end
