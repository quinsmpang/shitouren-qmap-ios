#import "NoteThumbCell.h"

@implementation NoteThumbCell

@synthesize uiImgView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.uiImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        self.uiImgView.backgroundColor = [UIColor clearColor];
        [self.uiImgView setContentMode:UIViewContentModeScaleAspectFill];
        self.uiImgView.layer.cornerRadius = 4;
        self.uiImgView.layer.masksToBounds = YES;
        self.uiImgView.layer.borderWidth = 2.0;
        self.uiImgView.layer.borderColor = [UIColor clearColor].CGColor;
        
        [self addSubview:self.uiImgView];
    }
    return self;
}

-(void)start
{
    self.uiImgView.layer.borderColor = [UIColor greenColor].CGColor;
}

-(void)stop
{
    self.uiImgView.layer.borderColor = [UIColor clearColor].CGColor;
}

@end
