//
//  SecurePin.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 15/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "SecurePin.h"

@interface SecurePin ()

@end

@implementation SecurePin
@synthesize MainBgView,headerImage,lockImage,closeButton,createSecurePinBtn,createSecurePINView,submitBtnForCreatePin,enterNewPinBgImage_Change,enterNewPinTxtFld_Change,enterOldPinBgImage_Change,enterOldPinTxtFld_Change,enterPinBgImage_Create,enterPinBgImage_Remove,enterPinTxtFld_Create,enterPinTxtFld_Remove,confirmNewPinBgImage_Change,confirmNewPinTxtFld_Change,confirmPinBgImage_Create,confirmPinTxtFld_Create,changePinbgView,changePinBtn,removePinBgView,removePinBtn,submitBtn_Change,submitBtn_Remove,changeAndRemoveBgView,backgroundImage;

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

    MainBgView.layer.cornerRadius = 10.0;
    MainBgView.clipsToBounds = YES;
    
    [enterPinBgImage_Create.layer setBorderColor:[UIColor grayColor].CGColor];
    [enterPinBgImage_Create.layer setBorderWidth:1];
    
    [confirmPinBgImage_Create.layer setBorderColor:[UIColor grayColor].CGColor];
    [confirmPinBgImage_Create.layer setBorderWidth:1];
    
    [enterOldPinBgImage_Change.layer setBorderColor:[UIColor grayColor].CGColor];
    [enterOldPinBgImage_Change.layer setBorderWidth:1];
    
    [confirmNewPinBgImage_Change.layer setBorderColor:[UIColor grayColor].CGColor];
    [confirmNewPinBgImage_Change.layer setBorderWidth:1];
    
    [enterNewPinBgImage_Change.layer setBorderColor:[UIColor grayColor].CGColor];
    [enterNewPinBgImage_Change.layer setBorderWidth:1];
    
    [enterPinBgImage_Remove.layer setBorderColor:[UIColor grayColor].CGColor];
    [enterPinBgImage_Remove.layer setBorderWidth:1];

    createSecurePINView.alpha = 1.0;
    changeAndRemoveBgView.alpha = 0.0;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        
        backgroundImage.frame = CGRectMake(0, 0, 1024, 748);
        MainBgView.frame = CGRectMake(275, 226, 475, 296);
        
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        
        backgroundImage.frame = CGRectMake(0, 0, 768, 1004);
        MainBgView.frame = CGRectMake(132, 354, 475, 296);
    }
    
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
        backgroundImage.frame = CGRectMake(0, 0, 1024, 748);
        MainBgView.frame = CGRectMake(275, 226, 475, 296);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        backgroundImage.frame = CGRectMake(0, 0, 768, 1004);
        MainBgView.frame = CGRectMake(132, 354, 475, 296);
       
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)createSecurePinBtn:(id)sender
{
        createSecurePINView.alpha = 1.0;
        changeAndRemoveBgView.alpha = 0.0;
   
    
}
- (IBAction)submitBtnForCreatePin:(id)sender
{
    createSecurePINView.alpha = 0.0;
    changeAndRemoveBgView.alpha = 1.0;
     changePinbgView.alpha = 1.0;
     removePinBgView.alpha = 0.0;
}
- (IBAction)changePinBtn:(id)sender {
    changePinbgView.alpha = 1.0;
    removePinBgView.alpha = 0.0;
    
}
- (IBAction)removePinBtn:(id)sender {
    changePinbgView.alpha = 0.0;
    removePinBgView.alpha = 1.0;
}
- (IBAction)submitBtn_Remove:(id)sender {
    createSecurePINView.alpha = 1.0;
    changeAndRemoveBgView.alpha = 0.0;
}
- (IBAction)submitBtn_Change:(id)sender {
    createSecurePINView.alpha = 1.0;
    changeAndRemoveBgView.alpha = 0.0;
}
@end
