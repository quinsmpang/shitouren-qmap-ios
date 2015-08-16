#import "TopicItem.h"
#import "TopicManager.h"
#import "TopicBanner.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"


@protocol TopicListViewDelegate;

@interface TopicListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIActivityIndicatorView *initLoading;
}
@property (strong, nonatomic) TopicManager *topicManager;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TopicBanner *banner;
//@property (strong, nonatomic) UITableViewCell *loadMoreCell;
//@property (strong, nonatomic) UIButton *loadMoreBtn;
//@property (strong, nonatomic) UIActivityIndicatorView *loadMoreLoading;
@property (assign, nonatomic) id <TopicListViewDelegate> delegate;
- (void)start:(id<TopicListViewDelegate>)pDelegate;
@end

@protocol TopicListViewDelegate<NSObject>
@optional
- (void)TLVDclick:(NSInteger)row;
- (void)TLVDrefresh;
- (void)TLVDmore;
@end
