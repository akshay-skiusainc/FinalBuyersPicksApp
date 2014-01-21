//
//  OpenVendor.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 11/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import "OpenVendor.h"
#import "AddNote.h"
#import "CameraAudioVideoNote.h"

@interface OpenVendor ()

@end

@implementation OpenVendor
@synthesize placeHolderTitle,sortedArray,lView,pView,INDEX,sortingTable,sortByDate,listView,gridView,editButton,syncButton,noteScroller,tableViewBgImage,deleteNoteButton,shareNoteButton,vendorDesciption,vendorid,vendorTitle,vendorWebsite,listAndGridIndex,shareNoteButtonLand;
@synthesize listViewLand,gridViewLand,sortByDateLand,sortingTableLand,syncButtonLand,editButtonLand,noteScrollerLand,tableViewBgImageLand,deleteNoteButtonLand,deleteItems,offEditModeBtnLand,offEditModeBtn,vendorname;

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

    
    NSLog(@"VENDORID==%@",vendorid);
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    listAndGridIndex = 2;
    
    deleteNoteButton.alpha = 0.0;
    shareNoteButton.alpha = 0.0;
    deleteNoteButtonLand.alpha = 0.0;
    shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;

       sortedArray = [[NSArray alloc]initWithObjects:@"Default View",@"Vendor Created",@"Vendor Modified",@"A to Z",@"Z to A", nil];
    
    
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
    
    UIImage *doneImage = [UIImage imageNamed:@"navigation_icon.png"];
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
    
    tableViewBgImageLand.layer.cornerRadius = 10.0;
    tableViewBgImageLand.clipsToBounds = YES;
    tableViewBgImage.layer.cornerRadius = 10.0;
    tableViewBgImage.clipsToBounds = YES;
    
    [tableViewBgImage.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [tableViewBgImage.layer setBorderWidth:0.5];
    
  }
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topnavigation.jpg"] forBarMetrics:UIBarMetricsDefault];

    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",vendorid];
    [self displayContentData:fetchdata];
    
  
   
    
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

