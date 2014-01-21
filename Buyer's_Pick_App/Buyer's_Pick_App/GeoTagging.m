//
//  GeoTagging.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 15/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "GeoTagging.h"

@interface GeoTagging ()

@end

@implementation GeoTagging
@synthesize backgroundImage,MainBgView,geoTagSwitch,switchBgImage;

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

    switchBgImage.layer.cornerRadius = 7.0;
    switchBgImage.clipsToBounds = YES;
    
   
 //   [geoTagSwitch setThumbTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"switchbtn.png"]]];

}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction) geoTagSwitchTouched: (UISwitch *) sender
{
    if (geoTagSwitch.on)
    {
        NSLog(@"1");
    }
    else
    {
        NSLog(@"0");
    }
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

@end
