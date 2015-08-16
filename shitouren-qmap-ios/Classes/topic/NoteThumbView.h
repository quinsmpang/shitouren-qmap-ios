#import "NoteItem.h"
#import "NoteListView.h"
#import "NoteTagView.h"
#import "NotePlaceView.h"
#import "UIImageView+WebCache.h"

@interface NoteThumbView : UIView<UICollectionViewDataSource,UICollectionViewDelegate> {
}
@property (strong, nonatomic) UIImageView       *uiNoteImgMain;
@property (strong, nonatomic) NoteTagView       *uiNoteTagView;
@property (strong, nonatomic) UICollectionView  *uiNoteThumbList;
@property (strong, nonatomic) NoteItem          *note;
@property (strong, nonatomic) id<NoteListViewDelegate,NoteTagViewDelegate,NotePlaceViewDelegate> delegate;

-(void)start:(NoteItem*)pNote :(id<NoteListViewDelegate,NoteTagViewDelegate,NotePlaceViewDelegate>)pDelegate;
-(void)stop;
@end
