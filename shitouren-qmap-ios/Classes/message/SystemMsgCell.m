//
//  SystemMsgCell.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/14.
//
//

#import "SystemMsgCell.h"
#import "MsgItem.h"

@implementation SystemMsgCell

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
        [uiUserImage setImage:[UIImage imageNamed:@"icon-100.png"]];
        uiUserImage.layer.cornerRadius = uiUserImage.frame.size.width/2;
        uiUserImage.layer.backgroundColor = UIColorFromRGB(0xe6be78, 1.0f).CGColor;
        uiUserImage.layer.borderWidth = 3.0f;
        uiUserImage.layer.borderColor = UIColorFromRGB(0xff0000, 1.0f).CGColor;
        uiUserImage.clipsToBounds = YES;
        
        uiUserName = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 100, 25)];
        [uiUserName setTextColor:UIColorFromRGB(0xa4866c,1.0f)];
        [uiUserName setBackgroundColor:[UIColor clearColor]];
        [uiUserName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [uiUserName setTextAlignment:NSTextAlignmentLeft];
        uiUserName.text = @"系统通知";
        
//        uiZoneName = [[UILabel alloc] init];
//        [uiZoneName setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
//        [uiZoneName setBackgroundColor:[UIColor clearColor]];
//        [uiZoneName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
//        [uiZoneName setTextAlignment:NSTextAlignmentLeft];
        
        uiMsg = [[UILabel alloc]init];
        [uiMsg setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiMsg setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
        //        uiMsg.layer.cornerRadius = 5.0f;
        [uiMsg setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [uiMsg setTextAlignment:NSTextAlignmentLeft];
        uiMsg.numberOfLines = 0;
        //        uiMsg.clipsToBounds = YES;
        
        uiMsgView = [[UIView alloc]init];
        uiMsgView.clipsToBounds = YES;
        uiMsgView.layer.cornerRadius = 10.0f;
        [uiMsgView setBackgroundColor:UIColorFromRGB(0xffffff, 1.0f)];
        
        
        uiTime = [[UILabel alloc]init];
        [uiTime setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiTime setBackgroundColor:[UIColor clearColor]];
        [uiTime setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [uiTime setTextAlignment:NSTextAlignmentRight];
        
        
        
        [self.contentView addSubview:uiUserImage];
        [self.contentView addSubview:uiUserName];
//        [self.contentView addSubview:uiZoneName];
        [self.contentView addSubview:uiMsgView];
        [uiMsgView addSubview:uiMsg];
        [self.contentView addSubview:uiTime];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void )setCell:(MsgItem *)item
{
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat width = mainFrame.size.width;
    
//    [uiUserImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.userItem.thumblink]]]];
    
//    NSString *strName = [NSString stringWithFormat:@"%@,%@", item.userItem.name, item.userItem.intro ];
//    uiUserName.text = strName;
//    uiUserName.frame = CGRectMake(70, 10, 200, 25);
    
//    uiZoneName.text = item.userItem.zone;
//    uiZoneName.frame = CGRectMake(70, 35, 200, 25);
    
    NSString *strMsg = item.strMsg;
    CGSize size = [strMsg sizeWithFont:uiMsg.font constrainedToSize:CGSizeMake(width-50, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    uiMsg.frame = CGRectMake(10, 5, width-50, size.height);
    uiMsg.text = strMsg;
    //    uiMsg.layer.frame = CGRectMake(10, 10, width-20-20, size.height + 10-20);
    
    uiMsgView.frame = CGRectMake(10, 70, width-30, size.height + 10);
    
    uiTime.text = item.strTime;
    uiTime.frame = CGRectMake(0, size.height + 75+ 10, width-30, 25);
    
    self.frame = CGRectMake(0, 0, width, size.height + 70 + 30 +10);
    
}

@end
