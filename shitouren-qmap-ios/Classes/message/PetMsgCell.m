//
//  PetMsgCell.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/14.
//
//

#import "PetMsgCell.h"

@implementation PetMsgCell

- (void)awakeFromNib {
    // Initialization code
}

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
        
        uiZoneName = [[UILabel alloc] init];
        [uiZoneName setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiZoneName setBackgroundColor:[UIColor clearColor]];
        [uiZoneName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [uiZoneName setTextAlignment:NSTextAlignmentLeft];
        
        uiMsg = [[UILabel alloc]init];
        [uiMsg setTextColor:UIColorFromRGB(0xedb95e, 1.0f)];
        [uiMsg setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
        //        uiMsg.layer.cornerRadius = 5.0f;
        [uiMsg setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
        [uiMsg setTextAlignment:NSTextAlignmentLeft];
        uiMsg.numberOfLines = 0;
        //        uiMsg.clipsToBounds = YES;
        
        uiBackGround = [[UIView alloc]init];
        uiBackGround.clipsToBounds = YES;
        uiBackGround.layer.cornerRadius = 10.0f;
        [uiBackGround setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
        
        uiTime = [[UILabel alloc]init];
        [uiTime setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiTime setBackgroundColor:[UIColor clearColor]];
        [uiTime setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [uiTime setTextAlignment:NSTextAlignmentRight];
        
        [uiBackGround addSubview:uiUserImage];
        [uiBackGround addSubview:uiUserName];
        [uiBackGround addSubview:uiZoneName];
        [uiBackGround addSubview:uiTime];
        [uiBackGround addSubview:uiMsg];
        [self.contentView addSubview:uiBackGround];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(MsgItem *)item
{
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat width = mainFrame.size.width;
    CGFloat height = 150;//mainFrame.size.height;
    
    [uiUserImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.userItem.thumblink]]]];
    
    NSString *strName = [NSString stringWithFormat:@"%@,%@", item.userItem.name, item.userItem.intro ];
    uiUserName.text = strName;
    uiUserName.frame = CGRectMake(70, 10, 200, 25);
    
    uiZoneName.text = item.userItem.zone;
    uiZoneName.frame = CGRectMake(70, 35, 200, 25);
    
    NSString *strMsg = item.strMsg;
    CGSize size = [strMsg sizeWithFont:uiMsg.font constrainedToSize:CGSizeMake(width-50, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    uiMsg.frame = CGRectMake(10, 70, width-50, size.height);
    uiMsg.text = strMsg;
    //    uiMsg.layer.frame = CGRectMake(10, 10, width-20-20, size.height + 10-20);
    
//    uiMsgView.frame = CGRectMake(10, 70, width-30, size.height + 10);
    
    uiTime.text = item.strTime;
    uiTime.frame = CGRectMake(0, height-20-25, width-30, 25);
    
    uiBackGround.frame = CGRectMake(10, 10, width - 20, height - 20);
    
    self.frame = CGRectMake(0, 0, width, height);

}

@end
