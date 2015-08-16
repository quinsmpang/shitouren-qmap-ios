
@protocol NotePlaceCellDelegate;

@interface NotePlaceCell : UICollectionViewCell {
}

@property (strong, nonatomic) UILabel       *uiTagLabel;
@property (strong, nonatomic) UIImageView   *uiIcon;
@property (copy, nonatomic) NSIndexPath     *indexPath;
@property (strong, nonatomic) id<NotePlaceCellDelegate> delegate;

-(void)startLabel:(id<NotePlaceCellDelegate>)pDelegate :(NSIndexPath*)pIndexPath :(NSString*)pTag :(UIColor*)pColor;
-(void)startIcon:(UIImageView*)pIcon;

@end

@protocol NotePlaceCellDelegate<NSObject>
@optional
- (void)NPCDclick:(NSIndexPath*)indexPath;
@end