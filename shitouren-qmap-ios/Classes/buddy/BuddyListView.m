//
//  BuddyView.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/21.
//
//

#import "BuddyListView.h"
#import "BuddyItem.h"

@implementation BuddyListView

@synthesize  tableView, buddyManager, delegate;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
        CGRect mainFrame = self.frame;
        mainFrame.origin = CGPointMake(25, 0);
        mainFrame.size = CGSizeMake(mainFrame.size.width-50,mainFrame.size.height - 20);
        
//        tableData = [buddyManager getTableData:0];
        
        tableView = [[UITableView alloc]initWithFrame:mainFrame];
        [tableView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [tableView setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView.layer setCornerRadius:10];
        
//        __weak TopicListView *weakSelf = self;
        
//        [self.tableView addInfiniteScrollingWithActionHandler:^{
//            NSLog(@"下拉列表");
//            int64_t delayInSeconds = 1.0;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
////                [weakSelf.delegate TLVDmore];
//                
//            });
//        }];


        [self addSubview:tableView];
        
        
    }
    return self;
}

-(void)refreshData:(int)index
{
    
    tableData = [buddyManager getTableData:index];
    [tableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma TableView的处理

-(NSInteger)tableView:(UITableView *)pTableView numberOfRowsInSection:(NSInteger)section {
    //    return topicManager.listShow.count+1;
    NSInteger count = 0;
    if(tableData != nil)
    {
        count = tableData.count;
    }
    return count;
}

-(CGFloat)tableView:(UITableView *)pTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return 60+44;
    //    }
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)pTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if( [indexPath row] == topicManager.listShow.count ) {
    //        return loadMoreCell;
    //    }
    BuddyCell *cell = [[BuddyCell alloc] init];
    if (tableData != nil)
    {
        BuddyItem *item =  [tableData objectAtIndex:indexPath.row];
        cell.delegate = self;
        [cell start:item : indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)pTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return;
    //    }
    if( self.delegate ){
        [self.delegate selectItem:indexPath.row];
    }
    return;
}

#pragma cell的处理
-(void)onRelationShip:(long)index
{
    NSLog(@"listView  ..%ld", index);
    if (delegate) {
        [delegate onRelationShip:index];
    }
}

@end
