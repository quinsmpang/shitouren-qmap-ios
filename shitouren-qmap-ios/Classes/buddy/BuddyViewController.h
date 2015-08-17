//
//  BuddyViewController.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/21.
//
//

//#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "BuddyListView.h"


@interface BuddyViewController : BaseUIViewController<BuddyListDelegate> {
    
    UIView  *buddyViewContainer;
    UIImageView *userImage;
    UILabel *userName;
    UILabel *zone;
//    BuddyView  *buddyView;
    
    UIButton *btnFans;
    UILabel *fansTitle;
    UILabel *fansNum;
    
    UIButton *btnFollow;
    UILabel *followTitle;
    UILabel *followNum;
    
    UIButton *btnOrther;
    UILabel *ortherTitle;
    UILabel *ortherNum;
    BuddyManager *buddyManager;
    
//    long userid;
//    BuddyItem *mainUser;
}

@property (strong, nonatomic) BuddyListView    *listView;

- (void) onTouch:(id)sender;
- (void) setUserData:(long)userID :(NSString*) name :(NSString*)intro : (NSString*)zonename : (NSString*)thumblink : (NSString*)imglink ;
@end
