//
//  TermsAndConditions.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 10/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "TermsAndConditions.h"
#import "CameraAudioVideoNote.h"
#import "AddNote.h"

@interface TermsAndConditions ()

@end

@implementation TermsAndConditions
@synthesize termsLabel,termsScroller,placeHolderTitle,TAG,activityIndicator,activityIndicatorLand,pView,lView,termsLabelLand,termsScrollerLand,termsTxtView;

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

    
    [self performSelector:@selector(fetchAllData) withObject:nil afterDelay:0.0];

}

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)fetchAllData
{
    [activityIndicator startAnimating];
    [activityIndicatorLand startAnimating];
    
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
      
		NSString* post = [NSString stringWithFormat:@"http://apps.medialabs24x7.com/besharam/fetch_privacy_ios.php?deviceno=123124324"];
		
		
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:post] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
		
		
		
		[request setHTTPMethod:@"GET"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
		NSError *errorReturned = nil;
		NSURLResponse *theResponse =[[NSURLResponse alloc]init];
		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&errorReturned];
		
		
		if (errorReturned) {
			NSLog(@"errorReturned=%@",errorReturned);
			[activityIndicator stopAnimating];
            [activityIndicatorLand stopAnimating];
       			
			
		}
		else
		{
			
			
			
			
			NSError* error;
			NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data //1
                                                                 options:kNilOptions
                                                                   error:&error];
			
				
			
            for (NSDictionary *actoAgent in json)
            {
                description = [actoAgent    objectForKey:@"p_content"];
                
                NSLog(@"description=%@",description);
                
            }
            
                termsLabel.numberOfLines = 0;
                termsLabelLand.numberOfLines = 0;
	            dispatch_async(dispatch_get_main_queue()	, ^{
                CGSize maximumLabelSize = CGSizeMake(694, 9000);
                
                CGSize expectedLabelSize = [description sizeWithFont:termsLabel.font constrainedToSize:maximumLabelSize lineBreakMode:termsLabel.lineBreakMode];
                
                CGRect newFrame = termsLabel.frame;
                newFrame.size.height = expectedLabelSize.height;
                termsLabel.frame = newFrame;
                termsScroller.contentSize=CGSizeMake(728, expectedLabelSize.height+100);
                NSLog(@"height-=%f",expectedLabelSize.height);
                termsScroller.userInteractionEnabled	=YES;
                termsScroller.showsVerticalScrollIndicator = YES;
                termsScroller.scrollEnabled = YES;
                
                termsLabel.text=description;
                
                
                [activityIndicator stopAnimating];
                    
                    
                    CGSize maximumLabelSize1 = CGSizeMake(950, 9000);
                    
                    CGSize expectedLabelSize1 = [description sizeWithFont:termsLabelLand.font constrainedToSize:maximumLabelSize1 lineBreakMode:termsLabelLand.lineBreakMode];
                    
                    CGRect newFrame1 = termsLabelLand.frame;
                    newFrame1.size.height = expectedLabelSize1.height;
                    termsLabelLand.frame = newFrame1;
                    termsScrollerLand.contentSize=CGSizeMake(984, expectedLabelSize1.height+100);
                    NSLog(@"height-=%f",expectedLabelSize1.height);
                    termsScrollerLand.userInteractionEnabled	=YES;
                    termsScrollerLand.showsVerticalScrollIndicator = YES;
                    termsScrollerLand.scrollEnabled = YES;
                    
                    termsLabelLand.text=description;
                    
                    
                    [activityIndicatorLand stopAnimating];
                 
                //[self FetchPrivacy];
            });
		}
	});
    
    activityIndicatorLand.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view = lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@" main-bg-1024-704.jpg"]];
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
       
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
        self.view = lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view = pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
    }
    
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
}
@end
