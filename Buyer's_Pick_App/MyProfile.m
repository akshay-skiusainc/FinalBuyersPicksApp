//
//  MyProfile.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 09/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "MyProfile.h"
#import "CameraAudioVideoNote.h"
#import "AddNote.h"

@interface MyProfile ()

@end

@implementation MyProfile
@synthesize syncButton,userImage,editProfileButton,editProfileBgView,firstnameBgImage,lastNameBgImage,dobBgImage,mobileNumBgImage,firstNameTxtFld,lastNameTxtFld,dobTxtFld,mobNumTxtFld,updateProfileButton,useNameLabel,emailIdLabel,changePasswordButton,memberAccessButton,displayProfileBgView,placeHolderTitle,cameraTag,popover,TAG,grayLine,clickUserPicButton;

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
    editProfileBgView.alpha = 0.0;
    cameraTag = 0;
    UIImage *cameraImage = [UIImage imageNamed:@"camera_icon.png"];
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(0, 5, cameraImage.size.width, cameraImage.size.height);
    cameraButton.tag = 0;
    [cameraButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemCamera = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    UIImage *audioImage = [UIImage imageNamed:@"recording_icon.png"];
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [audioButton setImage:audioImage forState:UIControlStateNormal];
    audioButton.frame = CGRectMake(0, 5, audioImage.size.width, audioImage.size.height);
    audioButton.tag = 1;
    [audioButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:audioButton];
    
    
    UIImage *noteImage = [UIImage imageNamed:@"note_icon.png"];
    UIButton *noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noteButton setImage:noteImage forState:UIControlStateNormal];
    noteButton.frame = CGRectMake(0, 5, noteImage.size.width, noteImage.size.height);
    noteButton.tag = 2;
    [noteButton addTarget:self action:@selector(cameraClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:noteButton];
    
    
    UIImage *searchBarImage = [UIImage imageNamed:@"searchbox.png"];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 130, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    [textField setBackground:searchBarImage];
    textField.backgroundColor = [UIColor clearColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    
    placeHolderTitle = [[UILabel alloc] initWithFrame:CGRectMake(9.0, 0.0, textField.frame.size.width - 20.0, 34.0)];
    [placeHolderTitle setText:@"SEARCH BY TAG"];
    [placeHolderTitle setBackgroundColor:[UIColor clearColor]];
    [placeHolderTitle setTextColor:[UIColor whiteColor]];
    [placeHolderTitle setFont:[UIFont boldSystemFontOfSize:10.0]];
    [textField addSubview:placeHolderTitle];
    
    UIBarButtonItem *customBarItemSearch = [[UIBarButtonItem alloc] initWithCustomView:textField];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,customBarItemCamera,customBarItemSearch,nil]];
    
    if([TAG isEqualToString:@"fromSplitView"])
    {
        
    }
    else
    {
        
    UIImage *doneImage = [UIImage imageNamed:@"done.png"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, 3, 64, 37);
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemDone = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.leftBarButtonItem = customBarItemDone;

    UIImage *buyersImage = [UIImage imageNamed:@"buyerlogo.png"];
    UIImageView *navBarBuyersImage = [[UIImageView alloc]initWithImage:buyersImage];
    navBarBuyersImage.frame = CGRectMake(0, 2, buyersImage.size.width, buyersImage.size.height);
    UIBarButtonItem *customBarItemBuyersImage= [[UIBarButtonItem alloc] initWithCustomView:navBarBuyersImage];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:customBarItemDone, customBarItemBuyersImage,nil]];
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"MY PROFILE";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    
    userImage.layer.cornerRadius = 140.0;
    userImage.clipsToBounds = YES;
    [userImage.layer setBorderColor:[self colorWithHexString:@"38616d"].CGColor];
    [userImage.layer setBorderWidth:10];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPic"];
    userImage.image = [UIImage imageWithData:imageData];

    firstnameBgImage.layer.cornerRadius = 10.0;
    firstnameBgImage.clipsToBounds = YES;
    lastNameBgImage.layer.cornerRadius = 10.0;
    lastNameBgImage.clipsToBounds = YES;
    dobBgImage.layer.cornerRadius = 10.0;
    dobBgImage.clipsToBounds = YES;
    mobileNumBgImage.layer.cornerRadius = 10.0;
    mobileNumBgImage.clipsToBounds = YES;
   
}

