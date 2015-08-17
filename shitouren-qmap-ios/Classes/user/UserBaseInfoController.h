//
//  UserBaseInfoController.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/30.
//
// 用户基本信息

#import "BaseUIViewController.h"
#import "UserBriefItem.h"
#import "UserBaseInfoView.h"
#import "UserBaseInfoEditView.h"

@interface UserBaseInfoController : BaseUIViewController
{
    UIImageView *uiUserImage;
    UILabel *uiUserName;
    
    UIButton *uiEditBtn;
    UIBarButtonItem         *uiEditBarBtn;
    
    UserBaseInfoView *uiInfoView;
    UserBaseInfoEditView *uiEditView;
    
    UserBriefItem* mainUser;
    
    BOOL bEditState;
}

- (void) setUserData:(long)userID :(NSString*) name :(NSString*)intro : (NSString*)zonename : (NSString*)thumblink : (NSString*)imglink ;

@end
