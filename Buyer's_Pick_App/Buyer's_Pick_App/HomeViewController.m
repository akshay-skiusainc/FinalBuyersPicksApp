//
//  HomeViewController.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 12/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "HomeViewController.h"
#import "CameraAudioVideoNote.h"
#import "AddNote.h"
#import "ListViewCell.h"
#import "GlobalClass.h"
#import "ViewController.h"
#import "OpenVendor.h"

@interface HomeViewController ()
@end
@implementation HomeViewController
@synthesize navBarButtonsIndex,lView,pView,listView,gridView,sortByDate,shareButton,syncButton,allVendorsButton,vendorScroller,totalVendors,placeHolderTitle,tableViewBgImage,sortingTable,sortedArray,INDEX,deleteVendorButton,shareVendorButton,listViewTable,dateForListTableViewHeader,createNEwVendorButton,createNewVendorLabel,createVendorBgView,listAndGridIndex,deleteItems;

@synthesize listViewLand,gridViewLand,sortByDateLand,shareButtonLand,allVendorsButtonLand,syncButtonLand,vendorScrollerLand,tableViewBgImageLand,sortingTableLand,deleteVendorButtonLand,shareVendorButtonLand,createNEwVendorButtonLand,createNewVendorLabelLand,createVendorBgViewLand,offEditModeBtn,offEditModeBtnLand;

@synthesize masterPopoverController = _masterPopoverController;
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
    deleteItems = [[NSMutableArray alloc]init];
    

    
    NSString *insertSQL11 = [NSString stringWithFormat:@"select active from ba_tbl_user where id = 1 "];
    
    [self displayAll:insertSQL11];
    
    
    if ([MobileNo isEqualToString:@"1"])
    {
        
        
        
    }
    else
    {
        
        
        ViewController *loginViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];

    totalVendors=TotalData;

    listAndGridIndex = 2;
    
    dateForListTableViewHeader = [[NSMutableArray alloc]initWithObjects:@"25th Dec 2013",@"31Dec 2013",@"1st Jan 2014", nil];
    
    sortedArray = [[NSArray alloc]initWithObjects:@"Default View",@"Vendor Created",@"Vendor Modified",@"A to Z",@"Z to A", nil];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    INDEX=0;
    NSLog(@"INDEX 1 = %d",INDEX);

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
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"ALL VENDORS";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    tableViewBgImageLand.layer.cornerRadius = 10.0;
    tableViewBgImageLand.clipsToBounds = YES;
    tableViewBgImage.layer.cornerRadius = 10.0;
    tableViewBgImage.clipsToBounds = YES;
    
    [tableViewBgImage.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImage.layer setBorderWidth:0.5];

   }

-(void)openLeftView:(UIButton *)sender
{
  
}



-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];

    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;
    [self DisplayVendors];
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori==UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
  
    }
    dispatch_async(dispatch_get_main_queue()	, ^{
        [self DisplayVendors];
    });
    
    
    [self tablereloaddata];
    
    
}

-(void)tablereloaddata
{
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    [sortingTable reloadData];
    [sortingTableLand reloadData];
}

