
@protocol NoteTagCellDelegate;

@interface NoteTagCell : UICollectionViewCell {
}

@property (strong, nonatomic) UILabel       *uiTagLabel;
@property (copy, nonatomic) NSIndexPath     *indexPath;
@property (strong, nonatomic) id<NoteTagCellDelegate> delegate;

-(void)startLabel:(id<NoteTagCellDelegate>)pDelegate :(NSIndexPath*)pIndexPath :(NSString*)pTag :(UIColor*)pColor;

@end

@protocol NoteTagCellDelegate<NSObject>
@optional
- (void)NTCDclick:(NSIndexPath*)indexPath;
@end
