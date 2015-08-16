#import "NoteCell.h"

@implementation NoteCell

@synthesize uiNoteComplete,uiNoteLike,uiNoteThumbView,uiNotePlaceView,uiNoteText,uiZone,uiPhoto,uiNameIntro;
@synthesize note;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        //        [self setBackgroundColor:[UIColor yellowColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        note = nil;
        
        uiPhoto = [[UIButton alloc]init];
        
        uiNameIntro = [[UILabel alloc] init];
        [uiNameIntro setTextColor:UIColorFromRGB(0x6f6f6f, 1.0f)];
        [uiNameIntro setBackgroundColor:[UIColor clearColor]];
        //        [uiNameIntro setBackgroundColor:[UIColor greenColor]];
        [uiNameIntro setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        
        uiZone = [[UILabel alloc] init];
        [uiZone setTextColor:[UIColor orangeColor]];
        [uiZone setBackgroundColor:[UIColor clearColor]];
        //        [uiZone setBackgroundColor:[UIColor blueColor]];
        [uiZone setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        
        uiNoteLike = [[UIImageView alloc] init];
        [uiNoteLike setBackgroundColor:[UIColor clearColor]];
        uiNoteLike.contentMode = UIViewContentModeScaleAspectFill;
        uiNoteLike.clipsToBounds = YES;
        
        uiNoteComplete = [[UIImageView alloc] init];
        [uiNoteComplete setBackgroundColor:[UIColor clearColor]];
        uiNoteComplete.contentMode = UIViewContentModeScaleAspectFill;
        uiNoteComplete.clipsToBounds = YES;
        
        uiNoteThumbView = [[NoteThumbView alloc] init];
        
        uiNoteText = [[UILabel alloc] init];
        [uiNoteText setTextColor:UIColorFromRGB(0xa4866c, 1.0f)];
        [uiNoteText setBackgroundColor:[UIColor clearColor]];
        //        [uiNoteText setBackgroundColor:[UIColor purpleColor]];
        [uiNoteText setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        
        CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
        CGRect placeFrame = CGRectMake(10, 10, mainFrame.size.width-10*2, 50);
        uiNotePlaceView = [[NotePlaceView alloc] initWithFrame:placeFrame];
        
        [self.contentView addSubview:uiPhoto];
        [self.contentView addSubview:uiNameIntro];
        [self.contentView addSubview:uiZone];
        [self.contentView addSubview:uiNoteLike];
        [self.contentView addSubview:uiNoteComplete];
        [self.contentView addSubview:uiNoteThumbView];
        [self.contentView addSubview:uiNoteText];
        [self.contentView addSubview:uiNotePlaceView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)start:(NoteItem*)pNote :(id<NoteListViewDelegate,NoteTagViewDelegate,NotePlaceViewDelegate>)pDelegate
{
    self.note = pNote;
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    uiPhoto.frame = CGRectMake(10, 20, 50, 50);
    uiPhoto.layer.masksToBounds = YES;
    uiPhoto.layer.cornerRadius = uiPhoto.bounds.size.width * 0.5;
    uiPhoto.layer.borderWidth = 2.0;
    uiPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    [uiPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:pNote.brief.thumblink] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"register-done-2-1.png"]];
    
    uiNameIntro.frame = CGRectMake(10+50+5, 20, mainFrame.size.width-130, 25);
    [uiNameIntro setNumberOfLines:1];
    [uiNameIntro setLineBreakMode:NSLineBreakByTruncatingTail];
    uiNameIntro.text = [NSString stringWithFormat:@"%@,%@",pNote.brief.name,pNote.brief.intro];
    
    uiZone.frame = CGRectMake(10+50+5, 20+25, mainFrame.size.width-130, 25);
    [uiZone setNumberOfLines:1];
    [uiZone setLineBreakMode:NSLineBreakByTruncatingTail];
    uiZone.text = pNote.brief.zone;
    
    uiNoteThumbView.frame = CGRectMake(0, uiZone.frame.origin.y+uiZone.frame.size.height+5, mainFrame.size.width, 0);
    [uiNoteThumbView start:pNote :pDelegate];
    
    uiNoteText.frame = CGRectMake(10, uiNoteThumbView.frame.origin.y+uiNoteThumbView.frame.size.height+10, mainFrame.size.width-10*2,24*10);
    [uiNoteText setNumberOfLines:0];
    [uiNoteText setLineBreakMode:NSLineBreakByWordWrapping];
    NSString *text = [NSString stringWithFormat:@"%@",pNote.text];
    uiNoteText.text = text;
    //设置一个行高上限
    CGSize maxSize = CGSizeMake(mainFrame.size.width-10*2,24*10);
    NSDictionary *attribute = @{NSFontAttributeName: uiNoteText.font};
    CGSize labelsize = [uiNoteText.text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    uiNoteText.frame = CGRectMake(10, uiNoteThumbView.frame.origin.y+uiNoteThumbView.frame.size.height+10, labelsize.width, labelsize.height);
    
    [uiNotePlaceView start:pDelegate :[UIColor orangeColor] :pNote.place];
    CGFloat tagWidth = uiNotePlaceView.frame.size.width;
    CGFloat tagHeight = uiNotePlaceView.frame.size.height;
    uiNotePlaceView.frame = CGRectMake(10, uiNoteText.frame.origin.y+uiNoteText.frame.size.height+10, tagWidth, tagHeight);
    
    self.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, uiNotePlaceView.frame.origin.y+uiNotePlaceView.frame.size.height+20);
}

-(void)stop {
    [uiNoteThumbView stop];
}

@end
