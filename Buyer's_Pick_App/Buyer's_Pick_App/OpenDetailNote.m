//
//  OpenDetailNote.m
//  Buyer's_Pick_App
//
//  Created by Akshay Jain on 12/23/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "OpenDetailNote.h"
#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

@interface OpenDetailNote ()

@end

@implementation OpenDetailNote
@synthesize DATAPATH,DATATYPE,videoPlayerView;

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
    NSLog(@"DATATYPE1=%@",DATAPATH);
    
//    if ([DATATYPE isEqualToString:@"image"]) {
//        
//        
//        _image.image = [UIImage imageWithContentsOfFile:DATAPATH];
//
//        
//    }
    
    
    
    if ([DATATYPE isEqualToString:@"video"] || [DATATYPE isEqualToString:@"audio"]) {
 
//    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
//    [self.view addSubview:view1];
//    check=1;

    //    urlStr					= [[NSBundle mainBundle] pathForResource:@"Video.m4v" ofType:nil];
        CGAffineTransform rotate =CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
       // [videoPlayerView setTransform:rotate];

	url	= [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",DATAPATH]];
	videoPlayer				= [[MPMoviePlayerController alloc] initWithContentURL:url];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:)name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayer];
	videoPlayer.view.frame	= CGRectMake(0,0,768,960);
    videoPlayer.fullscreen = YES;
    [videoPlayer.view setTransform:rotate];
	[self.view addSubview:videoPlayer.view];
	[videoPlayer play];
        
    }

    // Do any additional setup after loading the view from its nib.
}


- (void)movieFinishedCallback:(NSNotification*) aNotification
{
    videoPlayer = [aNotification object];
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:videoPlayer];
    [videoPlayer stop];
	[videoPlayer prepareToPlay];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [videoPlayer stop];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
