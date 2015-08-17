//
//  AboutViewController.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/15.
//
//

#import "AboutViewController.h"

@implementation LineItem

@synthesize ptBegin,ptEnd,colorR,colorG,colorB,colorA;

- (id)initWithBeginPoint:(CGPoint)begin
                EndPoint:(CGPoint)end
                  ColorR:(CGFloat)r
                  ColorG:(CGFloat)g
                  ColorB:(CGFloat)b
                  ColorA:(CGFloat)a
{
    self = [super init];
    if (self) {
        self.ptBegin = begin;
        self.ptEnd = end;
        self.colorR = r;
        self.colorG = g;
        self.colorB = b;
        self.colorA = a;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    LineItem *copy = [[[self class] allocWithZone: zone] init];
    copy.ptBegin = self.ptBegin;
    copy.ptEnd = self.ptEnd;
    copy.colorR = self.colorR;
    copy.colorG = self.colorG;
    copy.colorB = self.colorB;
    copy.colorA = self.colorA;
    return copy;
}


@end

@implementation FollowItem

@synthesize strCaption;

@end

@interface AboutViewController ()

@end

@implementation AboutViewController

NSString *strIntro = @"城市达人是一款城市在线手绘地图，拥有全国热门旅游目的地城市20个，一键查询目的地热门景点游览信息。直观可视化的了解景点路线分布。";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
    
    baseTitle.text = @"关于城市达人";

    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(applicationFrame.size.width/2 - 40, 20, 80, 80)];
    imageView.image = [UIImage imageNamed:@"icon-100"];
    [imageView.layer setCornerRadius:40];
    imageView.clipsToBounds = YES;
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 105, applicationFrame.size.width, 20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *versionString = [NSString stringWithFormat:@"城市达人 V%@", version];
    CGSize labeSize = [versionString sizeWithFont:label.font];
    label.text = versionString;
    label.textColor = UIColorFromRGB(0xb29474, 1.0f);
    label.frame = CGRectMake(0, 105, applicationFrame.size.width, labeSize.height);
    
    uiIntroTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 100, 30)];
    uiIntroTitle.text = @"简介";
    uiIntroTitle.font = [UIFont fontWithName:@"FZY3JW--GB1-0" size:20];
    uiIntroTitle.textColor = UIColorFromRGB(0xb29474, 1.0f);
    
    uiIntro = [[UILabel alloc]initWithFrame:CGRectMake(12, 155, applicationFrame.size.width-24, 50)];
    uiIntro.font = [UIFont fontWithName:@"FZY1JW--GB1-0" size:14];
    uiIntro.text = strIntro;
    uiIntro.textColor = UIColorFromRGB(0x5d493d, 1.0f);
    uiIntro.numberOfLines = 0;
    CGSize introSize = [strIntro sizeWithFont:uiIntro.font forWidth:applicationFrame.size.width-24 lineBreakMode:NSLineBreakByWordWrapping];
    
    
    NSArray *aryLines = [[NSArray alloc]initWithObjects:[[LineItem alloc]initWithBeginPoint:CGPointMake(10, 110) EndPoint:CGPointMake(applicationFrame.size.width-20, 110) ColorR:1.0 ColorG:0 ColorB:0 ColorA:1.0],
                                               [[LineItem alloc]initWithBeginPoint:CGPointMake(10, 170 +introSize.height) EndPoint:CGPointMake(applicationFrame.size.width-20, 170+introSize.height) ColorR:1.0 ColorG:0 ColorB:0 ColorA:1.0], nil];
    [self DrawLine :aryLines];
    
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
    
//    NSLog(@"这是默认字体。。。%@", baseTitle.font.fontName);
    //FZY1JW--GB1-0 方正细圆    FZY3JW--GB1-0  方正准圆
    uiFollowTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 190+introSize.height, 100, 30)];
