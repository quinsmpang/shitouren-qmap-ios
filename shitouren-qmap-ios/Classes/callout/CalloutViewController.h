//
//  CalloutViewController.h
//  qmap
//
//  Created by 石头人6号机 on 15/8/5.
//
//

#import "BaseUIViewController.h"
#import "UITextView+PlaceHolder.h"

@interface CalloutViewController : BaseUIViewController<UITextViewDelegate>
{
    UITextView *uiContent1;
    UITextView *uiContent2;
    UITextView *uiContent3;
    
    UIButton *uiBtnOK;

}

@end
