#import "TopicItem.h"

@interface TopicCell : UITableViewCell {
}
@property (strong, nonatomic) UILabel        *uiTopichot;
@property (strong, nonatomic) UILabel        *uiTopictitle;
@property (strong, nonatomic) UILabel        *uiTopicchannel;
-(void)start:(TopicItem*)pTopic;
@end
