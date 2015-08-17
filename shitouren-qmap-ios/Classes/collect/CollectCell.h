//
//  CollectCell.h
//  qmap
//
//  Created by 石头人6号机 on 15/8/7.
//
//

#import <UIKit/UIKit.h>

#import "CollectItem.h"

@interface CollectCell : UITableViewCell
{
    UIImageView *uiTypeImage;
    UIImageView *uiTypeBackground;
    UIButton    *uiBtnSelect;
    UIButton    *uiBtnHide;
}

- (void)refreshUI:(CollectItem *)item;

@end
