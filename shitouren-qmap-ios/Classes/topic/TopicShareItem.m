#import "TopicShareItem.h"

@implementation TopicShareItem

@synthesize title;
@synthesize text;
@synthesize url;
@synthesize image;

- (id)init{
    self = [super init];
    if (self) {
        image = nil;
    }
    return self;
}

@end
