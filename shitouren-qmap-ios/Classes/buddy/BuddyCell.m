//
//  BuddyCell.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/21.
//
//

#import "BuddyCell.h"

@implementation BuddyCell

@synthesize uiUserImage, uiUserName, uiZone, uiBtn, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        uiUserImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [uiUserImage setImage:[UIImage imageNamed:@"res/user/0.png"]];
        uiUserImage.layer.cornerRadius = uiUserImage.frame.size.width/2;
        uiUserImage.layer.backgroundColor = UIColorFromRGB(0xe6be78, 1.0f).CGColor;
        uiUserImage.layer.borderWidth = 3.0f;
        uiUserImage.layer.borderColor = UIColorFromRGB(0xff0000, 1.0f).CGColor;
        uiUserImage.clipsToBounds = YES;
        
        
        uiUserName = [[UILabel alloc] init];
        [uiUserName setTextColor:UIColorFromRGB(0xa4866c,1.0f)];
        [uiUserName setBackgroundColor:[UIColor clearColor]];
        [uiUserName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [uiUserName setTextAlignment:NSTextAlignmentLeft];
        
        uiZone = [[UILabel alloc] init];
        [uiZone setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiZone setBackgroundColor:[UIColor clearColor]];
        [uiZone setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [uiZone setTextAlignment:NSTextAlignmentLeft];
        
        uiBtn = [[UIButton alloc] init];
        uiBtn.frame = CGRectMake(100, 10, 50, 50);
        [uiBtn addTarget:self action:@selector(onRelationShip:) forControlEvents:UIControlEventTouchUpInside];
        
//        [uiBtn setBackgroundImage:[UIImage imageNamed:@"buddy_bg.png"] forState:UIControlStateNormal];
        
//        [uiBtn b
//        [uiBtn setTitle:@"关注" forState:UIControlStateNormal];
//        [uiBtn setImage:[UIImage imageNamed:@"btnBack1.png"] forState:UIControlStateNormal];
//        uiBtn.buttonType = UIButtonbuttonWithType:UIButtonTypeRoundedRect;
        
        [self.contentView addSubview:uiUserImage];
        [self.contentView addSubview:uiUserName];
        [self.contentView addSubview:uiZone];
        [self.contentView addSubview:uiBtn];
    }
    return self;
}

- (void)onRelationShip:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSLog(@"选中的按钮是：%ld",button.tag);
    if (delegate)
    {
        [delegate onRelationShip:button.tag];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)start: (BuddyItem*) item :(long)index
{
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGFloat width = mainFrame.size.width - 50;
    
//    [uiUserImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.thumblink]]]];
    
//    NSLog(@"mainFrame..%f, %f, %f, %f", mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, mainFrame.size.height);
    
    uiUserName.frame = CGRectMake(70, 10, width-120-70, 25);
    [uiUserName setNumberOfLines:0];
    [uiUserName setLineBreakMode:NSLineBreakByWordWrapping];
    NSString *text = [NSString stringWithFormat:@"%@, %@",item.name, item.intro];
    uiUserName.text = text;
    uiUserName.lineBreakMode = NSLineBreakByTruncatingTail;
    //设置一个行高上限
//    CGSize maxSize = CGSizeMake(mainFrame.size.width-50*2,64);
//    NSDictionary *attribute = @{NSFontAttributeName: uiUserName.font};
//    CGSize labelsize = [uiUserName.text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    uiUserName.frame = CGRectMake(70, 24, labelsize.width, labelsize.height);
    
    if (item.relationship == 0) {   //没有任何关系
//        [uiBtn setImage:[UIImage imageNamed:@"buddy_1.png"] forState:UIControlStateNormal];
        [uiBtn setBackgroundImage:[UIImage imageNamed:@"buddy_1.png"] forState:UIControlStateNormal];
//        uiBtn.imageView.frame = CGRectMake(0, 0, uiBtn.frame.size.width, uiBtn.frame.size.height);
    }else if (item.relationship == 1)  //关注非粉丝
    {
//        [uiBtn setImage:[UIImage imageNamed:@"buddy_2.png"] forState:UIControlStateNormal];
        [uiBtn setBackgroundImage:[UIImage imageNamed:@"buddy_2.png"] forState:UIControlStateNormal];
    }else if (item.relationship == 2)  //粉丝
    {
//        [uiBtn setImage:[UIImage imageNamed:@"buddy_3.png"] forState:UIControlStateNormal];
        [uiBtn setBackgroundImage:[UIImage imageNamed:@"buddy_1.png"] forState:UIControlStateNormal];
    }else if (item.relationship == 3)  // 互相关注
    {
        [uiBtn setBackgroundImage:[UIImage imageNamed:@"buddy_3.png"] forState:UIControlStateNormal];
    }
    uiBtn.tag = index;
    
    uiZone.frame = CGRectMake(70, uiUserName.frame.origin.y+uiUserName.frame.size.height, mainFrame.size.width-50, 22);
    uiZone.text = item.zone;
//    self.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, uiZone.frame.origin.y+uiZone.frame.size.height+15);
    
    uiBtn.frame = CGRectMake(width - 70, 10, 50, 50);
    
    self.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, 70);

}
@end
