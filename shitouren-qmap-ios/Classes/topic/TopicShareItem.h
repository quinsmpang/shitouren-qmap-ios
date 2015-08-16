
@interface TopicShareItem : NSObject
{
}
@property(copy, atomic)NSString *title;
@property(copy, atomic)NSString *text;
@property(copy, atomic)NSString *url;
@property(strong, atomic)UIImage *image;

@end

