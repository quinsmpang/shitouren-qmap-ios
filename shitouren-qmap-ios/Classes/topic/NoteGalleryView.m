#import "NoteGalleryView.h"
#import "UIImageView+WebCache.h"

@implementation NoteGalleryView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth];
        
        CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
        mainFrame.origin = CGPointMake(0, 0);
        mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
        
        uiScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height)];
        [uiScrollView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth];
        [uiScrollView setContentMode:UIViewContentModeScaleToFill];
        [uiScrollView setPagingEnabled:YES];
        [uiScrollView setScrollsToTop:YES];
        [uiScrollView setBounces:YES];
        [uiScrollView setBouncesZoom:YES];
        [uiScrollView setAlwaysBounceHorizontal:NO];
        [uiScrollView setAlwaysBounceVertical:NO];
        [uiScrollView setShowsHorizontalScrollIndicator:NO];
        [uiScrollView setShowsVerticalScrollIndicator:NO];
        [uiScrollView setBackgroundColor:[UIColor clearColor]];
        //        [uiScrollView setBackgroundColor:[UIColor redColor]];
        uiScrollView.delegate = self;
        
        uiPageControl = [[UIPageControl alloc] init];
        [uiPageControl setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth];
        [uiPageControl setBackgroundColor:[UIColor blueColor]];
        [uiPageControl setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:uiScrollView];
        [self addSubview:uiPageControl];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
    }
    return self;
}

-(void)start:(NoteItem*)pNote :(id<NoteGalleryViewDelegate>)pDelegate
{
    for (UIView *one in [uiScrollView subviews]) {
        [one removeFromSuperview];
    }
    
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    
    NSUInteger _totalNum = pNote.imgs.count;
    for (int i = 0; i<_totalNum; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*mainFrame.size.width, 0, mainFrame.size.width, mainFrame.size.height)];
        [img setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [img sd_setImageWithURL:[NSURL URLWithString:[pNote.imgs objectAtIndex:i]] placeholderImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[pNote.thumbs objectAtIndex:i]]]]];
        [img setUserInteractionEnabled:YES];
        UITapGestureRecognizer *scrollSingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back2List:)];
        [img addGestureRecognizer:scrollSingleTap];
        [img setTag:i];
        [uiScrollView addSubview:img];
    }
    uiScrollView.contentSize = CGSizeMake(mainFrame.size.width*_totalNum,mainFrame.size.height);
    [uiScrollView setContentOffset:CGPointMake(uiScrollView.frame.size.width*pNote.uiClickIndex, 0)];
    
    uiPageControl.numberOfPages = _totalNum;
    uiPageControl.frame = CGRectMake((mainFrame.size.width-15*_totalNum)/2, mainFrame.size.height-60, 15*_totalNum, 20);
    uiPageControl.currentPage = pNote.uiClickIndex;
    
}

#pragma mark- PageControl绑定ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;   //当前是第几个视图
    uiPageControl.currentPage = index;
    for (UIView *view in scrollView.subviews) {
        if(view.tag == index){
        }else{
        }
    }
}

- (UIImage*)currentImg {
    //    return ((UIImageView*)[carousel.viewsArray objectAtIndex:uiPageControl.currentPage]).image;
    return nil;
}

- (void)back2List:(id)sender {
    if( self.delegate != nil ){
        [self.delegate NGVDback];
    }
}

@end