-(void)DisplayVendors
{
    NSLog(@"listAndGridIndex = %d",listAndGridIndex);
    
    [[vendorScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[vendorScrollerLand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, vendor_title, created_date from ba_tbl_vendor"];
    [self displayAllVendorsInDB:fetchdata];
    
    int m = 0;
    int nXX = 0;
    int nYY = 0;
    if (listAndGridIndex==1)
    {
        int mX = 7;
        int mY = 0;
        
        int nX = 7;
        int nY = 0;
        
        NSLog(@"totalvendore = %d",totalVendors);
        for (int i =0; i<totalVendors; i++)
        {
            mX=248*(i%3);
            mY=237 * (i/3);
            
            nX=248*(i%4);
            nY=237 * (i/4);
            
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(mX+7, mY, 238, 227);
            vendorImage[i].userInteractionEnabled = YES;
            [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [vendorScroller addSubview:vendorImage[i]];
            
            imageOnVendorGrid[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 238, 217)];
            imageOnVendorGrid[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImage[i] addSubview:imageOnVendorGrid[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            tickmarkButtonGrid[i] = [[UIButton alloc]initWithFrame:CGRectMake(0,0,238,227)];
            tickmarkButtonGrid[i].userInteractionEnabled = NO;
            tickmarkButtonGrid[i].alpha = 0.0;
            tickmarkButtonGrid[i].tag = i;
            [tickmarkButtonGrid[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [vendorImage[i] addSubview:tickmarkButtonGrid[i]];
            
            
            mX=mX+248;
            mY=mY+237;
            
            
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(nX+7, nY, 238, 227);
            vendorImageLand[i].userInteractionEnabled = YES;
            [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [vendorScrollerLand addSubview:vendorImageLand[i]];
            
            imageOnVendorGrid[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 238, 217)];
            imageOnVendorGrid[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImageLand[i] addSubview:imageOnVendorGrid[i]];
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            tickmarkButtonGridLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 238, 227)];
            tickmarkButtonGridLand[i].userInteractionEnabled = NO;
            tickmarkButtonGridLand[i].alpha = 0.0;
            tickmarkButtonGridLand[i].tag = i;
            [tickmarkButtonGridLand[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [vendorImageLand[i] addSubview:tickmarkButtonGridLand[i]];
            
            
            nX=nX+248;
            nY=nY+237;
            
            
            
        }
        if(totalVendors%3==0)
        {
            
            vendorScroller.contentSize = CGSizeMake(748,237*(totalVendors/3)+237);
        }
        else
        {
            vendorScroller.contentSize = CGSizeMake(748,237*(totalVendors/3)+237);
            
        }
        
        if(totalVendors%4==0)
        {
            
            vendorScrollerLand.contentSize = CGSizeMake(1006,237*totalVendors/4+237);
        }
        else
        {
            vendorScrollerLand.contentSize = CGSizeMake(1006,(237*totalVendors/4)+237);
            
        }
        
    }
    if (listAndGridIndex==2)
    {
        for (int i =0; i<totalVendors; i++)
        {
            viewForList[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 748, 115)];
            viewForList[i].backgroundColor = [UIColor clearColor];
            [vendorScroller addSubview:viewForList[i]];
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImage[i].userInteractionEnabled = YES;
            [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [viewForList[i] addSubview:vendorImage[i]];
            
            imageOnVendorList[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 90)];
            imageOnVendorList[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImage[i] addSubview:imageOnVendorList[i]];
            
            vendorTitle[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
            vendorTitle[i].backgroundColor = [UIColor clearColor];
            vendorTitle[i].text = datatitle[i];
            vendorTitle[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorTitle[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorTitle[i].textColor = [UIColor darkGrayColor];
            [viewForList[i] addSubview:vendorTitle[i]];
            
            vendorName[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 35, 200, 20)];
            vendorName[i].backgroundColor = [UIColor clearColor];
            vendorName[i].text = datapath[i];
            vendorName[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorName[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorName[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorName[i]];
            
            vendorDate[i] = [[UILabel alloc]initWithFrame:CGRectMake(530, 35, 200, 20)];
            vendorDate[i].backgroundColor = [UIColor clearColor];
            vendorDate[i].text = datadate[i];
            vendorDate[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDate[i].font = [UIFont boldSystemFontOfSize:13.0];
            vendorDate[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorDate[i]];
            
            
            vendorDetails[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
            vendorDetails[i].backgroundColor = [UIColor clearColor];
            vendorDetails[i].text =datatype[i];
            vendorDetails[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetails[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetails[i].textColor = [UIColor grayColor];
            [viewForList[i] addSubview:vendorDetails[i]];
            
            
            
            lineImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, 748, 1)];
            lineImage[i].backgroundColor = [UIColor grayColor];
            [viewForList[i] addSubview:lineImage[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            tickmarkButtonlist[i] = [[UIButton alloc]initWithFrame:CGRectMake(0,0,100,100)];
            tickmarkButtonlist[i].userInteractionEnabled = NO;
            tickmarkButtonlist[i].alpha = 0.0;
            tickmarkButtonlist[i].tag = i;
            [tickmarkButtonlist[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [viewForList[i] addSubview:tickmarkButtonlist[i]];
            
            m=m+115;
            
            nXX=503*(i%2);
            nYY=115 * (i/2);
            
            
            viewForListLand[i] = [[UIView alloc]initWithFrame:CGRectMake(nXX, nYY, 503, 115)];
            viewForListLand[i].backgroundColor = [UIColor clearColor];
            [vendorScrollerLand addSubview:viewForListLand[i]];
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImageLand[i].userInteractionEnabled = YES;
            [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"pic-folder.png"] forState:UIControlStateNormal];
            [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [viewForListLand[i] addSubview:vendorImageLand[i]];
            
            imageOnVendorList[i] = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 90)];
            imageOnVendorList[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            [vendorImageLand[i] addSubview:imageOnVendorList[i]];
            
            vendorTitleLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
            vendorTitleLand[i].backgroundColor = [UIColor clearColor];
            vendorTitleLand[i].text = datatitle[i];
            vendorTitleLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorTitleLand[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorTitleLand[i].textColor = [UIColor darkGrayColor];
            [viewForListLand[i] addSubview:vendorTitleLand[i]];
            
            vendorNameLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 35, 200, 20)];
            vendorNameLand[i].backgroundColor = [UIColor clearColor];
            vendorNameLand[i].text = datapath[i];
            vendorNameLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorNameLand[i].font = [UIFont boldSystemFontOfSize:15.0];
            vendorNameLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorNameLand[i]];
            
            vendorDateLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(330, 60, 200, 20)];
            vendorDateLand[i].backgroundColor = [UIColor clearColor];
            vendorDateLand[i].text = datadate[i];
            vendorDateLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDateLand[i].font = [UIFont boldSystemFontOfSize:13.0];
            vendorDateLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorDateLand[i]];
            
            vendorDetailsLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
            vendorDetailsLand[i].backgroundColor = [UIColor clearColor];
            vendorDetailsLand[i].text = datatype[i];
            vendorDetailsLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
            vendorDetailsLand[i].font = [UIFont systemFontOfSize:12.0];
            vendorDetailsLand[i].textColor = [UIColor grayColor];
            [viewForListLand[i] addSubview:vendorDetailsLand[i]];
            
            
            
            lineImageLand[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, nYY+115, 1006, 1)];
            lineImageLand[i].backgroundColor = [UIColor grayColor];
            [vendorScrollerLand addSubview:lineImageLand[i]];
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            tickmarkButtonlistLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0,0,100,100)];
            tickmarkButtonlistLand[i].userInteractionEnabled = NO;
            tickmarkButtonlistLand[i].alpha = 0.0;
            tickmarkButtonlistLand[i].tag = i;
            [tickmarkButtonlistLand[i] setBackgroundImage:nil forState:UIControlStateNormal];
            [viewForListLand[i] addSubview:tickmarkButtonlistLand[i]];
            
            nXX=nXX+503;
            nYY=nYY+115;
            
        }
        vendorScroller.contentSize = CGSizeMake(748, 115*totalVendors);
        
        if(totalVendors%2==0)
        {
            vendorScrollerLand.contentSize = CGSizeMake(1006, 115*(totalVendors/2)+20);
        }
        else
        {
             vendorScrollerLand.contentSize = CGSizeMake(1006, 115*(totalVendors/2)+125);
        }
        
    }
    
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        NSLog(@"Long Press");
        deleteVendorButton.alpha = 1.0;
        syncButton.alpha = 1.0;
        syncButtonLand.alpha = 1.0;
        shareVendorButton.alpha = 1.0;
        deleteVendorButtonLand.alpha = 1.0;
        shareVendorButtonLand.alpha = 1.0;
         offEditModeBtn.alpha = 1.0;
        offEditModeBtnLand.alpha = 1.0;
        syncButton.alpha = 1.0;
        syncButtonLand.alpha = 1.0;
        sortingTable.hidden = YES;
        sortingTableLand.hidden = YES;
        //TEST
        for (int i =0; i<totalVendors; i++)
        {
            
            tickmarkButtonlist[i].alpha = 1.0;
            tickmarkButtonlist[i].userInteractionEnabled = YES;
            [tickmarkButtonlist[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            tickmarkButtonlistLand[i].alpha = 1.0;
            tickmarkButtonlistLand[i].userInteractionEnabled = YES;
            [tickmarkButtonlistLand[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            tickmarkButtonGrid[i].alpha = 1.0;
            tickmarkButtonGrid[i].userInteractionEnabled = YES;
            [tickmarkButtonGrid[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            tickmarkButtonGridLand[i].alpha = 1.0;
            tickmarkButtonGridLand[i].userInteractionEnabled = YES;
            [tickmarkButtonGridLand[i] addTarget:self action:@selector(tickmarkClicked:) forControlEvents:UIControlEventTouchUpInside];

            

            [tickmarkButtonlist[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
            [tickmarkButtonlistLand[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
            [tickmarkButtonGrid[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
            [tickmarkButtonGridLand[gesture.view.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
            
        }

    }
    
    [deleteItems addObject:[NSString stringWithFormat:@"%@",dataid[gesture.view.tag]]];

}
-(void)tickmarkClicked:(UIButton *)sender
{
    NSLog(@"inside tickmarkClicked ");
//    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor WHERE id=%d",[sender tag]+1];
//    [self displaySelctedVendor:fetchdata];
    if([tickmarkButtonlist[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@" "]||[tickmarkButtonlistLand[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@" "])
    {
        [deleteItems addObject:[NSString stringWithFormat:@"%@",dataid[sender.tag]]];
        
        [tickmarkButtonlist[sender.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
        [tickmarkButtonlistLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@"100_100.png"] forState:UIControlStateNormal];
        [tickmarkButtonGrid[sender.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
        [tickmarkButtonGridLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@"238_227.png"] forState:UIControlStateNormal];
    }
    else //if([tickmarkButton[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@"check.png"]||[tickmarkButtonLand[sender.tag] backgroundImageForState:UIControlStateNormal] == [UIImage imageNamed:@"check.png"])
    {
        [deleteItems removeObject:[NSString stringWithFormat:@"%@",dataid[sender.tag]]];
        
        [tickmarkButtonlist[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonlistLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGrid[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGridLand[sender.tag] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];

    }
    self.view.userInteractionEnabled = YES;
}
- (IBAction)deleteVendorButton:(id)sender {
  [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    NSLog(@"aa=%@",deleteItems);
    for (int i = 0; i<[deleteItems count]; i++) {
        
        NSString *delete = [NSString stringWithFormat:@"delete from ba_tbl_vendor where id = %@",[deleteItems objectAtIndex:i]];
        [self saveData:delete];
        
    }
    [deleteItems removeAllObjects];
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;

    [self DisplayVendors];

}

-(void)openAddNote:(UIButton *)sender
{
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
       
//    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor WHERE id=%@",dataid[sender.tag]];
//    [self displaySelctedVendor:fetchdata];
    
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website, tags, email_id, address, contact_no  from ba_tbl_vendor WHERE id=%@",dataid[sender.tag]];
    
    [self displaySelctedVendor:fetchdata];
    
    
    OpenVendor *openVendor = [[OpenVendor alloc]initWithNibName:@"OpenVendor" bundle:nil];
    openVendor.vendorTitle=vendornameDB[0];
    openVendor.vendorDesciption=vendordescDB[0];
    openVendor.vendorWebsite=vendorContactnoDB[0];
    openVendor.vendorid=vendoridDB[0];
    [self.navigationController pushViewController:openVendor animated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return sortedArray.count;
  
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 1;
  }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
        static NSString *CellIdentifier = @"sorting by date1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil) {
            
            cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }

       cell1.textLabel.textColor = [UIColor grayColor];
    cell1.textLabel.font = [UIFont systemFontOfSize:12];
    cell1.textLabel.text=[sortedArray objectAtIndex:indexPath.row];
    NSLog(@"cellForRowAtIndexPath");

    [cell1 setSelected:YES];

    if ([[sortedArray objectAtIndex:indexPath.row] isEqualToString:[NSString stringWithFormat:@"%@",[sortedArray objectAtIndex:INDEX]]]) {
        [cell1 setAccessoryType:UITableViewCellAccessoryCheckmark];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        
        [cell1 setAccessoryType:UITableViewCellAccessoryNone];
         cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
       }
        return cell1;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
   // [setUserDefaults setObject:[sortedArray objectAtIndex:indexPath.row] forKey:@"selected option"];
    [setUserDefaults setInteger:indexPath.row forKey:@"selected option"];
   [self tablereloaddata];
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 
        [cell setAccessoryType:UITableViewCellAccessoryNone];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 34.0;
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
        self.view = self.lView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];

    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view = self.pView;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];

    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
     [[UINavigationBar appearance]setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


-(void)cameraClicked:(UIButton *)sender
{
    navBarButtonsIndex = sender.tag;
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    if(sender.tag == 2)
    {
        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        [self.navigationController pushViewController:addNote animated:YES];
    }
    else
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = navBarButtonsIndex;
        [self.navigationController pushViewController:openCamera animated:YES];
        
        
//        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
//        addNote.SHORTCUTCLICKED=@"1";
//        [self.navigationController pushViewController:addNote animated:YES];

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createNewVendorButton:(id)sender {
    AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
    [self.navigationController pushViewController:addNote animated:YES];

}

- (IBAction)sortByDate:(id)sender
{
   
    
    [self.pView addSubview:tableViewBgImage];
    [self.pView addSubview:sortingTable];
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    
    [self.lView addSubview:tableViewBgImageLand];
    [self.lView addSubview:sortingTableLand];
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    
    if(sortingTable.hidden == YES || sortingTableLand.hidden==YES)
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = NO;
        tableViewBgImage.alpha = 1.0;
        
        [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
        sortingTableLand.hidden = NO;
        tableViewBgImageLand.alpha = 1.0;
    }
    else if ( sortingTable.hidden == NO || sortingTableLand.hidden == NO)
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = YES;
        tableViewBgImage.alpha = 0.0;
        
        [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
        sortingTableLand.hidden = YES;
        tableViewBgImageLand.alpha = 0.0;
    }
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    
}

- (IBAction)displayGridView:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
         tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    listAndGridIndex=1;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    [self DisplayVendors];
}

- (IBAction)displayListView:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    listAndGridIndex=2;
   
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;

    
    [self DisplayVendors];
}
- (IBAction)syncButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
    totalVendors=TotalData;
    [self DisplayVendors];

    
}

- (IBAction)allVendorsButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender_on.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender_on.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
}

- (IBAction)sharedButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shared_on.jpg"] forState:UIControlStateNormal];
    [allVendorsButton setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    [shareButtonLand setBackgroundImage:[UIImage imageNamed:@"shared_on.jpg"] forState:UIControlStateNormal];
    [allVendorsButtonLand setBackgroundImage:[UIImage imageNamed:@"allvender.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
}



- (IBAction)shareVendorButton:(id)sender {
}
- (IBAction)offEditModeBtn:(id)sender {
    
    deleteVendorButton.alpha = 0.0;
    shareVendorButton.alpha = 0.0;
    deleteVendorButtonLand.alpha = 0.0;
    shareVendorButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    for (int i =0; i<totalVendors; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
        
        [tickmarkButtonlist[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonlistLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGrid[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        [tickmarkButtonGridLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];

    }

}
@end
