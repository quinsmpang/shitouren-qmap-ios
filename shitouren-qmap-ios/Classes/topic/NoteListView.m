#import "NoteListView.h"
#import "NoteCell.h"
#import "LoggerClient.h"

@implementation NoteListView

@synthesize topicItem, tableView, banner, delegate;
//@synthesize loadMoreCell, loadMoreBtn;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
        CGRect mainFrame = self.frame;
        mainFrame.origin = CGPointMake(0, 0);
        mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
        
        initLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        tableView = [[UITableView alloc]initWithFrame:mainFrame];
        [tableView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [tableView setBackgroundColor:[UIColor clearColor]];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[NoteCell class] forCellReuseIdentifier:@"NoteCell"];
        
        __weak NoteListView *weakSelf = self;
        //        // setup pull-to-refresh
        //        [self.tableView addPullToRefreshWithActionHandler:^{
        //            Log(@"haha");
        //            int64_t delayInSeconds = 1.0;
        //            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        //            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //                [weakSelf.delegate NLVDrefresh];
        //            });
        //        }];
        
        // setup infinite scrolling
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            int64_t delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [weakSelf.delegate NLVDmore];
            });
        }];
        
//        loadMoreCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 60+44)];
//        [loadMoreCell setBackgroundColor:[UIColor clearColor]];
//        loadMoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        loadMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, mainFrame.size.width-20, 50)];
//        [loadMoreBtn setBackgroundColor:UIColorFromRGB(0x232323, 1.0f)];
//        [loadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
//        [loadMoreBtn.titleLabel setFont:[UIFont systemFontOfSize: 14.0]];
//        [loadMoreBtn.titleLabel setTextColor:UIColorFromRGB(0x999999, 1.0f)];
//        [loadMoreBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [loadMoreBtn addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
//        loadMoreBtn.hidden = YES;
//        [loadMoreCell addSubview:loadMoreBtn];
//        
//        loadMoreLoading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(mainFrame.size.width/2-22, 3, 44, 44)];
//        [loadMoreLoading startAnimating];
//        [loadMoreCell addSubview:loadMoreLoading];
        
        [self addSubview:tableView];
        [self addSubview:initLoading];
        
        banner = [[NoteBanner alloc] init];
        banner.backgroundColor = [UIColor clearColor];
        tableView.tableHeaderView=banner;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
    }
    return self;
}

-(void)start:(TopicItem*)pTopicItem :(id<NoteListViewDelegate,NoteBannerDelegate,NotePlaceViewDelegate,NoteTagViewDelegate>)pDelegate
{
    [self getOn];
    self.topicItem = pTopicItem;
    self.delegate = pDelegate;
    [self.banner start:pTopicItem :pDelegate];
    tableView.tableHeaderView = tableView.tableHeaderView;
    tableView.contentOffset = CGPointMake(0, 0);
    
    CGRect mainFrame = self.frame;
    mainFrame.origin = CGPointMake(0, 0);
    mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
    initLoading.frame = CGRectMake((mainFrame.size.width-20)/2, self.banner.frame.size.height+20, 20, 20);
    [initLoading startAnimating];
    
//    loadMoreBtn.hidden = YES;
//    [loadMoreLoading startAnimating];
}

#pragma TableView的处理

-(NSInteger)tableView:(UITableView *)pTableView numberOfRowsInSection:(NSInteger)section {
//    return topicItem.noteManager.listShow.count+1;
    return topicItem.noteManager.listShow.count;
}

-(CGFloat)tableView:(UITableView *)pTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if([indexPath row] == topicItem.noteManager.listShow.count) {
//        return 60+44;
//    }
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)pTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if( [indexPath row] == topicItem.noteManager.listShow.count ) {
//        return loadMoreCell;
//    }
    static NSString * CellIdentifier = @"NoteCell";
    NoteCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( cell == nil ){
        cell = [[NoteCell alloc] init];
    }
    NoteItem *item =  [topicItem.noteManager.listShow objectAtIndex:indexPath.row];
    [cell stop];
    [cell start:item :self.delegate];
    return cell;
}

-(void)tableView:(UITableView *)pTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if([indexPath row] == topicItem.noteManager.listShow.count) {
//        return;
//    }
    return;
}

//- (void)loadMore {
//    loadMoreBtn.hidden = YES;
//    [loadMoreLoading startAnimating];
//    if( self.delegate ){
//        [self.delegate NLVDmore];
//    }
//}

