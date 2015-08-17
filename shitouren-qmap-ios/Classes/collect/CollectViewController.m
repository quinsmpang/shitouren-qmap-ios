//
//  CollectViewController.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/6.
//
//

#import "CollectViewController.h"

@interface CollectViewController ()

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    baseTitle.text = @"收藏";
    CGRect mainRect = [[UIScreen mainScreen]bounds];
    [self.view setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
    [self getOn];
    manager = [[CollectManager alloc]init];
    [manager requestData:userid];
    
    uiTVCollect = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainRect.size.width, mainRect.size.height)];
    [uiTVCollect setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [uiTVCollect setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    uiTVCollect.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    [uiTVCollect setBackgroundColor:[UIColor clearColor]];
    uiTVCollect.dataSource = self;
    uiTVCollect.delegate = self;
    [uiTVCollect registerClass:[CollectCell class] forCellReuseIdentifier:@"CollectCell"];
    
    uiBtnEdit = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
//    [uiBtnEdit setTitle:@"编辑" forState:UIControlStateNormal];
    [uiBtnEdit setImage:[UIImage imageNamed:@"collect_6.png"] forState:UIControlStateNormal];
//    [uiBtnEdit setTitleColor:UIColorFromRGB(0x000000, 1.0f) forState:UIControlStateNormal];
    [uiBtnEdit addTarget:self action:@selector(onEdit:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:uiEditBtn];
    
    uiBtnBarEdit = [[UIBarButtonItem alloc] initWithCustomView:uiBtnEdit];
    self.navigationItem.rightBarButtonItem = uiBtnBarEdit;

    
    [self.view addSubview:uiTVCollect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserData:(long)userID
{
    userid = userID;
}

- (void)getOn
{
    AddObserver(nsSucceed:, @"SHITOUREN_COLLECT_LIST_START");
    AddObserver(nsFail:, @"SHITOUREN_COLLECT_LIST_FAIL");
}

- (void)getOff
{
    DelObserver(@"SHITOUREN_COLLECT_LIST_START");
    DelObserver(@"SHITOUREN_COLLECT_LIST_FAIL");
}

-(void)nsFail:(NSNotification *)notification {
//    NSString *msg = (NSString*)(notification.object);
//    [self baseShowBotHud:NSLocalizedString(msg, @"")];
}

-(void)nsSucceed:(NSNotification *)notification {
    [uiTVCollect reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)baseBack:(id)sender
{
    [self getOff];
    [self baseDeckAndNavBack];
    if( callback ){
        callback( 0 );
    }
}

- (void)onEdit:(id)sender
{
    NSLog(@".............");
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count =  manager.collectData.count;
    return count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

-(UITableViewCell *)tableView:(UITableView *)pTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollectCell";
    CollectCell *cell = [pTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CollectCell alloc]init];
    }
    CollectItem *item = [manager.collectData objectAtIndex:indexPath.row];
    [cell refreshUI:item];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)pTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return 60+44;
    //    }
    UITableViewCell *cell = [self tableView:uiTVCollect cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(void)tableView:(UITableView *)pTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return;
    //    }
//    if( self.delegate ){
//        [self.delegate TLVDclick:indexPath.row];
//    }
    return;
}

@end
