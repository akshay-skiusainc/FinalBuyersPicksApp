//
//  CreateAccount.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 03/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "CreateAccount.h"

@interface CreateAccount ()

@end

@implementation CreateAccount
@synthesize firstName,lastName,emailId,sendActivationBtn,password,confirmPassword,signUpbgView;

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
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg_v.jpg"]];
        
        signUpbgView.frame = CGRectMake(258, 375, 483, 318);
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg.jpg"]];
        
       signUpbgView.frame = CGRectMake(143, 529, 483, 318);
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
    
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [emailId resignFirstResponder];
    [password resignFirstResponder];
    [confirmPassword resignFirstResponder];
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg_v.jpg"]];
        signUpbgView.frame = CGRectMake(258, 375, 483, 318);

    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"regi_bg.jpg"]];
        signUpbgView.frame = CGRectMake(143, 529, 483, 318);
        
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
                                     -320,
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
     [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}



- (IBAction)sendActivationBtn:(id)sender {
   // [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:2] animated:YES];
    
    [self validateEmailWithString:emailId.text];
    
    if (stricterFilter ) {
        
        if (password.text.length >0 ) {

        if ([password.text isEqualToString:confirmPassword.text]) {
            
        NSDate   *tempDate = [[NSDate alloc] init];
        
       v_key = [self generateRandomString:10];


        NSString *post = [NSString stringWithFormat:@"email=%@&password=%@&f_name=%@&l_name=%@&active=%@&created_date=%@&verification_key=%@",emailId.text,password.text,firstName.text,lastName.text,@"0",tempDate,v_key];
        
        NSLog(@"post=%@",post);

        [self ValidateLogin:post];
        
//      [self.navigationController popToRootViewControllerAnimated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
            
            
        }

        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password do not match" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];

            
        }
        }
        
        
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password cannot be blank" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
            [alert show];
        }
    }
    
    else if (!stricterFilter) {
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email in XYZ@abc.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
		[alert show];
        
    }
}

-(void)ValidateLogin:(NSString *)post
{
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"null",@"null"];
	
    
	
    //post = [NSString stringWithFormat:@"phone=%@&email=%@",@"1234567890",@"rohan.k@skiusainc.com"];
	NSLog(@"POST=%@",post);
	
    //	dispatch_async(dispatch_get_main_queue()	, ^{
	
    
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://skibuyerspick.appspot.com/saveuser"]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
	[request setHTTPBody:postData];
	
	NSURLResponse *response;
	NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *stringResponse = [[NSString alloc] initWithData:urlData encoding:NSASCIIStringEncoding];
	NSLog(@"response1=%@",stringResponse);
	
	
	NSError* error;
	NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:urlData //1
                                                                 options:kNilOptions
                                                                   error:&error];
    
    NSDate   *tempDate = [[NSDate alloc] init];
    
    
    

    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO ba_tbl_user (id , email , password , f_name,l_name , device , last_login , active , created_date , verification_key , active_date , old_password , last_modified , created_by , subscribtion_type , user_type, security_pin, password_mod) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",@"1", emailId.text, password.text, firstName.text,lastName.text, @"device",@"last_login",@"0",tempDate,@"verification_key",@"active_date", @"old_password", @"last_modified" , @"Self" , @"individual" , @"individual", @"", @"" ];
    
//    NSLog(@"query=%@",insertSQL);
    
//    [self saveData:insertSQL];
    

//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please Check" message:@"Please Check Your Email for Verification" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
//    [alert show];

    GlobalClass *OBJ=[GlobalClass getInstance];
    OBJ.fetchall=@"0";
    
		
//	for (NSDictionary *actoAgent in responseDict){
//		
//		NSString  *response1 =[actoAgent objectForKey:@"response"];
//		
//		responseD = [NSString stringWithFormat:@"%@",response1];
//		
//		NSLog(@"responseD=%@",responseD);
//		
//
//        
//		
//	}
    
    
    //	});
	
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)validateEmailWithString:(NSString*)email
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	if( [emailTest evaluateWithObject:email] == YES){
		stricterFilter = TRUE;
		NSLog(@"Match!");
	} else {
		stricterFilter = FALSE;
		NSLog(@"No match!");
		
	}
}
@end
