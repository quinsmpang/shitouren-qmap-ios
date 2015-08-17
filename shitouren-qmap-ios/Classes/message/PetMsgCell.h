//
//  PetMsgCell.h
//  qmap
//
//  Created by 石头人6号机 on 15/8/14.
//
//

#import <UIKit/UIKit.h>
#import "MsgItem.h"

@interface PetMsgCell : UITableViewCell
{
    UIView *uiBackGround;
    UIImageView *uiUserImage;
    UILabel *uiUserName;
    UILabel *uiZoneName;
    UILabel *uiMsg;
    UILabel *uiTime;
}

-(void)setCell:(MsgItem*)item;

@end
