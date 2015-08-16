#import "TopicBanner.h"
#import "TopicItem.h"
#import "UIImageView+WebCache.h"

@implementation TopicBanner

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect mainFrame = self.frame;
        mainFrame.origin = CGPointMake(0, 0);
        mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
        
        UIImageView *border = [[UIImageView alloc] init];
        CGRect borderFrame = CGRectMake(10, 10, mainFrame.size.width-20,mainFrame.size.height-20);
        border.frame = borderFrame;
        border.layer.cornerRadius = 10;
        border.layer.masksToBounds = YES;
        border.layer.borderWidth = 2;
        border.layer.borderColor = UIColorFromRGB(0x8fce4a,1.0f).CGColor;
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 15, CGRectGetWidth(self.frame)-30, CGRectGetHeight(self.frame)-30)];
//        _scrollView.backgroundColor = [UIColor purpleColor];
        _scrollView.delegate = self;//设置代理UIscrollViewDelegate
        _scrollView.showsVerticalScrollIndicator = NO;//是否显示竖向滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;//是否显示横向滚动条
        _scrollView.pagingEnabled = YES;//是否设置分页
        _scrollView.layer.cornerRadius = 6;
        _scrollView.layer.masksToBounds = YES;
        _scrollView.layer.borderColor = [UIColor clearColor].CGColor;
        
        UIView *indicateView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetHeight(self.frame)-20-15, CGRectGetWidth(self.frame)-30, 20)];
        indicateView.backgroundColor = [UIColor clearColor];
        UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(indicateView.frame), CGRectGetHeight(indicateView.frame))];
        alphaView.backgroundColor = [UIColor clearColor];
        alphaView.alpha = 0.7;
        //分页控制
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(indicateView.frame)-20, 20)];
        _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _pageControl.currentPage = 0;
        //    _pageControl.backgroundColor  = [UIColor greenColor];
        [indicateView addSubview:_pageControl];
        //图片张数
        _imageNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(indicateView.frame)-20, 20)];
        _imageNum.font = [UIFont boldSystemFontOfSize:15];
        _imageNum.backgroundColor = [UIColor clearColor];
        _imageNum.textColor = [UIColor whiteColor];
        _imageNum.textAlignment = NSTextAlignmentRight;
        //        [containerView addSubview:_imageNum];
        [indicateView addSubview:alphaView];
        
        [self addSubview:border];
        [self addSubview:_scrollView];
        [self addSubview:indicateView];
        
        /*
         ***配置定时器，自动滚动广告栏
         */
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
    }
    return self;
}

-(void)timerAction:(NSTimer *)timer{
    if (_totalNum>1) {
        CGPoint newOffset = _scrollView.contentOffset;
        newOffset.x = newOffset.x + CGRectGetWidth(_scrollView.frame);
        //    NSLog(@"newOffset.x = %f",newOffset.x);
        if (newOffset.x > (CGRectGetWidth(_scrollView.frame) * (_totalNum-1))) {
            newOffset.x = 0 ;
        }
        int index = newOffset.x / CGRectGetWidth(_scrollView.frame);   //当前是第几个视图
        newOffset.x = index * CGRectGetWidth(_scrollView.frame);
        _imageNum.text = [NSString stringWithFormat:@"%d / %ld",index+1,_totalNum];
        [_scrollView setContentOffset:newOffset animated:YES];
    }else{
        [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
    }
}

#pragma mark- PageControl绑定ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{//滚动就执行（会很多次）
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }else {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
        _pageControl.currentPage = index;
        for (UIView *view in scrollView.subviews) {
            if(view.tag == index){
                
            }else{
                
            }
        }
    }
    //    NSLog(@"string%f",scrollView.contentOffset.x);
}

- (void)start:(TopicManager *)pTopicManager
{
    if( pTopicManager.listShow.count == 0 ){
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        [img setBackgroundColor:[UIColor clearColor]];
        img.userInteractionEnabled = YES;
        [_scrollView addSubview:img];
        _imageNum.text = @"正在加载...";
        return;
    }
    _totalNum = pTopicManager.listShow.count>5?5:pTopicManager.listShow.count;
    for (int i = 0; i<_totalNum; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        img.contentMode = UIViewContentModeScaleAspectFill;
        [img sd_setImageWithURL:[NSURL URLWithString:((TopicItem*)[pTopicManager.listShow objectAtIndex:i]).imglink]];
        [img setTag:i];
        [_scrollView addSubview:img];
    }
    _imageNum.text = [NSString stringWithFormat:@"%ld / %ld",_pageControl.currentPage+1,_totalNum];
    _pageControl.numberOfPages = _totalNum; //设置页数 //滚动范围 600=300*2，分2页
    CGRect frame;
    frame = _pageControl.frame;
    frame.size.width = 15*_totalNum;
    _pageControl.frame = frame;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame)*_totalNum,CGRectGetHeight(_scrollView.frame));//滚动范围 600=300*2，分2页
}
- (void)openTimer{
    [_timer setFireDate:[NSDate distantPast]];//开启定时器
}
- (void)closeTimer{
    [_timer setFireDate:[NSDate distantFuture]];//关闭定时器
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
