//
//  CollectViewController.h
//  qmap
//
//  Created by 石头人6号机 on 15/8/6.
//
//

#import "BaseUIViewController.h"
#import "CollectManager.h"
#import "CollectCell.h"

@interface CollectViewController : BaseUIViewController<UITableViewDataSource, UITableViewDelegate>
{
    long userid;
    CollectManager *manager;
    
    UITableView *uiTVCollect;
    UIButton    *uiBtnEdit;
    UIBarButtonItem         *uiBtnBarEdit;
    
}

- (void)setUserData:(long)userID;

@end
