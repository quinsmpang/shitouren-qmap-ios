//
//  UserBaseInfoEditView.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/30.
//
//

#import <UIKit/UIKit.h>

@interface UserBaseInfoEditView : UIView
{
    UITextField *uiZone;
    UITextField *uiIntro;
}
- (NSString*)getZone;
- (NSString*)getIntro;
@end
