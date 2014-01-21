//
//  ViewController.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 12/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"
#import "CreateAccount.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize signUpbgView,signInButton,createAccnt;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"startbg_v.jpg"]];
        
        signUpbgView.frame = CGRectMake(206, 440, 566, 251);
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"startbg.jpg"]];
        
        signUpbgView.frame = CGRectMake(101, 695, 566, 251);
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
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"startbg_v.jpg"]];
        signUpbgView.frame = CGRectMake(206, 440, 566, 251);
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"startbg.jpg"]];
        signUpbgView.frame = CGRectMake(101, 695, 566, 251);
        
    }
    
    
}

- (IBAction)signInButton:(id)sender {
    SignInViewController *signIn = [[SignInViewController alloc]initWithNibName:@"SignInViewController" bundle:Nil];
    [self.navigationController pushViewController:signIn animated:YES];
}

- (IBAction)createAccnt:(id)sender {
    CreateAccount *createAccount = [[CreateAccount alloc]initWithNibName:@"CreateAccount" bundle:Nil];
    [self.navigationController pushViewController:createAccount animated:YES];

}
@end
