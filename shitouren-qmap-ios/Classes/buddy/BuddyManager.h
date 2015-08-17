//
//  BuddyManager.h
//  qmap
//
//  Created by 石头人6号机 on 15/7/22.
//
//

#import <Foundation/Foundation.h>
#import "BuddyItem.h"



@interface BuddyManager : NSObject{
    NSMutableArray *curList;
    
}

@property (strong, atomic) NSMutableArray *frendList;
@property (strong, atomic) NSMutableArray *fansList;
@property (strong, atomic) NSMutableArray *ortherList;
@property (copy, atomic) BuddyItem *mainUser;

-(void)requestfrendData;
-(void)requestfansData;
-(void)requestortherData;

-(void)requestFollow:(long)userID;
-(void)requestUnFollow:(long)userID;

-(NSMutableArray*) getTableData:(int) index;
-(BuddyItem* ) getBoddyItem:(NSInteger) index;

@end
