#import "NoteItem.h"
#import "NoteManager.h"
#import "NoteBanner.h"
#import "NoteTagView.h"
#import "NotePlaceView.h"
#import "TopicItem.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

@protocol NoteListViewDelegate;

@interface NoteListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIActivityIndicatorView *initLoading;
//    UIActivityIndicatorView *loadMoreLoading;
}
@property (strong, nonatomic) TopicItem *topicItem;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NoteBanner *banner;
//@property (strong, nonatomic) UITableViewCell *loadMoreCell;
//@property (strong, nonatomic) UIButton *loadMoreBtn;
@property (strong, nonatomic) id<NoteListViewDelegate,NoteBannerDelegate,NotePlaceViewDelegate,NoteTagViewDelegate> delegate;
-(void)start:(TopicItem*)pTopicItem :(id<NoteListViewDelegate,NoteBannerDelegate,NotePlaceViewDelegate,NoteTagViewDelegate>)pDelegate;
@end

@protocol NoteListViewDelegate<NSObject>
@optional
- (void)NLVDclick:(NoteItem*)pNote;
- (void)NLVDrefresh;
- (void)NLVDmore;
@end
