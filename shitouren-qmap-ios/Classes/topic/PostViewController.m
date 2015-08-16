#import "PostViewController.h"
#import "UserManager.h"
#import "LoggerClient.h"
#import "NetWorkManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation PostViewController

@synthesize note;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    baseTitle.text = @"发表";
    [self.view setBackgroundColor:UIColorFromRGB(0xf1f1f1, 1.0f)];
    
    urls = [[NSMutableArray alloc] init];
    thumbs = [[NSMutableArray alloc] init];
    numInSection = 4;
    postImgLimit = 9;
    postTextLimit = 200;
    
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    mainFrame.origin = CGPointMake(0, 0);
    mainFrame.size = CGSizeMake(mainFrame.size.width,mainFrame.size.height);
    
    uiContainer = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    uiPostBg = [[UIImageView alloc] init];
    uiPostBg.backgroundColor = [UIColor whiteColor];
    uiPostBg.layer.cornerRadius = 10;
    uiPostBg.layer.masksToBounds = YES;
    
    uiPostView = [[UITextView alloc] init];
    uiPostView.backgroundColor = [UIColor redColor];
    uiPostView.backgroundColor = [UIColor clearColor];
    uiPostView.returnKeyType = UIReturnKeyDone;
    [uiPostView setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    uiPostView.delegate = self;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    uiThumbColl = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, mainFrame.size.width-20, 100) collectionViewLayout:flowLayout];
    [uiThumbColl setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [uiThumbColl setBackgroundColor:[UIColor blueColor]];
    [uiThumbColl setBackgroundColor:[UIColor clearColor]];
    uiThumbColl.dataSource = self;
    uiThumbColl.delegate = self;
    [uiThumbColl registerClass:[PostThumbCell class] forCellWithReuseIdentifier:@"PostThumbCell"];
    
    uiTagView = [[PostTagView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.width/4)];
    [uiTagView start:self :@"标签" :[UIColor greenColor]];
    
    uiPlaceView = [[PostTagView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.width/4)];
    [uiPlaceView start:self :@"位置标签" :[UIColor orangeColor]];
    
    uiProgress = [[ASProgressPopUpView alloc] init];
    uiProgress.font = [UIFont fontWithName:@"Helvetica" size:14];
    uiProgress.popUpViewAnimatedColors = @[[UIColor orangeColor], [UIColor greenColor]];
    uiProgress.popUpViewCornerRadius = 5.0;
    
    uiComplete  = [[UILabel alloc] init];
    [uiComplete setTextColor:[UIColor orangeColor]];
    [uiComplete setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [uiComplete setBackgroundColor:[UIColor clearColor]];
    [uiComplete setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [uiComplete setNumberOfLines:1];
    [uiComplete setTextAlignment:NSTextAlignmentLeft];
    uiComplete.text = @"完成度";
    
    uiPostBtn = [[UIButton alloc] init];
    [uiPostBtn setBackgroundColor:[UIColor greenColor]];
    [uiPostBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [uiPostBtn setTitle:@"发表" forState:UIControlStateNormal];
    uiPostBtn.contentMode = UIViewContentModeScaleAspectFill;
    uiPostBtn.clipsToBounds = YES;
    uiPostBtn.layer.cornerRadius = 5;
    uiPostBtn.layer.masksToBounds = YES;
    [uiPostBtn addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    
    [uiContainer addSubview:uiPostBg];
    [uiContainer addSubview:uiPostView];
    [uiContainer addSubview:uiThumbColl];
    [uiContainer addSubview:uiTagView];
    [uiContainer addSubview:uiPlaceView];
    [uiContainer addSubview:uiProgress];
    [uiContainer addSubview:uiComplete];
    [uiContainer addSubview:uiPostBtn];
    [self.view addSubview:uiContainer];
    
    [self registerForKeyboardNotifications];
}

- (void)refresh
{
    CGRect mainFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGRect postBgFrame = CGRectMake(10, 10, mainFrame.size.width-20, mainFrame.size.width/3);
    uiPostBg.frame = postBgFrame;
    
    CGRect postViewFrame = CGRectMake(postBgFrame.origin.x+5, postBgFrame.origin.y+5, postBgFrame.size.width-10, postBgFrame.size.height-10);
    uiPostView.frame = postViewFrame;
    uiPostView.placeholder = [NSString stringWithFormat:@"#%@#",note.title];
    
    int cellWidth = ([[UIScreen mainScreen] applicationFrame].size.width-10*2-numInSection*10)/numInSection;
    CGRect thumbCollFrame = CGRectMake(10, postBgFrame.origin.y+postBgFrame.size.height+10, mainFrame.size.width-20, (thumbs.count/numInSection+1)*(cellWidth+10));
    
    uiThumbColl.frame = thumbCollFrame;
    
    CGRect tagViewFrame = CGRectMake(0, thumbCollFrame.origin.y+thumbCollFrame.size.height, uiTagView.frame.size.width, uiTagView.frame.size.height);
    uiTagView.frame = tagViewFrame;
    
    CGRect placeViewFrame = CGRectMake(0, tagViewFrame.origin.y+tagViewFrame.size.height, uiPlaceView.frame.size.width, uiPlaceView.frame.size.height);
    uiPlaceView.frame = placeViewFrame;
    
    float complete = 0;
    if(thumbs.count>0){
        complete+=0.5;
    }
    if(thumbs.count>1){
        complete+=0.2;
    }
    if(uiPostView.text.length>0){
        complete+=0.1;
    }
    if(uiTagView.tags.count>0){
        complete+=0.1;
    }
    if(uiPlaceView.tags.count>0){
        complete+=0.1;
    }
    
    CGRect completeFrame = CGRectMake(15, placeViewFrame.origin.y+placeViewFrame.size.height+20, 50, 30);
    uiComplete.frame = completeFrame;
    //    uiComplete.text = [NSString stringWithFormat:@"完整度:%d%%",(int)(complete*100)];
    
    CGRect progressFrame = CGRectMake(15+50, placeViewFrame.origin.y+placeViewFrame.size.height+40, mainFrame.size.width-80, 30);
    uiProgress.frame = progressFrame;
    uiProgress.progress = complete;
    [uiProgress showPopUpViewAnimated:YES];
    
    CGRect postBtnFrame = CGRectMake(30, progressFrame.origin.y+progressFrame.size.height+40, mainFrame.size.width-60, 30);
    uiPostBtn.frame = postBtnFrame;
    
    CGSize uiContainerSize = uiContainer.contentSize;
    CGFloat selfHeight = postBtnFrame.origin.y + postBtnFrame.size.height + 100;
    uiContainerSize.height = selfHeight>mainFrame.size.height?selfHeight:uiContainerSize.height;
    uiContainer.contentSize = uiContainerSize;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [uiThumbColl reloadData];
    [self refresh];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark ---UICollectionViewDataSource delegate---

//定义展示的Section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    long left = thumbs.count-section*numInSection+1;
    return left>numInSection?numInSection:left;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return thumbs.count/numInSection+1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PostThumbCell";
    PostThumbCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if( indexPath.section*numInSection+indexPath.row == thumbs.count ){
        [cell startBtn:self :indexPath];
    }else{
        [cell startImg:[thumbs objectAtIndex:(indexPath.section*numInSection+indexPath.row)] :indexPath];
    }
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int maxWidth = [[UIScreen mainScreen] applicationFrame].size.width;
    int cellWidth = (maxWidth-10*2-numInSection*10)/numInSection;
    return CGSizeMake(cellWidth, cellWidth);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 10, 10);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//定义每个UICollectionView 横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark -
#pragma mark ---UICollectionViewDelegate delegate---

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark -
#pragma mark ---PostThumbCellDelegate delegate---

- (void)PTHCDadd {
    if( thumbs.count>=postImgLimit ){
        return;
    }
    BOOL cameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL photoAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if( cameraAvailable && photoAvailable ) {
        Log(@"支持拍照和相片库");
        [self showLoginSheet];
    } else if( cameraAvailable ) {
        Log(@"仅支持拍照");
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.view.backgroundColor = [UIColor clearColor];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
        picker.sourceType = sourcheType;
        picker.delegate = self;
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
    } else if( photoAvailable ) {
        Log(@"仅支持相片库");
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.view.backgroundColor = [UIColor clearColor];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.sourceType = sourcheType;
        picker.delegate = self;
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        Log(@"都不支持");
    }
}

- (void)showLoginSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从相册选取",@"拍照",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)PTHCDdelete:(NSIndexPath*)indexPath {
    [thumbs removeObjectAtIndex:(indexPath.section*numInSection+indexPath.row)];
    [uiThumbColl reloadData];
    [self refresh];
}

#pragma mark -
#pragma mark ---PostTagViewDelegate delegate---

- (void)PTVDreload {
    [self refresh];
}


#pragma mark -
#pragma mark ---UIActionSheetDelegate delegate---

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0: {
            Log(@"从相册选取");
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.view.backgroundColor = [UIColor clearColor];
            UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.sourceType = sourcheType;
            picker.delegate = self;
            picker.allowsEditing = NO;
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
        case 1: {
            Log(@"拍照");
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.view.backgroundColor = [UIColor clearColor];
            UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
            picker.sourceType = sourcheType;
            picker.delegate = self;
            picker.allowsEditing = NO;
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
    }
}

#pragma mark -
#pragma mark ---UIImagePickerController delegate---

//成功获得相片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //通过UIImagePickerControllerMediaType判断返回的是照片还是视频
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
    if ([type isEqualToString:(NSString*)kUTTypeImage] ) {
        if( picker.sourceType == UIImagePickerControllerSourceTypeCamera ) {
            //获取照片的原图
            UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
            //获取图片的metadata数据信息
            //NSDictionary* metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
            //如果是拍照的照片，则需要手动保存到本地，系统不会自动保存拍照成功后的照片
            UIImageWriteToSavedPhotosAlbum(original, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            //获取图片裁剪的图
//            UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
            //获取图片裁剪后，剩下的图
            //UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
            
            int maxWidth = [[UIScreen mainScreen] applicationFrame].size.width;
            int cellWidth = (maxWidth-10*2-numInSection*10)/numInSection;
            UIImage *thumb = [self scaleAndRotateImage:original andMinImageWidth:cellWidth];
            [thumbs addObject:thumb];
            //获取图片的url
            //            NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
            //            [urls addObject:url];
            [uiThumbColl reloadData];
            [self refresh];
        } else if( picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary ) {
            //获取照片的原图
            UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
            //获取图片裁剪的图
//            UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
            
            int maxWidth = [[UIScreen mainScreen] applicationFrame].size.width;
            int cellWidth = (maxWidth-10*2-numInSection*10)/numInSection;
            UIImage *thumb = [self scaleAndRotateImage:original andMinImageWidth:cellWidth];
            [thumbs addObject:thumb];
            NSURL* url = [info objectForKey:UIImagePickerControllerReferenceURL];
            [urls addObject:url];
            [uiThumbColl reloadData];
            [self refresh];
        }
    }else{
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//取消照相机的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//保存照片成功后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    Log(@"new photo saved ...");
}

#pragma mark -
#pragma mark ---UITextFieldDelegate delegate---

//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView {
    return;
}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self refresh];
    return;
}

//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //    Log(@"test --------- %lu , %lu , %@, %lu",(unsigned long)range.length,(unsigned long)range.location,string,string.length);
    if( text.length < 1 ){//删除
        return YES;
    }
    if( text.length > 1 ){//粘贴多字
        if( textView.text.length>postTextLimit ){//之前已有文字
            return NO;
        }else{//之前没有文字
            return YES;
        }
    }
    //string.length == 1
    if( textView.text.length>postTextLimit ){//超限
        return NO;
    }else{//之前没有文字
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
        return YES;
    }
}

