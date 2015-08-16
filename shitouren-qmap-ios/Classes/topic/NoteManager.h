
@interface NoteManager : NSObject
{
    NSMutableArray              *listNext;
    NSMutableSet                *setShow;
    int                         backIndex;
}
@property (assign, atomic)    int index;
@property (assign, atomic)    long topicid;
@property (strong, atomic)    NSMutableArray  *listShow;
@property (assign, atomic)    BOOL            started;
@property (assign, atomic)    BOOL            gettingNext;
@property (assign, atomic)    BOOL            responsing;
-(id)init:(long)topicid;
-(void)getStart:(int)limit;
-(void)getNext:(int)limit;
-(BOOL)likePost:(long)noteid;
-(BOOL)likeDel:(long)noteid;
@end
