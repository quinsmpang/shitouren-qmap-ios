//
//  CollectItem.h
//  qmap
//
//  Created by 石头人6号机 on 15/8/7.
//
//

#import <Foundation/Foundation.h>

@interface CollectItem : NSObject
{
    
}

@property(assign, atomic)long collectID;
@property(assign, atomic)long collectType;
@property(copy, atomic)NSString *name;
@property(copy, atomic)NSString *zone;
@property(copy, atomic)NSString *intro;

@end