//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView {
    
}

//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView {
    
}

- (void) registerForKeyboardNotifications{
    AddObserver(keyboardWillShow:, UIKeyboardDidShowNotification);
    AddObserver(keyboardWillHide:, UIKeyboardDidHideNotification);
}

- (void)keyboardWillShow:(NSNotification *)notification {
    return;
}

- (void) keyboardWillHide:(NSNotification *)notification {
    return;
}

-(void)post:(id)sender {
//    NSString *imgFilePath = [IMAGE_FILE_PATH stringByAppendingPathComponent:@"photo.jpg"];
//    NSData *imgData = UIImageJPEGRepresentation(uploadImage, 0.5);
//    Log(@"%@",imgFilePath);
//    if ( [imgData writeToFile:imgFilePath atomically:YES]) {
//        Log(@"write success");
//        hasPhoto = YES;
//    }else{
//        Log(@"write failed");
//    }
//    savePhotosAlbum = NO;
//    if( postView.text.length == 0 ){
//        [self baseShowInfoHud:@"一点都不好笑，来点内容嘛！" andIsTop:YES];
//        return;
//    }
//    if( postView.text.length < 10 ){
//        [self baseShowInfoHud:@"内容太少了，冷不起来嘛！" andIsTop:YES];
//        return;
//    }
//    if( postView.text.length > 2000 ){
//        [self baseShowInfoHud:@"内容太长了，看完就真的冷冻了！" andIsTop:YES];
//        return;
//    }
//    
//    HAS_NO_NETWORK(self);
//    [postView resignFirstResponder];
//    
//    hudLoading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hudLoading.labelText = @"正在发表...";
//    hudLoading.opacity = PP_mbprogressHudOpacity;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *url = nil;
//        if (!hasPhoto) {
//            url = POST_NO_IMAGE;
//        }else{
//            url = POST_WITH_IMAGE;
//        }
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//        request.userAgentString = @"lxh_app2_100";
//        [request setAllowCompressedResponse:YES];
//        [request addRequestHeader:@"Cookie" value:[NSString stringWithFormat:@"webpy_session_id=%@",[UserManager sharedInstance].sessionId] ];
//        [request setPostFormat:ASIMultipartFormDataPostFormat];
//        [request setDelegate:self];
//        
//        if (!hasPhoto) {
//            [request setPostValue:@"image" forKey:@"type"];
//            [request setPostValue:@"post_joke" forKey:@"action"];
//            [request setPostValue:postView.text forKey:@"content"];
//        }else{
//            [request setPostValue:postView.text forKey:@"content"];
//            [request setPostValue:@"image" forKey:@"type"];
//            [request setPostValue:@"Joke" forKey:@"model_name"];
//            [request setPostValue:nil forKey:@"title"];
//            NSString *path = [IMAGE_FILE_PATH stringByAppendingPathComponent:@"photo.jpg"];
//            Log(@"dispath path is:%@",path);
//            [request setFile:path forKey:@"imagefile"];
//        }
//        
//        [request setTimeOutSeconds:120];
//        [request startSynchronous];
//        NSError *error = [request error];
//        NSString *res = @"";
//        if(!error){
//            NSString *tResponseStr = [request responseString];
//            Log(@"res: %@",tResponseStr);
//            SBJsonParser *tJsonParser = [[SBJsonParser alloc] init];
//            id tJsonObjects = [tJsonParser objectWithString:tResponseStr];
//            [tJsonParser release], tJsonParser = nil;
//            if ([tJsonObjects isKindOfClass:[NSDictionary class]]){
//                BOOL isSuccess = [[(NSDictionary *)tJsonObjects objectForKey:@"success"] boolValue];
//                if (isSuccess) {
//                    res = @"发布成功";
//                    Log(@"success");
//                    sleep(1);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        hudLoading.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
//                        hudLoading.labelText = res;
//                        hudLoading.mode = MBProgressHUDModeCustomView;
//                        hudLoading.delegate = self;
//                        [hudLoading hide:YES afterDelay:0.5];
//                        
//                        postView.text = @"";
//                        postView.placeholder = NSLocalizedString(@"输入你要发布的内容...",);
//                        [showCameraAndPohto setImage:nil forState:UIControlStateNormal];
//                        [self deleteFile];
//                        [self clearPreviewImage];
//                    });
//                    return;
//                }else {
//                    NSString *msg = [(NSDictionary *)tJsonObjects objectForKey:@"msg"];
//                    NSString *error_info = [(NSDictionary *)tJsonObjects objectForKey:@"error_info"];
//                    if([msg isEqualToString:@"exists"]){
//                        res = error_info;
//                    }else{
//                        res = @"服务器错误，请稍后再试";
//                        res = error_info;
//                    }
//                }
//            }else{
//                res = @"服务器错误，请稍后再试";
//            }
//        }else{
//            Log ( @"%@",[error description]);
//            res = @"网络异常,请稍后再试";
//        }
//        Log ( @"PostViewController <post> failed: %@",res);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            hudLoading.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Wrong.png"]] autorelease];
//            hudLoading.labelText = res;
//            hudLoading.mode = MBProgressHUDModeCustomView;
//            [hudLoading hide:YES afterDelay:0.5];
//        });
//    });
}

#pragma mark -
#pragma mark ---一些图形处理函数---

- (UIImage *)scaleAndRotateImage:(UIImage *)image andMinImageWidth:(int)scaleWidth{
    int kMaxResolution = scaleWidth; // 自定义宽度，根据比例裁剪图片
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    if( width<height ){
        bounds.size.width = kMaxResolution;
        bounds.size.height = kMaxResolution*height/width;
    }else{
        bounds.size.width = kMaxResolution*width/height;
        bounds.size.height = kMaxResolution;
    }
    return [self scaleToBounds:image :bounds];
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image andMaxImageHeight:(int)scaleHeight{
    int kMaxResolution = scaleHeight; // 自定义高度，根据比例裁剪图片
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    return [self scaleToBounds:image :bounds];
}

- (UIImage *)scaleToBounds:(UIImage *)image :(CGRect)bounds {
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

@end
