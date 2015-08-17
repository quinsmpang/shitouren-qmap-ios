//
//  UserDetailController.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/30.
//
//

#import "BaseUIViewController.h"
#include "UISelectView.h"
#import "UserManager.h"

@interface UserDetailController : BaseUIViewController<UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UISelectViewDelegate>
{
//    long userID;
    UserDetailItem *userDetail;
    UserBriefItem *userBrief;
    UserSsItem *ss;
//    BOOL isLoginUser;
    
    UIImageView *uiUserImage;
    UILabel *uiUserName;
    UILabel *uiUserIntro;
    
    UILabel *uiSexCaption;
    UILabel *uiSex;
    UIButton *uiSexBtn;
//    UIActionSheet *uiSexAS;
    UISelectView *uiSexSV;
    
    UILabel *uiSexOTCaption;
    UILabel *uiSexOT;
    UIButton *uiSexOTBtn;
//    UIActionSheet *uiSexOTAS;
    UISelectView *uiSexOTSV;
    
    UILabel *uiLoveCaption;
    UILabel *uiLove;
    UIButton *uiLoveBtn;
//    UIActionSheet *uiLoveAS;
    UISelectView *uiLoveSV;
    
    UILabel *uiHoroCaption;
    UILabel *uiHoro;
    UIButton *uiHoroBtn;
//    UIPickerView *uiHoroAS;
    UISelectView *uiHoroSV;
    
//    UISelectView *selView;
    
    NSArray *arySex;
    NSArray *arySexOT;
    NSArray *aryLove;
    NSArray *aryHoro;
}

- (void) setUserData:(long)userid;
@end
