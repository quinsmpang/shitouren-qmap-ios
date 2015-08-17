//
//  MainMsgView.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/10.
//
//

#import "MainMsgView.h"

@implementation MainMsgItem
@synthesize imageName, title;
- (id)init:(NSString*)t :(NSString*)name
{
    self = [super init];
    if (self) {
        imageName = name;
        title = t;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    MainMsgItem *copy = [[[self class] allocWithZone: zone] init];
    copy.imageName = self.imageName;
    copy.title = self.title;
    return copy;
}
@end

@implementation MainMsgView
@synthesize delegate;

CGFloat cellHeight = 100;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
        
        array = [[NSMutableArray alloc]init];
        [array addObject:[[MainMsgItem alloc]init:@"我的消息" :@"msg_1.png"]];
        [array addObject:[[MainMsgItem alloc]init:@"宠物消息" :@"msg_2.png"]];
        [array addObject:[[MainMsgItem alloc]init:@"收到的赞" :@"msg_3.png"]];
        [array addObject:[[MainMsgItem alloc]init:@"系统消息" :@"msg_4.png"]];
        
        tv = [[UITableView alloc]initWithFrame:CGRectMake(25, 20, frame.size.width - 50,  cellHeight * 4)];
        [tv setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [tv setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [tv setShowsVerticalScrollIndicator:NO];
        [tv setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
        tv.dataSource = self;
        tv.delegate = self;
        [tv.layer setCornerRadius:10];
        
        [self addSubview:tv];
        
    }
    return self;
}

-(void)onSelectItem:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    NSIndexPath *path = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    [tv selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    [self tableViewSelectItem:btn.tag];
}

-(void)tableViewSelectItem:(long)index
{
    NSLog(@"当前选中了。。。%ld", index);
    switch (index) {
        case 0:
            [delegate switchToMyMsg];
            break;
        case 1:
            [delegate switchToPetMsg];
            break;
        case 2:
            [delegate switchToSupportMsg];
            break;
        case 3:
            [delegate switchToSystemMsg];
            break;
            
        default:
            break;
    }
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
    //    NSInteger count = 0;
    //    if(manager.msgList.count != nil)
    //    {
    //        count = tableData.count;
    //    }
    return array.count;
}

-(CGFloat)tableView:(UITableView *)pTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return 60+44;
    //    }
//    UITableViewCell *cell = [self tableView:tvMsg cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)pTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if( [indexPath row] == topicManager.listShow.count ) {
    //        return loadMoreCell;
    //    }
//    MsgCell *cell = [[MsgCell alloc] init];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, pTableView.frame.size.width, cellHeight)];
    [cell.imageView setImage:[UIImage imageNamed:@"msg_bg_1.png"]];
    
    MainMsgItem *item = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    [img setImage:[UIImage imageNamed:item.imageName]];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(pTableView.frame.size.width-50, (cellHeight-40)/2, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"base-3-1.png"] forState:UIControlStateNormal];
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(onSelectItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:btn];
    [cell.imageView addSubview:img];
    //    if (tableData != nil)
    //    {
//    MsgItem *item =  [manager.msgList objectAtIndex:indexPath.row];
//    [cell setCell:item];
    //    }
    return cell;
}

-(void)tableView:(UITableView *)pTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return;
    //    }
    //    if( self.delegate ){
    //        [self.delegate selectItem:indexPath.row];
    //    }
    [self tableViewSelectItem:indexPath.row];
    return;
}

@end
