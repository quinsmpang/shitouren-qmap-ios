//
//  BuddyCell.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/21.
//
//

#import <UIKit/UIKit.h>
#import "BuddyItem.h"

@protocol BuddyCellDelegate <NSObject>

@optional
-(void)onRelationShip:(long)index;

@end

@interface BuddyCell : UITableViewCell{
    
}

@property (strong, nonatomic) UIImageView *uiUserImage;

@property (strong, nonatomic) UILabel        *uiUserName;
@property (strong, nonatomic) UILabel        *uiZone;
//@property (strong, nonatomic) UILabel        *uiTopicchannel;
@property (strong, nonatomic) UIButton *uiBtn;
@property (assign, nonatomic) id<BuddyCellDelegate> delegate;

-(void)start:(BuddyItem*) item :(long)index;

@end
