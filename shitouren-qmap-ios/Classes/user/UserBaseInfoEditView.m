//
//  UserBaseInfoEditView.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/30.
//
//

#import "UserBaseInfoEditView.h"

@implementation UserBaseInfoEditView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
//        [self setBackgroundColor:UIColorFromRGB(0xffff00, 1.0f)];
        
        uiZone = [[UITextField alloc]initWithFrame:CGRectMake(30, 40, self.frame.size.width-60, 30)];
        [uiZone setBorderStyle:UITextBorderStyleRoundedRect];
        uiZone.placeholder = @"个人空间的名称";
        
        uiIntro = [[UITextField alloc]initWithFrame:CGRectMake(30, 90, self.frame.size.width-60, 30)];
        [uiIntro setBorderStyle:UITextBorderStyleRoundedRect];
        uiIntro.placeholder = @"个人简介";
        
        [self addSubview:uiZone];
        [self addSubview:uiIntro];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSString*)getIntro
{
    return uiIntro.text;}

- (NSString*)getZone
{
    return uiZone.text;
}

@end
