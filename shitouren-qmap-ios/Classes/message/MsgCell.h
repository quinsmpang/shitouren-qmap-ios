//
//  MsgCell.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/29.
//
//

#import <UIKit/UIKit.h>
#import "MsgItem.h"

@interface MsgCell : UITableViewCell
{
    UIImageView *uiUserImage;
    UILabel *uiUserName;
    UILabel *uiZoneName;
    
    UILabel *uiMsg;
    UIView *uiMsgView;
    UILabel *uiTime;
}

-(void)setCell:(MsgItem*)item;
@end
