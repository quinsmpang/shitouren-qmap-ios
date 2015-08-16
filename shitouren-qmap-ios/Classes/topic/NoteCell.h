#import "NoteItem.h"
#import "UserBriefItem.h"
#import "NoteThumbView.h"
#import "NoteListView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@interface NoteCell : UITableViewCell {
}
@property (strong, nonatomic) UIButton          *uiPhoto;
@property (strong, nonatomic) UILabel           *uiNameIntro;
@property (strong, nonatomic) UILabel           *uiZone;
@property (strong, nonatomic) UIImageView       *uiNoteLike;
@property (strong, nonatomic) UIImageView       *uiNoteComplete;
@property (strong, nonatomic) NoteThumbView     *uiNoteThumbView;
@property (strong, nonatomic) UILabel           *uiNoteText;
@property (strong, nonatomic) NotePlaceView     *uiNotePlaceView;
@property (strong, nonatomic) NoteItem          *note;
-(void)start:(NoteItem*)pNote :(id<NoteListViewDelegate,NoteTagViewDelegate,NotePlaceViewDelegate>)pDelegate;
-(void)stop;
@end
