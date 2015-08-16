#import "MBProgressHUD.h"
#import "BaseUIViewController.h"
#import "TopicView.h"

@interface TopicViewController : BaseUIViewController <TopicViewDelegate> {
    UIView  *topicViewContainer;
    TopicView  *topicView;
}
@end
