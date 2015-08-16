#import "NotePlaceCell.h"

@protocol NotePlaceViewDelegate;

@interface NotePlaceView : UIView<NotePlaceCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate> {
    UIImageView             *uiIcon;
    UIImageView             *uiTagBg;
    NSMutableArray          *uiTagLabels;
    UICollectionView        *uiTagColl;
    UIColor                 *uiTagColor;
}
@property (strong, nonatomic) NSMutableArray            *tags;
@property (strong, nonatomic) id<NotePlaceViewDelegate>   delegate;

-(void)start:(id<NotePlaceViewDelegate>)pDelegate :(UIColor*)pColor :(NSMutableArray*)pTags;
@end

@protocol NotePlaceViewDelegate<NSObject>
@optional
- (void)NPVDclick:(NSString*)pTag;
@end
