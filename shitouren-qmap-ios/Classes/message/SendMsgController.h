//
//  SendMsgController.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/28.
//
//

#import "BaseUIViewController.h"
#import "UITextView+PlaceHolder.h"
#import "MsgManager.h"

@interface SendMsgController : BaseUIViewController<UITextViewDelegate>
{
    UITextView *uiMsg;
    UIButton *uiSend;
    
    long userid;
    
    MsgManager *manager;
}

-(void)setUserInfo:(long)userID;

@end
