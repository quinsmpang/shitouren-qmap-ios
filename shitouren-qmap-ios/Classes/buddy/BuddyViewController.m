//
//  BuddyViewController.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/21.
//
//

#import "BuddyViewController.h"
#import "UserManager.h"

//@interface BuddyViewController ()
//
//@end

//void refreshUserCenterCallback(long userID, NSString *name, NSString *intro, NSString *zone, NSString *thumblink, NSString *imglink);

@implementation BuddyViewController

@synthesize listView;

-(id)init {
    self = [super init];
    if (self) {
        buddyManager = [[BuddyManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    [self getOn];

    baseTitle.text = @"出访";
    
    [buddyManager requestfrendData];
    
    buddyViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height)];
    [buddyViewContainer setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [buddyViewContainer setBackgroundColor: UIColorFromRGB(0xf1f1f1, 1.0f)];
    self.view = buddyViewContainer;
    
    
    userImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
//    [userImage setImage:[UIImage imageNamed:@"res/user/0.png"]];
    userImage.layer.cornerRadius = userImage.frame.size.width/2;
    userImage.layer.backgroundColor = UIColorFromRGB(0xe6be78, 1.0f).CGColor;
    userImage.layer.borderWidth = 3.0f;
    userImage.layer.borderColor = UIColorFromRGB(0xff0000, 1.0f).CGColor;
    userImage.clipsToBounds = YES;
//    [userImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[UserManager sharedInstance].brief.imglink]]] forState:UIControlStateNormal];
//    [userImage setImage:[UIImage imageWithData:[UserManager sharedInstance].brief.thumbdata]];
    [userImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:buddyManager.mainUser.thumblink]]]];
    
    [buddyViewContainer addSubview:userImage];
    
    userName = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 20)];
    NSString *name = buddyManager.mainUser.name;
    NSString *intro = buddyManager.mainUser.intro;
    NSString *strZone = buddyManager.mainUser.zone;
    NSString *strIntro = [[NSString alloc] initWithFormat:@"%@,%@", name, intro ];
    userName.text = strIntro;
    
    zone = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 200, 20)];
    zone.text = strZone;
    
    btnFans = [[UIButton alloc] initWithFrame:CGRectMake(30, 80, 80, 30)];
    fansTitle = [[UILabel alloc] init];
    fansNum = [[UILabel alloc] initWithFrame:CGRectMake(65 , 6, 20, 20)];
    
    btnFollow = [[UIButton alloc] initWithFrame:CGRectMake(200, 80, 120, 30)];
    followTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    followNum = [[UILabel alloc] initWithFrame:CGRectMake(65, 6, 40, 20)];
    
    btnOrther = [[UIButton alloc] initWithFrame:CGRectMake(200, 80, 120, 30)];
    ortherTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    ortherNum = [[UILabel alloc] initWithFrame:CGRectMake(65, 6, 40, 20)];
    
    btnFans.selected = YES;
    
    CGRect mainFrame = buddyViewContainer.frame;   //self.frame;
    mainFrame.origin = CGPointMake(0, 150);
    mainFrame.size = CGSizeMake(mainFrame.size.width, mainFrame.size.height - 150);
    
    listView = [[BuddyListView alloc] initWithFrame:mainFrame];
    [listView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    listView.delegate = self;
    listView.buddyManager = buddyManager;
    [listView refreshData:1];
    
    [btnFans addTarget:self action:@selector(onTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnFollow addTarget:self action:@selector(onTouch:) forControlEvents:UIControlEventTouchUpInside];
    [btnOrther addTarget:self action:@selector(onTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat w = mainFrame.size.width;
    if (buddyManager.mainUser.userid == [UserManager sharedInstance].brief.userid)
    {
        [self initButton:btnFans :fansTitle :fansNum :1 :@"粉丝" :0 :CGPointMake(80, 100) ];
        [self initButton:btnFollow :followTitle :followNum :2 :@"关注" :0 :CGPointMake(w/2, 100) ];
        [self initButton:btnOrther :ortherTitle :ortherNum :3 :@"广场" :0 :CGPointMake(w-80, 100) ];
        
        [buddyViewContainer addSubview:btnFans];
        [buddyViewContainer addSubview:btnFollow];
        [buddyViewContainer addSubview:btnOrther];
    }else
    {
        [self initButton:btnFans :fansTitle :fansNum :1 :@"粉丝" :0 :CGPointMake(100, 100) ];
        [self initButton:btnFollow :followTitle :followNum :2 :@"关注" :0 :CGPointMake(w-100, 100) ];
//        [self initButton:btnOrther :ortherTitle :ortherNum :3 :@"广场" :0 :CGPointMake(w-80, 100) ];
        
        [buddyViewContainer addSubview:btnFans];
        [buddyViewContainer addSubview:btnFollow];
//        [buddyViewContainer addSubview:btnOrther];

    }
    

    [buddyViewContainer addSubview:listView];
    [buddyViewContainer addSubview:userName];
    [buddyViewContainer addSubview:zone];
    

}

-(void)setUserData:(long)userID :(NSString*) name :(NSString*)intro : (NSString*)zonename : (NSString*)thumblink : (NSString*)imglink
{
//    NSString *strValue = [[NSString alloc]initWithFormat:@"%ld",userID ];
//    [zone setText:strValue];
//    userid = userID;
    
//    mainUser = BuddyItem
    buddyManager.mainUser.userid = userID;
    buddyManager.mainUser.name = name;
    buddyManager.mainUser.intro = intro;
    buddyManager.mainUser.zone = zonename;
    buddyManager.mainUser.thumblink = thumblink;
    buddyManager.mainUser.imglink = imglink;
}

-(void) initButton :(UIButton*) btn :(UILabel*) title :(UILabel*) num :(long) index :(NSString*) strTitle :(long) value :(CGPoint)point
{
    btn.tag = index;
    
    [btn setBackgroundImage:[UIImage imageNamed:@"buddyimage_1.png"] forState:UIControlStateSelected];   //UIControlStateNormal
    
    [title setText:strTitle];
    [title setTextColor:UIColorFromRGB(0x93cd56, 1.0f)];
    [title setFont:[UIFont boldSystemFontOfSize:20]];
    CGSize titleSize = [strTitle sizeWithFont:title.font];
    title.frame = CGRectMake(5, 3, titleSize.width, titleSize.height);
    
    NSString *strValue = [[NSString alloc]initWithFormat:@"%ld",value ];
    [num setText:strValue];
    [num setTextColor:UIColorFromRGB(0xb29474, 1.0f)];
    [num setFont:[UIFont boldSystemFontOfSize:14]];
    CGSize numSize = [strValue sizeWithFont:num.font];
    if (value < 1) {
        numSize.width = 0;
    }
    num.frame = CGRectMake(titleSize.width + 5, titleSize.height + 3 - numSize.height, numSize.width, numSize.height);
    
    point.x = point.x - (titleSize.width + numSize.width + 10)/2;
    btn.frame = CGRectMake(point.x, point.y, titleSize.width + numSize.width + 10, titleSize.height + 6);
    
    [btn addSubview:title];
    [btn addSubview:num];
    if (value == 0) {
        num.alpha = 0.0f;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTouch:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"当前点击了按钮 %ld", (long)button.tag);
    
    if (button.selected == NO)
    {
        btnFans.selected = NO;
        btnFollow.selected = NO;
        btnOrther.selected = NO;
        button.selected = YES;
        [listView refreshData:(int)button.tag];
    }
    
}

- (void)selectItem:(NSInteger) index
{
    NSLog(@"select item........%ld", index);
    
    BuddyItem *item = [buddyManager getBoddyItem:index];
    
    [self baseDeckBack];
    
//    [self toCocos:item.userid :item.name :item.intro :item.zone :item.thumblink :item.imglink ];
}

-(void)onRelationShip:(long)index
{
    NSLog(@"relationship........");
    [buddyManager requestFollow:20000029];
}

- (void)getOn
{
    AddObserver(nsSucc:, @"SHITOUREN_BUDDY_LIST_SUCC");
}

-(void)getOff
{
    DelObserver(@"SHITOUREN_BUDDY_LIST_SUCC");
}

-(void)nsSucc:(NSNotification *)notification {
    NSString *msg = (NSString*)(notification.object);
//    [self baseShowBotHud:NSLocalizedString(msg, @"")];
    NSLog(@"%@", msg);
//    CGRect mainFrame = buddyViewContainer.frame;
//    CGFloat w = mainFrame.size.width;
    
    if ([msg isEqualToString:@"follow"]) {
        if (btnFollow.selected) {
            [listView refreshData:2];
        }
        NSString *strCount = [NSString stringWithFormat:@"%lu",(unsigned long)buddyManager.frendList.count];
        followNum.text = strCount;
        followNum.alpha = 1.0f;
        CGSize titleSize = followTitle.frame.size;
        CGPoint point = btnFollow.frame.origin;
        CGSize numSize = [strCount sizeWithFont:followNum.font];
        followNum.frame = CGRectMake(titleSize.width + 5, titleSize.height + 3 - numSize.height, numSize.width, numSize.height);
        btnFollow.frame = CGRectMake(point.x, point.y, titleSize.width + numSize.width + 10, titleSize.height + 6);
//        [btnFollow setBackgroundImage:[UIImage imageNamed:@"buddyimage_1.png"] forState:UIControlStateSelected];

//        [self initButton:btnFollow :followTitle :followNum :2 :@"关注" :buddyManager.frendList.count :CGPointMake(w/2, 100) ];
    }else if ([msg isEqualToString:@"fans"]){
        if (btnFans.selected) {
            [listView refreshData:1];
        }
        NSString *strCount = [NSString stringWithFormat:@"%lu",(unsigned long)buddyManager.frendList.count];
        fansNum.text = strCount;
        fansNum.alpha = 1.0f;
        CGSize titleSize = fansTitle.frame.size;
        CGPoint point = btnFans.frame.origin;
        CGSize numSize = [strCount sizeWithFont:fansNum.font];
        fansNum.frame = CGRectMake(titleSize.width + 5, titleSize.height + 3 - numSize.height, numSize.width, numSize.height);
        btnFans.frame = CGRectMake(point.x, point.y, titleSize.width + numSize.width + 10, titleSize.height + 6);

    }else if ([msg isEqualToString:@"orth"]){
        if (btnOrther.selected) {
            [listView refreshData:3];
        }
    }
    
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
        callback( 1 );
    }
}


@end
