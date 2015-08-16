#import "TopicView.h"
#import "UIImageView+WebCache.h"
#import "TopicViewController.h"

@implementation TopicView

@synthesize clickItem, topicManager;
@synthesize listView,noteView,galleryView;
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        self.userInteractionEnabled = YES;
        
        topicManager = [[TopicManager alloc] init];
        topicLimit = 10;
        noteLimit = 5;
        
        CGRect mainFrame = self.frame;
        mainFrame.origin = CGPointMake(0, 0);
        mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
        
        listView = [[TopicListView alloc] initWithFrame:mainFrame];
        [listView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        listView.topicManager = topicManager;
        
        noteView = [[NoteListView alloc] initWithFrame:mainFrame];
        [noteView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        noteView.alpha = 0.0f;
        
        galleryView = [[NoteGalleryView alloc] initWithFrame:mainFrame];
        galleryView.alpha = 0.0f;
        
        [self addSubview:listView];
        [self addSubview:noteView];
        [self addSubview:galleryView];
        
        stateList = [[TopicStateList alloc]init:self];
        stateNote = [[TopicStateNote alloc]init:self];
        stateGallery = [[TopicStateGallery alloc]init:self];
        [self setState:stateList];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
    }
    return self;
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)startList
{
    [listView start:self];
    [topicManager getStart:topicLimit];
}

- (void)goNote:(NSInteger)row {
    self.clickItem =  [topicManager.listShow objectAtIndex:row];
    [noteView start:self.clickItem :self];
    [self.clickItem.noteManager getStart:noteLimit];
    
    noteView.alpha = 1.0f;
    noteView.transform = CGAffineTransformTranslate(noteView.transform, noteView.frame.size.width, 0.0f);
    [self setState:stateNote];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        listView.transform = CGAffineTransformScale(listView.transform, 0.8f, 0.8f);
        listView.alpha = 0.0f;
        noteView.transform = CGAffineTransformTranslate(noteView.transform, -noteView.frame.size.width, 0.0f);
    }completion:^(BOOL bl){
        if( self.delegate != nil ){
            [self.delegate TVDnote];
        }
    }];
}

- (void)goGallery:(NoteItem*)pNote {
    [galleryView start:pNote :self];
    
    galleryView.alpha = 1.0f;
    galleryView.transform = CGAffineTransformTranslate(galleryView.transform, galleryView.frame.size.width, 0.0f);
    [self setState:stateGallery];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        noteView.transform = CGAffineTransformScale(noteView.transform, 0.8f, 0.8f);
        noteView.alpha = 0.0f;
        galleryView.transform = CGAffineTransformTranslate(galleryView.transform, -galleryView.frame.size.width, 0.0f);
    }completion:^(BOOL bl){
        if( self.delegate != nil ){
            [self.delegate TVDgallery];
        }
    }];
}

- (void)back2nav {
    [self.delegate TVDback];
}

- (void)back2list {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
        listView.transform = CGAffineTransformScale(listView.transform, 1.25f, 1.25f);
        listView.alpha = 1.0f;
        noteView.transform = CGAffineTransformTranslate(noteView.transform, noteView.frame.size.width, 0.0f);
//        [((TopicViewController*)(self.delegate)).navigationController setNavigationBarHidden:NO animated:NO];
    }completion:^(BOOL bl){
        noteView.alpha = 0.0f;
        noteView.transform = CGAffineTransformTranslate(noteView.transform, -noteView.frame.size.width, 0.0f);
        if( self.delegate != nil ){
            [self.delegate TVDlist];
        }
        [self setState:stateList];
    }];
}

- (void)back2note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
            noteView.transform = CGAffineTransformScale(noteView.transform, 1.25f, 1.25f);
            noteView.alpha = 1.0f;
            galleryView.transform = CGAffineTransformTranslate(galleryView.transform, galleryView.frame.size.width, 0.0f);
        }completion:^(BOOL bl){
            galleryView.alpha = 0.0f;
            galleryView.transform = CGAffineTransformTranslate(galleryView.transform, -galleryView.frame.size.width, 0.0f);
            if( self.delegate != nil ){
                [self.delegate TVDnote];
            }
            [self setState:stateNote];
        }];
    });
}

#pragma mark -
#pragma mark ---NoteBannerDelegate delegate---

- (void)NBDpost:(TopicItem*)pNote {
    if( delegate != nil ){
        [delegate TVDpost:pNote];
    }
}

- (void)NBDlike:(TopicItem*)pNote {
    if( delegate != nil ){
        [delegate TVDlike:pNote];
    }
}

#pragma mark -
#pragma mark ---TopicListViewDelegate delegate---

- (void)TLVDclick:(NSInteger)row
{
    [self goNote:row];
}
- (void)TLVDrefresh
{
}
- (void)TLVDmore
{
    [topicManager getNext:topicLimit];
}

#pragma mark -
#pragma mark ---NoteListViewDelegate delegate---

- (void)NLVDclick:(NoteItem*)pNote
{
    [self goGallery:pNote];
}
- (void)NLVDrefresh
{
}
- (void)NLVDmore
{
    [self.clickItem.noteManager getNext:noteLimit];
}

#pragma mark -
#pragma mark ---NoteTagViewDelegate delegate---

- (void)NTVDclick:(NSString*)pTag
{
}

#pragma mark -
#pragma mark ---NotePlaceViewDelegate delegate---

- (void)NPVDclick:(NSString*)pTag
{
}

#pragma mark -
#pragma mark ---NoteGalleryViewDelegate delegate---

- (void)setState:(TopicStateBase *)newStat {
    if( newStat == nil ){
        return;
    }
    stateNow = newStat;
    [newStat start];
}

@end


#pragma mark -------TopicStateBase Class-------
@implementation TopicStateBase
-(void)start {
}
-(id)init:(TopicView *)pOwner {
    self = [super init];
    if (self) {
        owner = pOwner;
    }
    return self;
}
@end
@implementation TopicStateList
-(void)start {
    if( owner != nil ){
    }
}
-(void)TSDback {
    [owner back2nav];
}
@end
@implementation TopicStateNote
-(void)start {
    if( owner != nil ){
    }
}
-(void)TSDback{
    [owner back2list];
}
@end
@implementation TopicStateGallery
-(void)start {
    if( owner != nil ){
    }
}
-(void)TSDback{
    [owner back2note];
}
@end

