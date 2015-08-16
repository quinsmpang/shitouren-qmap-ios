#import "NoteTagCell.h"

@protocol NoteTagViewDelegate;

@interface NoteTagView : UIView<NoteTagCellDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate> {
    UIImageView             *uiTagBg;
    NSMutableArray          *uiTagLabels;
    UICollectionView        *uiTagColl;
    UIColor                 *uiTagColor;
}
@property (strong, nonatomic) NSMutableArray            *tags;
@property (strong, nonatomic) id<NoteTagViewDelegate>   delegate;

-(void)start:(id<NoteTagViewDelegate>)pDelegate :(UIColor*)pColor :(NSMutableArray*)pTags;
@end

@protocol NoteTagViewDelegate<NSObject>
@optional
- (void)NTVDclick:(NSString*)pTag;
@end