-(void)cameraClicked:(UIButton *)sender
{
    if(sender.tag == 0 || sender.tag == 1)
    {
    CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
    openCamera.navTagFromHome = sender.tag;
    [self.navigationController pushViewController:openCamera animated:YES];
    }
    else
    {
        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        [self.navigationController pushViewController:addNote animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    
   // NSData* imageData1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPic"];
   // userImage.image = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPic"];
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        
        grayLine.frame = CGRectMake(0, 39, 1024, 1);
        editProfileButton.frame = CGRectMake(906, 1, 111, 32);
        userImage.frame = CGRectMake(372, 42, 281, 281);
        clickUserPicButton.frame = CGRectMake(377, 45, 271, 275);
        displayProfileBgView.frame = CGRectMake(163, 329, 694, 363);
        editProfileBgView.frame = CGRectMake(163, 329, 694, 422);
      

    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
        grayLine.frame = CGRectMake(0, 39, 768, 1);
        editProfileButton.frame = CGRectMake(637, 7, 111, 32);
        userImage.frame = CGRectMake(241, 89, 281, 281);
        clickUserPicButton.frame = CGRectMake(246, 92, 271, 275);
        displayProfileBgView.frame = CGRectMake(40, 406, 694, 363);
        editProfileBgView.frame = CGRectMake(40, 406, 694, 422);
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    
    if(ori == UIInterfaceOrientationLandscapeRight |ori == UIInterfaceOrientationLandscapeLeft)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -290,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    else if(ori == UIInterfaceOrientationPortrait |ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -150,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSLog(@"currSysVer = %@",currSysVer);
    
    int currSysVerInInt = [currSysVer intValue];
    NSLog(@"currSysVerInInt = %d",currSysVerInInt);
    
    if(currSysVerInInt >= 7)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     64,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    else if(currSysVerInInt < 7)
    {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     0,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        
    }
    
    
    
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
	return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate  // iOS 6 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6 autorotation fix
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation // iOS 6 autorotation fix
{
    return UIInterfaceOrientationPortrait;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        grayLine.frame = CGRectMake(0, 39, 1024, 1);
         editProfileButton.frame = CGRectMake(906, 1, 111, 32);
        userImage.frame = CGRectMake(372, 42, 281, 281);
        clickUserPicButton.frame = CGRectMake(377, 45, 271, 275);
         displayProfileBgView.frame = CGRectMake(163, 329, 694, 363);
         editProfileBgView.frame = CGRectMake(163, 329, 694, 422);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
        grayLine.frame = CGRectMake(0, 39, 768, 1);
        editProfileButton.frame = CGRectMake(637, 7, 111, 32);
        userImage.frame = CGRectMake(241, 89, 281, 281);
        clickUserPicButton.frame = CGRectMake(246, 92, 271, 275);
        displayProfileBgView.frame = CGRectMake(40, 406, 694, 363);
        editProfileBgView.frame = CGRectMake(40, 406, 694, 422);
        
    }
    
    
}

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickUserPicButton:(id)sender {
    
    UIActionSheet *selectShare = [[UIActionSheet alloc] initWithTitle:@"Select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",nil];
    selectShare.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [selectShare showInView:[UIApplication sharedApplication].keyWindow];

}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        cameraTag=1;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
    
    if (buttonIndex == 1)
    {
        cameraTag=2;
        
        if([popover isPopoverVisible])
        {
            [popover dismissPopoverAnimated:YES];
        }
        
        else {
            
            //            UIImagePickerController *imagePickerView = [[UIImagePickerController alloc] init];
            //            imagePickerView.delegate = self;
            //            imagePickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            imagePickerView.allowsEditing = YES;
            //
            //            popover = [[UIPopoverController alloc]initWithContentViewController:imagePickerView];
            //            popover.delegate = self;
            //            [popover presentPopoverFromRect:socialProfileImage.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing=YES;
            // picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (cameraTag==1)
    {
        [picker dismissModalViewControllerAnimated:YES];
        userImage.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        userImage.image = [self scaleImage:userImage.image toSize:CGSizeMake(281, 281)];
        
    
    }
    
    if (cameraTag==2) {
        
        userImage.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        userImage.image = [self scaleImage:userImage.image toSize:CGSizeMake(281, 281)];
        
     
        
        // Update the server
        
        
        [picker dismissModalViewControllerAnimated:YES];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    userImage.image = image;
  
   // NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
    
   // [setUserDefaults setObject:UIImageJPEGRepresentation(image,1.0) forKey:@"userPic"];
   // NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
   // [setUserDefaults setObject:imageData forKey:@"userPic"];

    [[NSUserDefaults standardUserDefaults] setObject:UIImageJPEGRepresentation(image,1.0) forKey:@"userPic"];
    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}


// Rescaling the image to be shown on profile
- (UIImage *)scaleImage:(UIImage *)sourceImage toSize:(CGSize)targetSize
{
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
    
    NSLog(@"Image width is: %f",width);
    NSLog(@"Image height is: %f",height);
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
    CGFloat scaleFactor2 = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO)
        
        
        //if ((sourceImage.imageOrientation == UIImageOrientationUp) || (sourceImage.imageOrientation == UIImageOrientationDown)
    {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        
        if (widthFactor < heightFactor)
        {
			scaleFactor = heightFactor;
            scaleFactor2 = widthFactor;
            
            scaledWidth  = width * scaleFactor2;
            scaledHeight = height * scaleFactor;
            
        }
        else
        {
			scaleFactor = widthFactor;
            scaleFactor2 = heightFactor;
            
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor2;
            
        }
		
        
        
        NSLog(@"Scaled width is: %f",scaledWidth);
        NSLog(@"Scaled height is: %f",scaledHeight);
		
        // center the image
		
        if (widthFactor < heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
	}
    
    
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	return newImage;
}


- (IBAction)genderButtonMale:(id)sender {
}

- (IBAction)genderButtonFemale:(id)sender {
}

- (IBAction)editProfileButton:(id)sender {
    displayProfileBgView.alpha = 0.0;
    editProfileBgView.alpha = 1.0;
}

- (IBAction)syncButton:(id)sender {
}
- (IBAction)updateProfileButton:(id)sender {
    editProfileBgView.alpha = 0.0;
    displayProfileBgView.alpha = 1.0;
    
}
- (IBAction)changePasswordButton:(id)sender {
}
- (IBAction)memberAccessButton:(id)sender {
}



- (UIColor *) colorWithHexString: (NSString *) hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
	
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
    if ([cString length] != 6) return  [UIColor grayColor];
	
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
	
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
	
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