- (void)getOn {
    AddObserver(nsListStart:, @"SHITOUREN_NOTE_LIST_START");
    AddObserver(nsListSucc:, @"SHITOUREN_NOTE_LIST_SUCC");
    AddObserver(nsListFail:, @"SHITOUREN_NOTE_LIST_FAIL");
    AddObserver(nsListErr:, @"SHITOUREN_NOTE_LIST_ERR");
    AddObserver(nsListTimeout:, @"SHITOUREN_NOTE_LIST_TIMEOUT");
    AddObserver(nsLikeSucc:, @"SHITOUREN_NOTE_LIKE_POST_SUCC");
    AddObserver(nsLikeFail:, @"SHITOUREN_NOTE_LIKE_POST_FAIL");
    AddObserver(nsLikeFail:, @"SHITOUREN_NOTE_LIKE_POST_ERR");
    AddObserver(nsLikeFail:, @"SHITOUREN_NOTE_LIKE_POST_TIMEOUT");
    AddObserver(nsLikeSucc:, @"SHITOUREN_NOTE_LIKE_DEL_SUCC");
    AddObserver(nsLikeFail:, @"SHITOUREN_NOTE_LIKE_DEL_FAIL");
    AddObserver(nsLikeFail:, @"SHITOUREN_NOTE_LIKE_DEL_ERR");
    AddObserver(nsLikeFail:, @"SHITOUREN_NOTE_LIKE_DEL_TIMEOUT");
}

- (void)getOff {
    DelObserver(@"SHITOUREN_NOTE_LIST_START");
    DelObserver(@"SHITOUREN_NOTE_LIST_SUCC");
    DelObserver(@"SHITOUREN_NOTE_LIST_FAIL");
    DelObserver(@"SHITOUREN_NOTE_LIST_ERR");
    DelObserver(@"SHITOUREN_NOTE_LIST_TIMEOUT");
    DelObserver(@"SHITOUREN_NOTE_LIKE_POST_SUCC");
    DelObserver(@"SHITOUREN_NOTE_LIKE_POST_FAIL");
    DelObserver(@"SHITOUREN_NOTE_LIKE_POST_ERR");
    DelObserver(@"SHITOUREN_NOTE_LIKE_POST_TIMEOUT");
    DelObserver(@"SHITOUREN_NOTE_LIKE_DEL_SUCC");
    DelObserver(@"SHITOUREN_NOTE_LIKE_DEL_FAIL");
    DelObserver(@"SHITOUREN_NOTE_LIKE_DEL_ERR");
    DelObserver(@"SHITOUREN_NOTE_LIKE_DEL_TIMEOUT");
}

-(void)nsListStart:(NSNotification *)notification {
    [initLoading stopAnimating];
    initLoading.hidden = YES;
    [tableView reloadData];
    [tableView.infiniteScrollingView stopAnimating];
//    loadMoreBtn.hidden = NO;
//    [loadMoreLoading stopAnimating];
}
-(void)nsListSucc:(NSNotification *)notification {
    [tableView reloadData];
    [tableView.infiniteScrollingView stopAnimating];
//    loadMoreBtn.hidden = NO;
//    [loadMoreLoading stopAnimating];
}
-(void)nsListFail:(NSNotification *)notification {
    [tableView reloadData];
    [tableView.infiniteScrollingView stopAnimating];
//    loadMoreBtn.hidden = NO;
//    [loadMoreLoading stopAnimating];
}
-(void)nsListErr:(NSNotification *)notification {
    [tableView reloadData];
    [tableView.infiniteScrollingView stopAnimating];
//    loadMoreBtn.hidden = NO;
//    [loadMoreLoading stopAnimating];
}
-(void)nsListTimeout:(NSNotification *)notification {
    [tableView reloadData];
    [tableView.infiniteScrollingView stopAnimating];
//    loadMoreBtn.hidden = NO;
//    [loadMoreLoading stopAnimating];
}
- (void)nsLikeSucc:(NSNotification *)notification {
    [tableView reloadData];
    [tableView.infiniteScrollingView stopAnimating];
}
- (void)nsLikeFail:(NSNotification *)notification {
    [tableView reloadData];
    [tableView.infiniteScrollingView stopAnimating];
}

@end

