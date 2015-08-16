#import "TopicItem.h"

@protocol NoteBannerDelegate;

@interface NoteBanner : UIView {
}

@property (strong,nonatomic) UIImageView    *uiBg;
@property (strong,nonatomic) UILabel    *uiChannel;
@property (strong,nonatomic) UILabel    *uiTitle;
@property (strong,nonatomic) UILabel    *uiText;
@property (strong,nonatomic) UILabel    *uiHot;
@property (strong,nonatomic) UIButton   *uiPostBtn;
@property (strong,nonatomic) UIButton   *uiLikeBtn;
@property (strong,nonatomic) TopicItem  *topic;
@property (strong, nonatomic) id<NoteBannerDelegate> delegate;

- (void)start:(TopicItem *)pTopic :(id<NoteBannerDelegate>)pDelegate;

@end

@protocol NoteBannerDelegate<NSObject>
@optional
- (void)NBDpost:(TopicItem*)pNote;
- (void)NBDlike:(TopicItem*)pNote;
@end