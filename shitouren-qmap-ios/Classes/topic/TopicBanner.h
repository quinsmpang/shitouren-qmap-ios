#import "TopicManager.h"

@interface TopicBanner : UIView<UIScrollViewDelegate> {
    NSTimer *_timer;
}

//广告栏
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *imageNum;
@property (nonatomic) NSInteger totalNum;

- (void)start:(TopicManager *)pTopicManager;
- (void)openTimer;
- (void)closeTimer;

@end
