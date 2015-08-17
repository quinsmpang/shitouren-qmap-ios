//
//  BoddyItem.m
//  qmap
//
//  Created by 石头人6号机 on 15/7/27.
//
//

#import "BuddyItem.h"

@implementation BuddyItem
@synthesize userid, name, zone, intro, imglink, thumblink, thumbdata ;

- (id)init {
    self = [super init];
    if (self) {
        userid = 0;
        name = @"";
        zone = @"";
        intro = @"";
        imglink = @"";
        thumblink = @"";
        thumbdata = nil;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)z {
    BuddyItem *copy = [[[self class] allocWithZone: z] init];
    copy.userid = self.userid;
    copy.name = self.name;
    copy.zone = self.zone;
    copy.intro = self.intro;
    copy.imglink = self.imglink;
    copy.thumblink = self.thumblink;
    copy.thumbdata = self.thumbdata;
    return copy;
}
@end
