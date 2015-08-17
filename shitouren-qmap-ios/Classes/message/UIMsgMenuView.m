//
//  UIMsgMenuView.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/13.
//
//

#import "UIMsgMenuView.h"

@implementation UIMsgMenuView

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:UIColorFromRGB(0x000000, 0.4f)];
        
        CGFloat viewHeight = 200;
        uiMenuView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-viewHeight, frame.size.width, viewHeight)];
        uiMenuView.backgroundColor = UIColorFromRGB(0xffffff, 1.0f);
        
        uiBtnClean = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-150)/2, 20, 150, 30)];
        [uiBtnClean setBackgroundColor:UIColorFromRGB(0xedb95e, 1.0f)];
        [uiBtnClean setTitle:@"清除全部消息" forState:UIControlStateNormal];
        [uiBtnClean setTitleColor:UIColorFromRGB(0xffffff, 1.0f) forState:UIControlStateNormal];
        [uiBtnClean.layer setCornerRadius:10];
        [uiBtnClean setClipsToBounds:YES];
        [uiBtnClean addTarget:self action:@selector(onCleanAll:) forControlEvents:UIControlEventTouchUpInside];
        
        uiBtnCancel = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-150)/2, 70, 150, 30)];
        [uiBtnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [uiBtnCancel setTitleColor:UIColorFromRGB(0xb29474, 1.0f) forState:UIControlStateNormal];
        [uiBtnCancel addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        
        [uiMenuView addSubview:uiBtnClean];
        [uiMenuView addSubview:uiBtnCancel];
        
        [self addSubview:uiMenuView];
    }
    return self;
}

- (void)onCleanAll:(id)sender
{
    if (delegate)
    {
        [delegate onCleanAll];
    }
}

-(void)onCancel:(id)sender
{
    NSLog(@".................");
    if (delegate) {
        [delegate onHideMsgMenu];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
