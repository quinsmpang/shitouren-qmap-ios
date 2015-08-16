#import "BaseUIViewController.h"
#import "PostThumbCell.h"
#import "PostTagView.h"
#import "TopicItem.h"
#import "UITextView+Placeholder.h"
#import "ASProgressPopUpView.h"

@interface PostViewController : BaseUIViewController <UIActionSheetDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,PostThumbCellDelegate,PostTagViewDelegate>
{
    UIScrollView            *uiContainer;
    UIImageView             *uiPostBg;
    UITextView              *uiPostView;
    UICollectionView        *uiThumbColl;
    ASProgressPopUpView     *uiProgress;
    UILabel                 *uiComplete;
    
    NSMutableArray          *urls;
    NSMutableArray          *thumbs;
    
    PostTagView             *uiTagView;
    PostTagView             *uiPlaceView;
    
    UIButton                *uiPostBtn;
    int                     numInSection;
    int                     postImgLimit;
    int                     postTextLimit;
}
@property (strong, nonatomic) TopicItem     *note;

@end

