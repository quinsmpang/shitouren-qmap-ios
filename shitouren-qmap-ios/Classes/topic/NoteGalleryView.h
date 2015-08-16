#import "NoteItem.h"

@protocol NoteGalleryViewDelegate;

@interface NoteGalleryView : UIView<UIScrollViewDelegate>
{
    UIScrollView *uiScrollView;
    UIPageControl *uiPageControl;
}
@property (assign, nonatomic) id <NoteGalleryViewDelegate> delegate;
-(void)start:(NoteItem*)pNote :(id<NoteGalleryViewDelegate>)pDelegate;
-(UIImage*)currentImg;
@end

@protocol NoteGalleryViewDelegate<NSObject>
@optional
- (void)NGVDback;
@end