-(void)done
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)cameraClicked:(UIButton *)sender
{
   [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
    
    
    if(sender.tag == 2)
    {
//        NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website  from ba_tbl_vendor WHERE id=%d",[sender tag]+1];
//        [self displaySelctedVendor:fetchdata];
        
        
        NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website, tags, email_id, address, contact_no , vendor_title  from ba_tbl_vendor WHERE id=%@",vendorid];

        [self displaySelctedVendor:fetchdata];
        
        
        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
        addNote.vendorTitle=vendornameDB[0];
        addNote.vendorDesciption=vendordescDB[0];
        
        addNote.vendorWebsiteString=vendorWebsitesDB[0];
        addNote.vendorAddressString=vendorAddressDB[0];
        addNote.vendorTagsString=vendorTagsDB[0];
        addNote.vendorEmailIdString=vendorEmailIdDB[0];
        addNote.vendorContactsString=vendorContactnoDB[0];
        addNote.vendorid=vendoridDB[0];
        addNote.calledfromopenvendor=@"1";
        
        
        
        
//        AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
//        addNote.vendorTitle=vendorTitle;
//        addNote.vendorName = vendorname;
//        addNote.vendorDesciption=vendorDesciption;
//        addNote.vendorWebsite=vendorWebsite;
//        addNote.vendorid=vendorid;

        [self.navigationController pushViewController:addNote animated:YES];
      
    }
    else
    {
        CameraAudioVideoNote *openCamera = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
        openCamera.navTagFromHome = sender.tag;
        [self.navigationController pushViewController:openCamera animated:YES];
    }
}

-(void)DisplayVendors
{
    NSLog(@"listAndGridIndex = %d",listAndGridIndex);
    
    [[noteScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[noteScrollerLand subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",vendorid];
    NSLog(@"fetchdata=%@",fetchdata);
    [self displayContentData:fetchdata];

    int m = 0;
    int nXX = 0;
    int nYY = 0;
    if (listAndGridIndex==1)
    {
        int mX = 7;
        int mY = 0;
        
        int nX = 7;
        int nY = 0;
        
        NSLog(@"totalvendore = %d",TotalData);
        for (int i =0; i<=TotalData; i++)
        {
            mX=248*(i%3);
            mY=237 * (i/3);
            
            nX=248*(i%4);
            nY=237 * (i/4);
            
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(mX+7, mY, 238, 227);
            vendorImage[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 238 ,227)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImage[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            //  [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [noteScroller addSubview:vendorImage[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            tickmarkButtonGrid[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 238, 227)];
            tickmarkButtonGrid[i].userInteractionEnabled = NO;
            tickmarkButtonGrid[i].alpha = 0.0;
            tickmarkButtonGrid[i].tag = i;
            [tickmarkButtonGrid[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [vendorImage[i] addSubview:tickmarkButtonGrid[i]];
            
            
            mX=mX+248;
            mY=mY+237;
            
            
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(nX+7, nY, 238, 227);
            vendorImageLand[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 238 ,227)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImageLand[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            // [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [noteScrollerLand addSubview:vendorImageLand[i]];
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            tickmarkButtonGridLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 238, 227)];
            tickmarkButtonGridLand[i].userInteractionEnabled = NO;
            tickmarkButtonGridLand[i].alpha = 0.0;
            tickmarkButtonGridLand[i].tag = i;
            [tickmarkButtonGridLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [vendorImageLand[i] addSubview:tickmarkButtonGridLand[i]];
            
            
            nX=nX+248;
            nY=nY+237;
            
            
            
        }
        if(TotalData%3==0)
        {
            
            noteScroller.contentSize = CGSizeMake(748,237*TotalData/3+10);
        }
        else
        {
            noteScroller.contentSize = CGSizeMake(748,(237*TotalData/3)+100);
            
        }
        
        if(TotalData%4==0)
        {
            
            noteScrollerLand.contentSize = CGSizeMake(1006,237*TotalData/4+10);
        }
        else
        {
            noteScrollerLand.contentSize = CGSizeMake(1006,(237*TotalData/4)+100);
            
        }
        
    }
    if (listAndGridIndex==2)
    {
        for (int i =0; i<TotalData; i++)
        {
            viewForList[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 748, 115)];
            viewForList[i].backgroundColor = [UIColor clearColor];
            [noteScroller addSubview:viewForList[i]];
            
            vendorImage[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImage[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImage[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100 ,100)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImage[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImage[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            //  [ vendorImage[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImage[i].tag = i;
            [viewForList[i] addSubview:vendorImage[i]];
            
//            vendorName[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
//            vendorName[i].backgroundColor = [UIColor clearColor];
//            vendorName[i].text = datapath[i];
//            vendorName[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
//            vendorName[i].font = [UIFont boldSystemFontOfSize:15.0];
//            vendorName[i].textColor = [UIColor darkGrayColor];
//            [viewForList[i] addSubview:vendorName[i]];
//            
//            vendorDetails[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
//            vendorDetails[i].backgroundColor = [UIColor clearColor];
//            vendorDetails[i].text =datatype[i];
//            vendorDetails[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
//            vendorDetails[i].font = [UIFont systemFontOfSize:12.0];
//            vendorDetails[i].textColor = [UIColor grayColor];
//            [viewForList[i] addSubview:vendorDetails[i]];
            
            
            
            lineImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, 748, 1)];
            lineImage[i].backgroundColor = [UIColor grayColor];
            [viewForList[i] addSubview:lineImage[i]];
            
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPress.delegate = self;
            [vendorImage[i] addGestureRecognizer:longPress];
            
            tickmarkButtonlist[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            tickmarkButtonlist[i].userInteractionEnabled = NO;
            tickmarkButtonlist[i].alpha = 0.0;
            tickmarkButtonlist[i].tag = i;
            [tickmarkButtonlist[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [viewForList[i] addSubview:tickmarkButtonlist[i]];
            
            m=m+115;
            
            nXX=503*(i%2);
            nYY=115 * (i/2);
            
            
            viewForListLand[i] = [[UIView alloc]initWithFrame:CGRectMake(nXX, nYY, 503, 115)];
            viewForListLand[i].backgroundColor = [UIColor clearColor];
            [noteScrollerLand addSubview:viewForListLand[i]];
            
            vendorImageLand[i]	= [UIButton buttonWithType:UIButtonTypeCustom];
            vendorImageLand[i].frame = CGRectMake(10, 2, 100, 100);
            vendorImageLand[i].userInteractionEnabled = YES;
            if ([datatype[i] isEqualToString:@"image"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageWithContentsOfFile:datapath[i]] forState:UIControlStateNormal];
                
                UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100 ,100)];
                blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
                [vendorImageLand[i] addSubview:blackPhotoImage];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"video"]) {
                
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"video_rec.jpg"] forState:UIControlStateNormal];
            }
            
            
            if ([datatype[i] isEqualToString:@"audio"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"voice_rec.jpg"] forState:UIControlStateNormal];
                
            }
            
            
            
            if ([datatype[i] isEqualToString:@"text"]) {
                [vendorImageLand[i] setBackgroundImage:[UIImage imageNamed:@"tag-img.png"] forState:UIControlStateNormal];
                
                
            }
            // [ vendorImageLand[i] addTarget:self action:@selector(openAddNote:) forControlEvents:UIControlEventTouchUpInside];
            vendorImageLand[i].tag = i;
            [viewForListLand[i] addSubview:vendorImageLand[i]];
            
//            vendorNameLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 35, 200, 20)];
//            vendorNameLand[i].backgroundColor = [UIColor clearColor];
//            vendorNameLand[i].text = datapath[i];
//            vendorNameLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
//            vendorNameLand[i].font = [UIFont boldSystemFontOfSize:15.0];
//            vendorNameLand[i].textColor = [UIColor darkGrayColor];
//            [viewForListLand[i] addSubview:vendorNameLand[i]];
//            
//            vendorDetailsLand[i] = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 200, 30)];
//            vendorDetailsLand[i].backgroundColor = [UIColor clearColor];
//            vendorDetailsLand[i].text = datatype[i];
//            vendorDetailsLand[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
//            vendorDetailsLand[i].font = [UIFont systemFontOfSize:12.0];
//            vendorDetailsLand[i].textColor = [UIColor grayColor];
//            [viewForListLand[i] addSubview:vendorDetailsLand[i]];
            
            
            
            lineImageLand[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, nYY+115, 1006, 1)];
            lineImageLand[i].backgroundColor = [UIColor grayColor];
            [noteScrollerLand addSubview:lineImageLand[i]];
            
            UILongPressGestureRecognizer *longPressLand = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            longPressLand.delegate = self;
            [vendorImageLand[i] addGestureRecognizer:longPressLand];
            
            tickmarkButtonlistLand[i] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            tickmarkButtonlistLand[i].userInteractionEnabled = NO;
            tickmarkButtonlistLand[i].alpha = 0.0;
            tickmarkButtonlistLand[i].tag = i;
            [tickmarkButtonlistLand[i] setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
            [viewForListLand[i] addSubview:tickmarkButtonlistLand[i]];
            
            nXX=nXX+503;
            nYY=nYY+115;
            
        }
        noteScroller.contentSize = CGSizeMake(748, m*TotalData);
        noteScrollerLand.contentSize = CGSizeMake(1006, m*TotalData);
        
    }
    
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        NSLog(@"Long Press");
        deleteNoteButton.alpha = 1.0;
        shareNoteButton.alpha = 1.0;
        deleteNoteButtonLand.alpha = 1.0;
        shareNoteButtonLand.alpha = 1.0;
        syncButton.alpha = 1.0;
        syncButtonLand.alpha = 1.0;
        offEditModeBtn.alpha = 1.0;
        offEditModeBtnLand.alpha = 1.0;
        sortingTableLand.hidden = YES;
        sortingTable.hidden = YES;
        tableViewBgImageLand.alpha = 0.0;
        tableViewBgImage.alpha = 0.0;
        
        for (int i =0; i<TotalData; i++)
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
        
        NSString *delete = [NSString stringWithFormat:@"delete from ba_tbl_content where id = %@",[deleteItems objectAtIndex:i]];
        [self saveData:delete];
        
    }
    [deleteItems removeAllObjects];
  
    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",vendorid];
    [self displayContentData:fetchdata];
    
   
    
    [self DisplayVendors];
    
}



- (IBAction)sharedButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
    }
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;

    
    [sortByDateLand setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridViewLand setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listViewLand setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
       sortingTableLand.hidden = YES;
    tableViewBgImageLand.alpha = 0.0;
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
-(void)tablereloaddata
{
    
    INDEX = [[NSUserDefaults standardUserDefaults] integerForKey:@"selected option"];
    NSLog(@"INDEX = %d",INDEX);
    [sortingTable reloadData];
  
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

- (IBAction)sortByDate:(id)sender
{
     deleteNoteButton.alpha = 0.0;
     shareNoteButton.alpha = 0.0;
     deleteNoteButtonLand.alpha = 0.0;
     shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    
    [self.pView addSubview:tableViewBgImage];
    [self.pView addSubview:sortingTable];
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
    
    
    if(sortingTable.hidden == YES )
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb_on.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = NO;
        tableViewBgImage.alpha = 1.0;
        
          }
    else if ( sortingTable.hidden == NO )
    {
        [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
        sortingTable.hidden = YES;
        tableViewBgImage.alpha = 0.0;
        
    }
}

- (IBAction)displayGridView:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;

      
    }
    listAndGridIndex=1;
    deleteNoteButton.alpha = 0.0;
    deleteNoteButtonLand.alpha = 0.0;
    shareNoteButton.alpha = 0.0;
     shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb_on.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
  
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    
    [self DisplayVendors];
}

- (IBAction)displayListView:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;

       
    }
    listAndGridIndex=2;
    deleteNoteButtonLand.alpha = 0.0;
     shareNoteButton.alpha = 0.0;
    deleteNoteButton.alpha = 0.0;
    shareNoteButtonLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view_on.jpg"] forState:UIControlStateNormal];
 
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    
    [self DisplayVendors];
}
- (IBAction)syncButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    for (int i =0; i<TotalData; i++)
    {
        tickmarkButtonlist[i].alpha = 0.0;
        tickmarkButtonlistLand[i].alpha = 0.0;
        tickmarkButtonGridLand[i].alpha = 0.0;
        tickmarkButtonGrid[i].alpha = 0.0;
       
    }
   
    
    [sortByDate setBackgroundImage:[UIImage imageNamed:@"small_thumb.jpg"] forState:UIControlStateNormal];
    [gridView setBackgroundImage:[UIImage imageNamed:@"thumb.jpg"] forState:UIControlStateNormal];
    [listView setBackgroundImage:[UIImage imageNamed:@"list_view.jpg"] forState:UIControlStateNormal];
  
    sortingTable.hidden = YES;
    tableViewBgImage.alpha = 0.0;
    
    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description from ba_tbl_vendor"];
    [self displayContentData:fetchdata];
    
   
    [self DisplayVendors];
    
    
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
    
    sortingTable.frame = CGRectMake(616, 45, 137, 133);
    sortingTableLand.frame = CGRectMake(871, 43, 137, 133);
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
- (IBAction)editButton:(id)sender
{
    [self performSelector:@selector(offEditModeBtn:) withObject:nil afterDelay:0.0];
    
    NSLog(@"VENDORID=%@",vendorid);
    AddNote *addNote = [[AddNote alloc]initWithNibName:@"AddNote" bundle:nil];
    addNote.vendorTitle=vendorTitle;
    addNote.vendorDesciption=vendorDesciption;
    addNote.vendorWebsite=vendorWebsite;
    addNote.vendorid=vendorid;
    addNote.calledfromopenvendor=@"1";
    
    [self.navigationController pushViewController:addNote animated:YES];
}

- (IBAction)offEditModeBtn:(id)sender {
    
    deleteNoteButton.alpha = 0.0;
    shareNoteButton.alpha = 0.0;
    deleteNoteButtonLand.alpha = 0.0;
    shareNoteButtonLand.alpha = 0.0;
    offEditModeBtn.alpha = 0.0;
    offEditModeBtnLand.alpha = 0.0;
    syncButton.alpha = 0.0;
    syncButtonLand.alpha = 0.0;
    
    for (int i =0; i<TotalData; i++)
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
