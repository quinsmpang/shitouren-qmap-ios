//
//  AboutViewController.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface LineItem : NSObject
@property (assign, atomic) CGPoint ptBegin;
@property (assign, atomic) CGPoint ptEnd;
@property (assign, atomic) CGFloat colorR;
@property (assign, atomic) CGFloat colorG;
@property (assign, atomic) CGFloat colorB;
@property (assign, atomic) CGFloat colorA;
@end


@interface FollowItem : NSObject
@property (strong, atomic) NSString *strCaption;

@end

@interface AboutViewController : BaseUIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *imageView;
    UILabel *label;
    
    UIImageView *uiLine;
    
    UILabel *uiIntroTitle;
    UILabel *uiIntro;
    
    UILabel *uiFollowTitle;
    UITableView *tv;
    
    
    UILabel *lUpdate;
    UIButton *bUpdate;
    
    UILabel *lJudge;
    UIButton *bJudge;
    
    UILabel *lWX;
    UIButton *bWX;
    
    UILabel *lWB;
    UIButton *bWB;
    
    UILabel *lQ;
    UIButton *bQ;
}
@end
