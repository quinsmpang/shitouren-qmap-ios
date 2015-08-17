//
//  FollowView.m
//  qmap
//
//  Created by 石头人6号机 on 15/8/10.
//
//

#import "FollowView.h"

@implementation FollowView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
        
        
//        tv = [[UITableView alloc]initWithFrame:CGRectMake(25, 20, frame.size.width - 50,  cellHeight * 4)];
//        [tv setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//        [tv setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//        [tv setShowsVerticalScrollIndicator:NO];
//        [tv setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
//        tv.dataSource = self;
//        tv.delegate = self;
//        [tv.layer setCornerRadius:10];
//        
//        [self addSubview:tv];
//        
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

@end
