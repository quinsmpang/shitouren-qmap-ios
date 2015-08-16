#import "TopicItem.h"
#import "TopicShareItem.h"
#import "TopicListView.h"
#import "NoteListView.h"
#import "NoteGalleryView.h"
#import "TopicManager.h"

@class TopicStateBase;
@class TopicStateList;
@class TopicStateNote;
@class TopicStateGallery;
@protocol TopicViewDelegate;

@interface TopicView : UIView<UIAlertViewDelegate,UITextFieldDelegate,TopicListViewDelegate,NoteListViewDelegate,NoteGalleryViewDelegate,NoteBannerDelegate,NotePlaceViewDelegate,NoteTagViewDelegate>
{
    TopicStateBase *stateNow;
    TopicStateList *stateList;
    TopicStateNote *stateNote;
    TopicStateGallery *stateGallery;
    int topicLimit;
    int noteLimit;
}
@property (strong, nonatomic) TopicListView    *listView;
@property (strong, nonatomic) NoteListView     *noteView;
@property (strong, nonatomic) NoteGalleryView  *galleryView;
@property (strong, nonatomic) TopicItem *clickItem;
@property (strong, nonatomic) TopicManager *topicManager;
@property (assign, nonatomic) id <TopicViewDelegate> delegate;
-(void)startList;
-(void)back2nav;
-(void)back2list;
-(void)back2note;
@end

@protocol TopicViewDelegate<NSObject>
@optional
- (void)TVDback;
- (void)TVDlist;
- (void)TVDnote;
- (void)TVDgallery;
- (void)TVDpost:(TopicItem*)pNote;
- (void)TVDlike:(TopicItem*)pNote;
- (void)TVDshare:(TopicShareItem*)pItem;
@end

@protocol TopicStateDelegate<NSObject>
@optional
-(void)TSDback;
@end

@interface TopicStateBase : NSObject<TopicStateDelegate>
{
    TopicView        *owner;
}
-(id)init:(TopicView *)powner;
-(void)start;
@end

@interface TopicStateList : TopicStateBase
@end

@interface TopicStateNote : TopicStateBase
@end

@interface TopicStateGallery : TopicStateBase
@end
