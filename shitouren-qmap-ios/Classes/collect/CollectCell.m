//
//  CollectCell.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/7.
//
//

#import "CollectCell.h"

@implementation CollectCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
        
        uiTypeImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 12, 12)];
//        [uiTypeImage setImage:[UIImage imageNamed:@"collect_1.png"]];
        uiTypeBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        [uiTypeBackground setImage:[UIImage imageNamed:@"collect_bg.png"]];
        
        uiBtnSelect = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 50, 50)];
        [uiBtnSelect setImage:[UIImage imageNamed:@"collect_4.png"] forState:UIControlStateNormal];
        [uiBtnSelect setImage:[UIImage imageNamed:@"collect_5.png"] forState:UIControlStateSelected];
        [uiBtnSelect addTarget:self action:@selector(onSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        uiBtnHide = [[UIButton alloc]initWithFrame:CGRectMake(mainFrame.size.width-50, 50, 50, 50)];
        [uiBtnHide setImage:[UIImage imageNamed:@"collect_hide1.png"] forState:UIControlStateNormal];
        [uiBtnHide setImage:[UIImage imageNamed:@"collect_hide2.png"] forState:UIControlStateSelected];
        [uiBtnHide addTarget:self action:@selector(onHide:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:uiTypeBackground];
        [self addSubview:uiTypeImage];
        
        [self addSubview:uiBtnSelect];
        [self addSubview:uiBtnHide];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshUI:(CollectItem *)item
{
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    switch (item.collectType) {
        case 0:
//            self.frame = CGRectMake(0, 0, mainFrame.size.width, 100);
            [uiTypeImage setImage:[UIImage imageNamed:@"collect_1.png"]];
            break;
        case 1:
//            self.frame = CGRectMake(0, 0, mainFrame.size.width, 200);
            [uiTypeImage setImage:[UIImage imageNamed:@"collect_2.png"]];
            break;
        case 2:
//            self.frame = CGRectMake(0, 0, mainFrame.size.width, 300);
            [uiTypeImage setImage:[UIImage imageNamed:@"collect_3.png"]];
            break;
        default:
            break;
    }
    
    self.frame = CGRectMake(0, 0, mainFrame.size.width, 100);
    
}

- (void)onSelect:(id)sender
{
    
    BOOL s = uiBtnSelect.selected;
    uiBtnSelect.selected = !s;
}

- (void)onHide:(id)sender
{
    BOOL s = uiBtnHide.selected;
    uiBtnHide.selected = !s;
}
@end