//    uiFollowTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    uiFollowTitle.font =  [UIFont fontWithName:@"FZY3JW--GB1-0" size:20];                //[UIFont fontNamesForFamilyName:@"res/ttf/fzxyjt.ttf"];
    uiFollowTitle.text = @"关注我们";
    uiFollowTitle.textColor = UIColorFromRGB(0xb29474, 1.0f);
    
    tv = [[UITableView alloc]initWithFrame:CGRectMake(12, 250, applicationFrame.size.width-24, 400)];
    [tv setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
    tv.layer.cornerRadius = 10;
    tv.delegate = self;
    tv.dataSource = self;
    tv.scrollEnabled = NO;
    
    lUpdate = [[UILabel alloc]initWithFrame:CGRectMake(30, 250, 100, 30)];
    lUpdate.text = @"检查更新";
    
    bUpdate = [[UIButton alloc] initWithFrame:CGRectMake(applicationFrame.size.width-50, 250, 15, 30)];
    [bUpdate setImage:[UIImage imageNamed:@"base-3-1.png"] forState:UIControlStateNormal];
    [bUpdate addTarget:self action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];

    
    lJudge = [[UILabel alloc]initWithFrame:CGRectMake(30, 290, 100, 30)];
    lJudge.text = @"赏个好评";
    
    bJudge = [[UIButton alloc] initWithFrame:CGRectMake(applicationFrame.size.width-50, 290, 15, 30)];
    [bJudge setImage:[UIImage imageNamed:@"base-3-1.png"] forState:UIControlStateNormal];
    [bJudge addTarget:self action:@selector(judge:) forControlEvents:UIControlEventTouchUpInside];
    
    lWX = [[UILabel alloc]initWithFrame:CGRectMake(30, 330, 100, 30)];
    lWX.text = @"微信";
    
    bWX = [[UIButton alloc] initWithFrame:CGRectMake(applicationFrame.size.width-50, 330, 15, 30)];
    [bWX setImage:[UIImage imageNamed:@"base-3-1.png"] forState:UIControlStateNormal];
    [bWX addTarget:self action:@selector(wx:) forControlEvents:UIControlEventTouchUpInside];

    lWB = [[UILabel alloc]initWithFrame:CGRectMake(30, 370, 100, 30)];
    lWB.text = @"微博";
    
    bWB = [[UIButton alloc] initWithFrame:CGRectMake(applicationFrame.size.width-50, 370, 15, 30)];
    [bWB setImage:[UIImage imageNamed:@"base-3-1.png"] forState:UIControlStateNormal];
    [bWB addTarget:self action:@selector(wb:) forControlEvents:UIControlEventTouchUpInside];

    lQ = [[UILabel alloc]initWithFrame:CGRectMake(30, 410, 100, 30)];
    lQ.text = @"Q群";
    
    bQ = [[UIButton alloc] initWithFrame:CGRectMake(applicationFrame.size.width-50, 410, 15, 30)];
    [bQ setImage:[UIImage imageNamed:@"base-3-1.png"] forState:UIControlStateNormal];
    [bQ addTarget:self action:@selector(QQ:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageView];
    [self.view addSubview:label];
    [self.view addSubview:uiIntroTitle];
    [self.view addSubview:uiIntro];
    [self.view addSubview:uiFollowTitle];
    [self.view addSubview:tv];
    
//    [self.view addSubview:lUpdate];
//    [self.view addSubview:lJudge];
//    [self.view addSubview:lWX];
//    [self.view addSubview:lWB];
//    [self.view addSubview:lQ];
//    
//    [self.view addSubview:bUpdate];
//    [self.view addSubview:bJudge];
//    [self.view addSubview:bWX];
//    [self.view addSubview:bWB];
//    [self.view addSubview:bQ];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DrawLine:(NSArray *)aryLines
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];

    uiLine=[[UIImageView alloc] initWithFrame:frame];
    UIGraphicsBeginImageContext(frame.size);
    [uiLine.image drawInRect:CGRectMake(0, 0, uiLine.frame.size.width, uiLine.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    
    for (LineItem *line in aryLines) {
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), line.colorR, line.colorG, line.colorB, line.colorA);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), line.ptBegin.x, line.ptBegin.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), line.ptEnd.x, line.ptEnd.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    uiLine.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [self.view addSubview:uiLine];

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
    [self baseDeckAndNavBack];
    if( callback ){
        callback( 1 );
    }
}

- (void)update:(id)sender
{
    
}

- (void)judge:(id)sender
{
    
}

- (void)wx:(id)sender
{
    
}

- (void)wb:(id)sender
{
    
}

- (void)QQ:(id)sender
{
    
}

#pragma TableView的处理

-(NSInteger)tableView:(UITableView *)pTableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

-(CGFloat)tableView:(UITableView *)pTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return 60+44;
    //    }
//    UITableViewCell *cell = [self tableView:tvMsg cellForRowAtIndexPath:indexPath];
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)pTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if( [indexPath row] == topicManager.listShow.count ) {
    //        return loadMoreCell;
    //    }
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, pTableView.frame.size.width, 70)];
    cell.textLabel.text = @"分享应用";
    return cell;
}

-(void)tableView:(UITableView *)pTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([indexPath row] == topicManager.listShow.count) {
    //        return;
    //    }
    //    if( self.delegate ){
    //        [self.delegate selectItem:indexPath.row];
    //    }
    return;
}



@end
