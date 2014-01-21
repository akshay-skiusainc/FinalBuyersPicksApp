//
//  AddNote.m
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 24/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import "AddNote.h"
#import "CameraAudioVideoNote.h"
#import "MyLocation.h"
#define kGeoCodingString @"http://maps.google.com/maps/geo?q=%f,%f&output=csv"
#import "NoteTableViewController.h"

@interface AddNote ()

@end

@implementation AddNote
@synthesize pView,titleTextField,nameTextField,descriptionTextField,selectIndustryLabel,industryTableView,tagTextView,websiteTextView,emailIdTextView,contactNoTextView,addressTextView,currentLocationTextView,noteArray,noteScroller,goToCamera,SHORTCUTCLICKED;
@synthesize mapView;
@synthesize titleBgImage,selectIndusBgImage,websiteBgImage,addressBgImage,currntLocBgImage,contactBgImage,emailBgImage,titleLabel,nameLabel,descLabel,tagLabel,tagBgImage,websiteLabel,addressLabel,emailLabel,contactLabel,currentLocLabel,tagButton,addWebsiteBtn,addEmailBtn,addAddressbtn,addContactBtn,mainScroller,mainView,TAG,vendorDesciption,vendorTitle,vendorWebsite,vendorid,vendorName,calledfromopenvendor;



@synthesize WebsiteArray,EmailIDArray,AddressArray,ContactsArray,tagsArray,displayTagsArray;
@synthesize yAxis,xAxis,strLength;
@synthesize vendorTagsString,vendorContactsString,vendorEmailIdString,vendorAddressString,vendorWebsiteString;
@synthesize tagTextViewString,websiteTextViewString,emailIdTextViewString,contactNoTextViewString,addressTextViewString;
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
       GlobalClass     *obj = [GlobalClass getInstance];
    obj.vendorid1=vendorid;
    ContactsArray = [[NSArray alloc]init];
    EmailIDArray = [[NSArray alloc]init];
    AddressArray = [[NSArray alloc]init];
    WebsiteArray = [[NSArray alloc]init];
    tagsArray = [[NSArray alloc]init];
    displayTagsArray= [[NSMutableArray alloc]init];
    
    websiteTextViewString = [[NSMutableString alloc] init];
    addressTextViewString = [[NSMutableString alloc] init];
    contactNoTextViewString = [[NSMutableString alloc] init];
    emailIdTextViewString = [[NSMutableString alloc] init];
    tagTextViewString = [[NSMutableString alloc] init];
    
    dataFwdObj=[DataFwdClass getInstance];
    dataFwdObj.noteTagsArray  = [[NSMutableArray alloc] init];

    yAxis= 10;
    xAxis= 10;
    strLength = 0;

    [self LoadStrings];
    
   
    
    
    industryTableView.hidden = YES;
    
    noteArray = [[NSMutableArray alloc]init];
    [noteArray addObject:[UIImage imageNamed:@"camera_rec.jpg"]];
    
    UIImage *cardScannerImage = [UIImage imageNamed:@"cardscanner-black.png"];
    UIButton *cardScannerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cardScannerButton setImage:cardScannerImage forState:UIControlStateNormal];
    cardScannerButton.frame = CGRectMake(0, 5, cardScannerImage.size.width, cardScannerImage.size.height);
    cardScannerButton.tag = 1;
    [cardScannerButton addTarget:self action:@selector(cardScannerClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemAudio = [[UIBarButtonItem alloc] initWithCustomView:cardScannerButton];
    
    
    UIImage *barcodeReaderImage = [UIImage imageNamed:@"barcodereader.png"];
    UIButton *barcodeReaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barcodeReaderButton setImage:barcodeReaderImage forState:UIControlStateNormal];
    barcodeReaderButton.frame = CGRectMake(0, 5, barcodeReaderImage.size.width, barcodeReaderImage.size.height);
    barcodeReaderButton.tag = 2;
    [barcodeReaderButton addTarget:self action:@selector(barcodeReaderClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItemNote = [[UIBarButtonItem alloc] initWithCustomView:barcodeReaderButton];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:customBarItemNote, customBarItemAudio,nil]];
    
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
        
        UIImage *nextImage = [UIImage imageNamed:@"next.png"];
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:nextImage forState:UIControlStateNormal];
        nextButton.frame = CGRectMake(0, 3, 64, 37);
        [nextButton addTarget:self action:@selector(goToCamera:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarItemNext = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
       
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:customBarItemDone, customBarItemNext,nil]];
    }


    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.text = @"Create New Vendor";
    navTitleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size: 30.0];
    navTitleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    navTitleLabel.textColor = [UIColor darkGrayColor];
    self.navigationItem.titleView = navTitleLabel;
    
    
    
    // For map & Geo Tagging
    currentLocation = [[CLLocationManager alloc]init];
	currentLocation.desiredAccuracy = kCLLocationAccuracyBest;
	currentLocation.delegate = self;
	[currentLocation startUpdatingLocation];
    //    mapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
    //    mapView.showsUserLocation=TRUE;
    //mapView.mapType=MKMapTypeStandard;
    
    mapView.delegate=self;
    
    if ([SHORTCUTCLICKED isEqualToString:@"1"]) {
        [self performSelector:@selector(SHORTCUTCLICKED) withObject:nil afterDelay:0.0];
        
    }


}


-(void)LoadStrings
{
    NSLog(@"VENDORID=%@",vendorid);

    NSString   *fetchdata = [NSString stringWithFormat:@"select id , vendor_name, Description, website, tags, email_id, address, contact_no , vendor_title  from ba_tbl_vendor WHERE id=%@",vendorid];
    
    [self displaySelctedVendor:fetchdata];
    nameTextField.text=vendornameDB[0];
    descriptionTextField.text=vendordescDB[0];
    titleTextField.text = vendortitleDB[0];

    if (vendorTagsDB[0].length>0) {
        tagsArray=[ vendorTagsDB[0] componentsSeparatedByString:@","];
    }
    if (vendorEmailIdDB[0].length>0) {
        EmailIDArray=[ vendorEmailIdDB[0] componentsSeparatedByString:@","];
    }
    if (vendorAddressDB[0].length>0) {
       AddressArray=[ vendorAddressDB[0] componentsSeparatedByString:@","];
    }
    if (vendorContactnoDB[0].length>0) {
       ContactsArray=[ vendorContactnoDB[0] componentsSeparatedByString:@","];
    }
    if (vendorWebsitesDB[0].length>0) {
       WebsiteArray=[ vendorWebsitesDB[0] componentsSeparatedByString:@","];
    }
    
    
    
    
    
    
    NSLog(@"tagsArray =%d , %@",tagsArray.count,tagsArray);
    NSLog(@"EmailIDArray = %d , %@",EmailIDArray.count,EmailIDArray);
    NSLog(@"AddressArray =%d , %@",AddressArray.count,AddressArray);
    NSLog(@"ContactsArray =%d , %@",ContactsArray.count,ContactsArray);
    NSLog(@"WebsiteArray =%d , %@",WebsiteArray.count,WebsiteArray);
    [self LoadTags];
}

-(void)LoadTags
{
    
    int m=0;
        //   **************************************************************************** addWebsite ******************************************************************
    
            
            if (WebsiteArray.count > 0) {
                
                for(int i = 0; i<[WebsiteArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[WebsiteArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+5,strLength+5, 20)];
                    lbl1.backgroundColor=[UIColor lightGrayColor];
                    lbl1.text=names1;
                    if (i==0) {
                        [websiteTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [websiteTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    m=m+20;
                    [self.websiteTextView addSubview:lbl1];
                }
                
                self.websiteTextView.contentSize=CGSizeMake(259, displayTagsArray.count+20);
                //contactNoTextView.text=names;
            }

        
        //   **************************************************************************** addAddress ******************************************************************
    
            if (AddressArray.count > 0) {
                
                for(int i = 0; i<[AddressArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[AddressArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+5,strLength+5, 20)];
                    lbl1.backgroundColor=[UIColor lightGrayColor];
                    lbl1.text=names1;
                    if (i==0) {
                        [addressTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [addressTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    m=m+20;
                    [self.addressTextView addSubview:lbl1];
                }
                
                self.addressTextView.contentSize=CGSizeMake(259, displayTagsArray.count+20);
                //contactNoTextView.text=names;
            }
 
        
        //   **************************************************************************** addContactNo ******************************************************************
        
    
            if (ContactsArray.count > 0) {
                
                for(int i = 0; i<[ContactsArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[ContactsArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+5,strLength+5, 20)];
                    lbl1.backgroundColor=[UIColor lightGrayColor];
                    lbl1.text=names1;
                    
                    if (i==0) {
                        [contactNoTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [contactNoTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    m=m+20;
                    [self.contactNoTextView addSubview:lbl1];
                }
                
                self.contactNoTextView.contentSize=CGSizeMake(235, displayTagsArray.count+20);
                //contactNoTextView.text=names;
            }
            
    
        
        //   **************************************************************************** addEmail ******************************************************************
        
    
            if (EmailIDArray.count > 0) {
                
                for(int i = 0; i<[EmailIDArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[EmailIDArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+5,strLength+5, 20)];
                    lbl1.backgroundColor=[UIColor lightGrayColor];
                    lbl1.text=names1;
                    
                    if (i==0) {
                        [emailIdTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [emailIdTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    m=m+20;
                    [self.emailIdTextView addSubview:lbl1];
                }
                
                self.emailIdTextView.contentSize=CGSizeMake(259, displayTagsArray.count+20);
                //contactNoTextView.text=names;
            }
            
    
        
        //   **************************************************************************** tagButton ******************************************************************
    if (tagsArray.count > 0) {

            for(int i = 0; i<[tagsArray count];i++)
            {
                NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[tagsArray objectAtIndex:i]];
                strLength= names1.length *8.5;
                NSLog(@"strLength %f",strLength);
                // [names appendString:names1 ];
                if (xAxis <=320) {
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, 5+strLength, 20)];
                    lbl1.backgroundColor=[UIColor lightGrayColor];
                    lbl1.text=names1;
                    lbl1.textColor=[UIColor whiteColor];
                    
                    xAxis= xAxis + (strLength+15);
                    NSLog(@"if xAxis %f",xAxis);
                    NSLog(@"if yAxis %f",yAxis);
                    [self.tagTextView addSubview:lbl1];
                }
                else
                {
                    xAxis=10;
                    yAxis=yAxis+22;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, 5 +strLength, 20)];
                    lbl1.backgroundColor=[UIColor lightGrayColor];
                    lbl1.text=names1;
                    lbl1.textColor=[UIColor whiteColor];
                    
                    NSLog(@"else xAxis %f",xAxis);
                    NSLog(@"else yAxis %f",yAxis);
                    [self.tagTextView addSubview:lbl1];
                }
                if (i==0) {
                    [tagTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                }
                else
                {
                    [tagTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                }
                
                
            }
            self.tagTextView.contentSize=CGSizeMake(320, yAxis+20);
            
        }
}




-(void)DisplayTags
{
    
    [displayTagsArray removeAllObjects];
    dataFwdObj=[DataFwdClass getInstance];
    displayTagsArray = dataFwdObj.noteTagsArray;
    int m = 0;
    // For displaying Names on Contact Field
    if (displayTagsArray.count > 0) {
        
        
        //   **************************************************************************** addWebsite ******************************************************************
        if ([dataFwdObj.fieldCalled isEqualToString:@"addWebsite"]) {
            m=0;
            if (displayTagsArray.count > 0) {
                
                for(int i = 0; i<[displayTagsArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[displayTagsArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+2,strLength+5, 20)];
                    lbl1.backgroundColor=[self colorWithHexString:@"e3e3e3"];
                    lbl1.font = [UIFont systemFontOfSize:14.0];
                    lbl1.textColor = [UIColor darkGrayColor];
                    lbl1.layer.cornerRadius = 5.0;
                    lbl1.clipsToBounds = YES;

                    lbl1.text=names1;
                    if (i==0) {
                        [websiteTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [websiteTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    m=m+21;
                    [self.websiteTextView addSubview:lbl1];
                }
                
                self.websiteTextView.contentSize=CGSizeMake(259, m);
                //contactNoTextView.text=names;
            }
        }
        
        //   **************************************************************************** addAddress ******************************************************************
        
        if ([dataFwdObj.fieldCalled isEqualToString:@"addAddress"]) {
            m=0;
            if (displayTagsArray.count > 0) {
                
                for(int i = 0; i<[displayTagsArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[displayTagsArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+2,strLength+5, 20)];
                    lbl1.backgroundColor=[self colorWithHexString:@"e3e3e3"];
                    lbl1.font = [UIFont systemFontOfSize:14.0];
                    lbl1.textColor = [UIColor darkGrayColor];
                    lbl1.layer.cornerRadius = 5.0;
                    lbl1.clipsToBounds = YES;

                    lbl1.text=names1;
                    if (i==0) {
                        [addressTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [addressTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    m=m+21;
                    [self.addressTextView addSubview:lbl1];
                }
                
                self.addressTextView.contentSize=CGSizeMake(259, m);
                //contactNoTextView.text=names;
            }
            
        }
        
        //   **************************************************************************** addContactNo ******************************************************************
        
        if ([dataFwdObj.fieldCalled isEqualToString:@"addContactNo"]) {
            
            if (displayTagsArray.count > 0) {
                m=0;
                for(int i = 0; i<[displayTagsArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[displayTagsArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+2,strLength+5, 20)];
                    lbl1.backgroundColor=[self colorWithHexString:@"e3e3e3"];
                    lbl1.font = [UIFont systemFontOfSize:14.0];
                    lbl1.textColor = [UIColor darkGrayColor];
                    lbl1.layer.cornerRadius = 5.0;
                    lbl1.clipsToBounds = YES;

                    lbl1.text=names1;
                    
                    if (i==0) {
                        [contactNoTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [contactNoTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    m=m+21;
                    [self.contactNoTextView addSubview:lbl1];
                }
                
                self.contactNoTextView.contentSize=CGSizeMake(235, m);
                //contactNoTextView.text=names;
            }
            
        }
        
        //   **************************************************************************** addEmail ******************************************************************
        
        if ([dataFwdObj.fieldCalled isEqualToString:@"addEmail"]) {
            m=0;
            if (displayTagsArray.count > 0) {
                
                for(int i = 0; i<[displayTagsArray count];i++)
                {
                    NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[displayTagsArray objectAtIndex:i]];
                    strLength= names1.length *8.5;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(5, m+2,strLength+5, 20)];
                    lbl1.backgroundColor=[self colorWithHexString:@"e3e3e3"];
                    lbl1.font = [UIFont systemFontOfSize:14.0];
                    lbl1.textColor = [UIColor darkGrayColor];
                    lbl1.layer.cornerRadius = 5.0;
                    lbl1.clipsToBounds = YES;

                    lbl1.text=names1;
                    
                    if (i==0) {
                        [emailIdTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                    }
                    else
                    {
                        [emailIdTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                    }
                    
                    [self.emailIdTextView addSubview:lbl1];
                       m=m+21;
                }
                
                               //contactNoTextView.text=names;
            }
            self.emailIdTextView.contentSize=CGSizeMake(259, m);

        }
        
        //   **************************************************************************** tagButton ******************************************************************
        
        if ([dataFwdObj.fieldCalled isEqualToString:@"tagButton"]) {
        
            for(int i = 0; i<[displayTagsArray count];i++)
            {
                NSString *names1 = [[NSString alloc] initWithFormat:@" %@",[displayTagsArray objectAtIndex:i]];
                strLength= names1.length *8.5;
                NSLog(@"strLength %f",strLength);
                // [names appendString:names1 ];
                if (xAxis <=320) {
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, 5+strLength, 20)];
                    lbl1.backgroundColor=[self colorWithHexString:@"e3e3e3"];
                    lbl1.font = [UIFont systemFontOfSize:14.0];
                    lbl1.textColor = [UIColor darkGrayColor];
                    lbl1.layer.cornerRadius = 5.0;
                    lbl1.clipsToBounds = YES;
                    lbl1.text=names1;
                   
                    
                    xAxis= xAxis + (strLength+15);
                    NSLog(@"if xAxis %f",xAxis);
                    NSLog(@"if yAxis %f",yAxis);
                    [self.tagTextView addSubview:lbl1];
                }
                else
                {
                    xAxis=10;
                    yAxis=yAxis+22;
                    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, 5 +strLength, 20)];
                    lbl1.backgroundColor=[self colorWithHexString:@"e3e3e3"];
                    lbl1.font = [UIFont systemFontOfSize:14.0];
                    lbl1.textColor = [UIColor darkGrayColor];
                    lbl1.layer.cornerRadius = 5.0;
                    lbl1.clipsToBounds = YES;
                    lbl1.text=names1;
                    
                    NSLog(@"else xAxis %f",xAxis);
                    NSLog(@"else yAxis %f",yAxis);
                    [self.tagTextView addSubview:lbl1];
                }
                if (i==0) {
                    [tagTextViewString appendString:[NSString stringWithFormat:@"%@",names1]];
                }
                else
                {
                    [tagTextViewString appendString:[NSString stringWithFormat:@",%@",names1]];
                }
                
                
            }
            self.tagTextView.contentSize=CGSizeMake(320, yAxis+20);
            
        }
    }
}






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header.jpg"] forBarMetrics:UIBarMetricsDefault];

    NSLog(@"In view will Appear");
    
    [self DisplayTags];
    
    
    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
    if(ori == UIInterfaceOrientationLandscapeRight || ori ==UIInterfaceOrientationLandscapeLeft)
    {
        
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-1024-704.jpg"]];
        NSLog(@"In view will Appear landscape");
        mainScroller.frame = CGRectMake(0, 0, 1024, 704);
        mainView.frame = CGRectMake(0, 0, 1020, 940);
        titleBgImage.frame = CGRectMake(20, 3, 592, 128);
        selectIndusBgImage.frame = CGRectMake(20, 127, 592, 44);
        tagBgImage.frame = CGRectMake(20, 171, 513, 69);
        websiteBgImage.frame = CGRectMake(20, 239, 592, 74);
        addressBgImage.frame = CGRectMake(20, 388, 592, 103);
        contactBgImage.frame = CGRectMake(20, 489, 592, 103);
        emailBgImage.frame = CGRectMake(20, 313, 592, 74);
        titleLabel.frame = CGRectMake(32, 17, 42, 21);
        nameLabel.frame = CGRectMake(32, 58, 55, 21);
        descLabel.frame = CGRectMake(30, 92, 97, 32);
        titleTextField.frame = CGRectMake(143, 14, 456, 30);
        nameTextField.frame = CGRectMake(143, 54, 456, 30);
        descriptionTextField.frame = CGRectMake(143, 91, 456, 30);
        tagLabel.frame = CGRectMake(32, 186, 44, 39);
        selectIndustryLabel.frame = CGRectMake(30, 129, 569, 36);
        tagTextView.frame = CGRectMake(77, 176, 450, 54);
        tagButton.frame = CGRectMake(535, 171, 77, 70);
        websiteLabel.frame = CGRectMake(30, 253, 65, 39);
        websiteTextView.frame = CGRectMake(95, 243, 411, 66);
        addWebsiteBtn.frame = CGRectMake(498, 285, 106, 23);
        addAddressbtn.frame = CGRectMake(498, 459, 106, 23);
        addContactBtn.frame = CGRectMake(498, 558, 106, 23);
        addEmailBtn.frame = CGRectMake(498, 361, 106, 23);
        addressLabel.frame = CGRectMake(29, 416, 65, 39);
        addressTextView.frame = CGRectMake(94, 394, 407, 87);
        contactLabel.frame = CGRectMake(29, 512, 82, 39);
        contactNoTextView.frame = CGRectMake(119, 491, 382, 92);
        emailLabel.frame = CGRectMake(30, 328, 65, 39);
        emailIdTextView.frame = CGRectMake(97, 317, 404, 63);
        noteScroller.frame = CGRectMake(10, 668, 1004, 183);
        goToCamera.frame = CGRectMake(14, 663, 152, 190);
        currntLocBgImage.frame = CGRectMake(20, 591, 592, 74);
        currentLocLabel.frame = CGRectMake(30, 608, 117, 39);
        currentLocationTextView.frame = CGRectMake(155, 600, 438, 55);
        industryTableView.frame = CGRectMake(23, 167, 581, 125);
        
        mainScroller.contentSize = CGSizeMake(1024, 1000);
        
        mapView.frame = CGRectMake(620, 2, 400, 658);
        
    }
    
    else if(ori == UIInterfaceOrientationPortrait || ori == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
        mainScroller.frame = CGRectMake(13, 20, 742, 940);
        mainView.frame = CGRectMake(0, 0, 742, 940);
        titleBgImage.frame = CGRectMake(20, 12, 702, 128);
        selectIndusBgImage.frame = CGRectMake(20, 149, 702, 44);
        tagBgImage.frame = CGRectMake(20, 196, 613, 69);
        websiteBgImage.frame = CGRectMake(20, 269, 362, 74);
        addressBgImage.frame = CGRectMake(20, 345, 362, 103);
        contactBgImage.frame = CGRectMake(383, 346, 339, 103);
        emailBgImage.frame = CGRectMake(383, 269, 339, 74);
        titleLabel.frame = CGRectMake(32, 26, 42, 21);
        nameLabel.frame = CGRectMake(32, 67, 55, 21);
        descLabel.frame = CGRectMake(30, 101, 97, 32);
        titleTextField.frame = CGRectMake(143, 23, 544, 30);
        nameTextField.frame = CGRectMake(143, 63, 544, 30);
        descriptionTextField.frame = CGRectMake(143, 102, 544, 30);
        tagLabel.frame = CGRectMake(32, 211, 44, 39);
        selectIndustryLabel.frame = CGRectMake(30, 151, 629, 36);
       
        tagButton.frame = CGRectMake(645, 195, 77, 70);
        websiteLabel.frame = CGRectMake(30, 274, 65, 39);
       
        addWebsiteBtn.frame = CGRectMake(269, 312, 106, 23);
        addAddressbtn.frame = CGRectMake(269, 418, 106, 23);
        addContactBtn.frame = CGRectMake(611, 419, 106, 23);
        addEmailBtn.frame = CGRectMake(611, 312, 106, 23);
        addressLabel.frame = CGRectMake(29, 371, 65, 39);
       
        contactLabel.frame = CGRectMake(392, 372, 82, 39);
       
        emailLabel.frame = CGRectMake(391, 274, 65, 39);
       
        noteScroller.frame = CGRectMake(0, 757, 742, 183);
        goToCamera.frame = CGRectMake(7, 752, 152, 190);
        currntLocBgImage.frame = CGRectMake(20, 451, 702, 74);
        currentLocLabel.frame = CGRectMake(30, 469, 117, 39);
        currentLocationTextView.frame = CGRectMake(155, 463, 553, 52);
        industryTableView.frame = CGRectMake(24, 188, 698, 125);
        
        mainScroller.contentSize = CGSizeMake(742, 1000);
        
        mapView.frame = CGRectMake(23, 526, 698, 227);
        tagTextView.frame = CGRectMake(94, 196, 527, 60);
        addressTextView.frame = CGRectMake(103, 351, 259, 70);
        contactNoTextView.frame = CGRectMake(476, 351, 235, 70);
        emailIdTextView.frame = CGRectMake(458, 273, 259, 41);
         websiteTextView.frame = CGRectMake(103, 274, 259, 40);
    }
    
    [self displayScroller];
    
}


// Map & Geo-Tagging
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"GGG");
    
	[currentLocation stopUpdatingLocation];
    
    
	theCoordinate.latitude = newLocation.coordinate.latitude;
	theCoordinate.longitude = newLocation.coordinate.longitude;
    CurrentLatitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    CurrentLongitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] ;
    
    
    
    NSLog(@"currloc= %f",theCoordinate.longitude);
    
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    MKReverseGeocoder *geoCoder=[[MKReverseGeocoder alloc]
                                 initWithCoordinate:newLocation.coordinate];
    geoCoder.delegate=self;
    
    [geoCoder start];
	[self showCurrentLoc];
    [self getAddressFromLatLon:theCoordinate.latitude withLongitude:theCoordinate.longitude];
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark

{
	NSLog(@"Retrive: %@", placemark);
    NSString *locations=[NSString stringWithFormat:@"%@ \n",placemark];
    currentLocationTextView.text=locations;
   NSLog(@"locations: %@", locations);
    
	[geocoder cancel];
    
}
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	NSLog(@"%@",error);
	[geocoder cancel];
}

- (void)showCurrentLoc
{
   	{
        
        MKCoordinateRegion region;
        region.center = theCoordinate;
        MKCoordinateSpan span;
        mapView.delegate=self;
        span.latitudeDelta = 0.10;
        span.longitudeDelta = 0.10;
        region.span=span;
        [mapView setRegion:region animated:TRUE];
        //        theCoordinate.latitude = theater_lat;
        //        theCoordinate.longitude = theater_lng;
        
		
		annotation1 *annotation = [[annotation1 alloc] initWithCoordinate:theCoordinate andID:0];
        
        
		annotation.title = @"Your Location";
		annotation.subtitle =locationString;
        
		
		[Map_Annotaions insertObject:annotation atIndex:0];
        //  [mapView addAnnotation:[Map_Annotaions objectAtIndex:0]];
        
        
	}
}

-(void)displayallannotations
{
    for (int i = 1; i<9; i++) {
        
        
        [mapView addAnnotation:[Map_Annotaions objectAtIndex:i]];
    }
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    NSLog(@"OKOKOKOKOKOK");
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    if ([annotation isKindOfClass:[annotation1 class]]) // for Golden Gate Bridge
    {
        // try to dequeue an existing pin view first
        static NSString* BridgeAnnotationIdentifier = @"annotation1Identifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] ;
            customPinView.pinColor = MKPinAnnotationColorGreen;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            
            
            
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}



-(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    NSString *urlString = [NSString stringWithFormat:kGeoCodingString,pdblLatitude, pdblLongitude];
    NSLog(@"str=%@",urlString);
    NSError* error;
    locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
    
    //   ArrayForLocation= [NSMutableArray initWithCapacity:20];
    
    
    locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    // locationString = [locationString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"loc=%@",locationString);
    return [locationString substringFromIndex:6];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	[currentLocation stopUpdatingLocation];
}





-(void)cardScannerClicked:(UIButton *)sender
{
    
}

-(void)barcodeReaderClicked:(UIButton *)sender
{
    
}

-(void)displayScroller
{
    [[noteScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (check==1) {
        NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor"];
        [self displayAll:insertquery1];
        
        
        NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",MobileNo];
        [self displayContentData:fetchdata];

    }
    
    else {
     
    NSString   *fetchdata = [NSString stringWithFormat:@"select id, path, type from ba_tbl_content where vendor_id=%@",vendorid];
    [self displayContentData:fetchdata];
        

    NSLog(@"total data = %d",TotalData);
     NSLog(@"fetchdata= %@",fetchdata);
    }
    int j =0;
    for (int i =0; i<TotalData; i++) {
        
        
        frame[i] = [[UIImageView alloc] initWithFrame:CGRectMake(j,0 , 140,150)];
		frame[i].image = [UIImage imageNamed:@"note_rec.jpg"];
		frame[i].userInteractionEnabled=YES;
		[noteScroller addSubview:frame[i]];
        
        if ([datatype[i] isEqualToString:@"image"]) {
            frame[i].image = [UIImage imageWithContentsOfFile:datapath[i]];
            UIImageView *blackPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140 ,150)];
            blackPhotoImage.image = [UIImage imageNamed:@"blank.png"];
            [frame[i] addSubview:blackPhotoImage];

        }
        
        
        
        if ([datatype[i] isEqualToString:@"video"]) {
            frame[i].image = [UIImage imageNamed:@"video_rec.jpg"];
            
        }
        
        
        if ([datatype[i] isEqualToString:@"audio"]) {
            frame[i].image = [UIImage imageNamed:@"voice_rec.jpg"];
            
        }
        
        
        
        if ([datatype[i] isEqualToString:@"text"]) {
            frame[i].image = [UIImage imageNamed:@"tag-img.png"];
            
        }
        
        
        tagField[i] = [[UITextField alloc] initWithFrame:CGRectMake(j, 153, 140, 24)];
        tagField[i].borderStyle = UITextBorderStyleRoundedRect;
        tagField[i].textColor = [UIColor blackColor];
        tagField[i].font = [UIFont systemFontOfSize:14.0];
        tagField[i].placeholder = @"ADD TAG HERE";
        tagField[i].backgroundColor = [UIColor clearColor];
        tagField[i].autocorrectionType = UITextAutocorrectionTypeYes;
        tagField[i].keyboardType = UIKeyboardTypeDefault;
        tagField[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        tagField[i].delegate = self;
        
        [noteScroller addSubview:tagField[i]];
        
        j+=145;
        
       
    }
    
    noteScroller.contentSize = CGSizeMake(TotalData*145, 177);
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
//    [UIView setAnimationDuration:.3];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    UIInterfaceOrientation ori = [[UIApplication sharedApplication]statusBarOrientation];
//    
//    if(ori == UIInterfaceOrientationLandscapeRight |ori == UIInterfaceOrientationLandscapeLeft)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     -290,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//    }
//    else if(ori == UIInterfaceOrientationPortrait |ori == UIInterfaceOrientationPortraitUpsideDown)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     -260,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//    }
//    
//    [UIView commitAnimations];
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
//    [UIView setAnimationDuration:.3];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"currSysVer = %@",currSysVer);
//    
//    int currSysVerInInt = [currSysVer intValue];
//    NSLog(@"currSysVerInInt = %d",currSysVerInInt);
//    
//    if(currSysVerInInt >= 7)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     64,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//    }
//    else if(currSysVerInInt < 7)
//    {
//        self.view.frame = CGRectMake(self.view.frame.origin.x,
//                                     0,
//                                     self.view.frame.size.width,
//                                     self.view.frame.size.height);
//        
//    }
//
//    
//    
//    [UIView commitAnimations];
//    
//    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
	return YES;
}

-(void)done
{
    if ([calledfromopenvendor isEqualToString:@"1"]) {
        
        
            NSString   *insertquery = [NSString stringWithFormat:@"update  ba_tbl_vendor SET tags =\"%@\", website=\"%@\" , email_id=\"%@\",  address=\"%@\",  contact_no=\"%@\" ,vendor_name = \"%@\" , description=  \"%@\",  vendor_title = \"%@\" where id =\"%@\"" , tagTextViewString,websiteTextViewString,emailIdTextViewString,addressTextViewString,contactNoTextViewString,nameTextField.text,descriptionTextField.text,titleTextField.text,vendorid ];
        [self saveData:insertquery];
        
        
        
    }
    
    else{
        
        
        GlobalClass     *obj = [GlobalClass getInstance];
        obj.vendorid1=vendorid;
        NSLog(@" obj.vendorid1=%d", obj.vendorid1.length);
        
        if (obj.vendorid1.length > 0) {
            
        }else{
            
            NSLog(@" obj.vendorid2=%@", obj.vendorid1);
            
            
            
            NSDate *date = [NSDate date];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"dd-MM-yyyy hh:mm"];
            
            
            NSString *tempDate = [dateFormat stringFromDate:date];
            
            
            
            
            if (check==1) {
                NSString   *insertquery1 = [NSString stringWithFormat:@"SELECT * from  ba_tbl_vendor"];
                [self displayAll:insertquery1];
                
                NSString   *insertquery = [NSString stringWithFormat:@"update  ba_tbl_vendor SET tags =\"%@\", website=\"%@\" , email_id=\"%@\",  address=\"%@\",  contact_no=\"%@\" ,vendor_name = \"%@\" , description=  \"%@\",  vendor_title = \"%@\" where id =\"%@\"" , tagTextViewString,websiteTextViewString,emailIdTextViewString,addressTextViewString,contactNoTextViewString,nameTextField.text,descriptionTextField.text,titleTextField.text,MobileNo ];
                [self saveData:insertquery];
                
            }
            
            else{
                if(nameTextField.text.length >0)
                {
                    NSLog(@"TTTT");
                    //            NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_vendor ( vendor_name , user_id , tags , alias , description , website , path , created_date , security_pin , old_security_pin , last_modified_security_pin , geo_latitude , geo_longitude , last_modified_date , is_deleted , delete_date ) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", titleTextField.text, @"1", tagTextView.text, @"", descriptionTextField.text, websiteTextView.text, @"path", @"created_date", @"securepin", @"oldpin", @"last_modified_security_pin",@"geolat",@"geolng", @"lastmodified" , @"YES",@"Deletedate"];
                    //
                    
                    
                    NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_vendor ( vendor_name , user_id , tags , alias , description , website , path , created_date , security_pin , old_security_pin , last_modified_security_pin , geo_latitude , geo_longitude , last_modified_date , is_deleted , delete_date, email_id , address , contact_no , vendor_title) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", nameTextField.text, @"1", tagTextViewString, @"", descriptionTextField.text, websiteTextViewString, @"path", tempDate, @"securepin", @"oldpin", @"last_modified_security_pin",@"geolat",@"geolng", tempDate , @"YES",@"Deletedate",emailIdTextViewString,addressTextViewString,contactNoTextViewString,titleTextField.text ];
                    
                    NSLog(@"insertquery = %@ ",insertquery);
                    [self saveData:insertquery];
                    
                    
                }
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *CellIdentifier = @"sorting by date";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
     return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    
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
       
        mainScroller.frame = CGRectMake(0, 0, 1024, 704);
        mainView.frame = CGRectMake(0, 0, 1020, 940);
        titleBgImage.frame = CGRectMake(20, 3, 592, 128);
        selectIndusBgImage.frame = CGRectMake(20, 127, 592, 44);
        tagBgImage.frame = CGRectMake(20, 171, 513, 69);
        websiteBgImage.frame = CGRectMake(20, 239, 592, 74);
        addressBgImage.frame = CGRectMake(20, 388, 592, 103);
        contactBgImage.frame = CGRectMake(20, 489, 592, 103);
        emailBgImage.frame = CGRectMake(20, 313, 592, 74);
        titleLabel.frame = CGRectMake(32, 17, 42, 21);
        nameLabel.frame = CGRectMake(32, 58, 55, 21);
        descLabel.frame = CGRectMake(30, 92, 97, 32);
        titleTextField.frame = CGRectMake(143, 14, 456, 30);
         nameTextField.frame = CGRectMake(143, 54, 456, 30);
         descriptionTextField.frame = CGRectMake(143, 91, 456, 30);
         tagLabel.frame = CGRectMake(32, 186, 44, 39);
         selectIndustryLabel.frame = CGRectMake(30, 129, 569, 36);
         tagTextView.frame = CGRectMake(77, 176, 450, 54);
         tagButton.frame = CGRectMake(535, 171, 77, 70);
         websiteLabel.frame = CGRectMake(30, 253, 65, 39);
         websiteTextView.frame = CGRectMake(95, 243, 411, 66);
         addWebsiteBtn.frame = CGRectMake(498, 285, 106, 23);
         addAddressbtn.frame = CGRectMake(498, 459, 106, 23);
         addContactBtn.frame = CGRectMake(498, 558, 106, 23);
         addEmailBtn.frame = CGRectMake(498, 361, 106, 23);
         addressLabel.frame = CGRectMake(29, 416, 65, 39);
         addressTextView.frame = CGRectMake(94, 394, 407, 87);
         contactLabel.frame = CGRectMake(29, 512, 82, 39);
         contactNoTextView.frame = CGRectMake(119, 491, 382, 92);
         emailLabel.frame = CGRectMake(30, 328, 65, 39);
         emailIdTextView.frame = CGRectMake(97, 317, 404, 63);
         noteScroller.frame = CGRectMake(10, 668,1004, 183);
         goToCamera.frame = CGRectMake(14, 663, 152, 190);
         currntLocBgImage.frame = CGRectMake(20, 591, 592, 74);
         currentLocLabel.frame = CGRectMake(30, 608, 117, 39);
         currentLocationTextView.frame = CGRectMake(155, 600, 438, 55);
         industryTableView.frame = CGRectMake(23, 167, 581, 125);
        
        mainScroller.contentSize = CGSizeMake(1024, 1000);
        mapView.frame = CGRectMake(620, 2, 400, 658);
       
    }
    
    else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
         self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main-bg-768-960.jpg"]];
        
        mainScroller.frame = CGRectMake(13, 20, 742, 940);
        mainView.frame = CGRectMake(0, 0, 742, 940);
        titleBgImage.frame = CGRectMake(20, 12, 702, 128);
        selectIndusBgImage.frame = CGRectMake(20, 149, 702, 44);
        tagBgImage.frame = CGRectMake(20, 196, 613, 69);
        websiteBgImage.frame = CGRectMake(20, 269, 362, 74);
        addressBgImage.frame = CGRectMake(20, 345, 362, 103);
        contactBgImage.frame = CGRectMake(383, 346, 339, 103);
        emailBgImage.frame = CGRectMake(383, 269, 339, 74);
        titleLabel.frame = CGRectMake(32, 26, 42, 21);
        nameLabel.frame = CGRectMake(32, 67, 55, 21);
        descLabel.frame = CGRectMake(30, 101, 97, 32);
        titleTextField.frame = CGRectMake(143, 23, 544, 30);
        nameTextField.frame = CGRectMake(143, 63, 544, 30);
        descriptionTextField.frame = CGRectMake(143, 102, 544, 30);
        tagLabel.frame = CGRectMake(32, 211, 44, 39);
        selectIndustryLabel.frame = CGRectMake(30, 151, 629, 36);
        tagTextView.frame = CGRectMake(77, 201, 549, 54);
        tagButton.frame = CGRectMake(645, 195, 77, 70);
        websiteLabel.frame = CGRectMake(30, 274, 65, 39);
       
        addWebsiteBtn.frame = CGRectMake(269, 312, 106, 23);
        addAddressbtn.frame = CGRectMake(269, 418, 106, 23);
        addContactBtn.frame = CGRectMake(611, 419, 106, 23);
        addEmailBtn.frame = CGRectMake(611, 312, 106, 23);
        addressLabel.frame = CGRectMake(29, 371, 65, 39);
       
        contactLabel.frame = CGRectMake(392, 372, 82, 39);
       
        emailLabel.frame = CGRectMake(391, 274, 65, 39);
      
        noteScroller.frame = CGRectMake(0, 757, 742, 183);
        goToCamera.frame = CGRectMake(7, 752, 152, 190);
        currntLocBgImage.frame = CGRectMake(20, 451, 702, 74);
        currentLocLabel.frame = CGRectMake(30, 469, 117, 39);
        currentLocationTextView.frame = CGRectMake(155, 463, 553, 52);
        industryTableView.frame = CGRectMake(24, 188, 698, 125);
        
        mainScroller.contentSize = CGSizeMake(742, 1000);
         mapView.frame = CGRectMake(23, 526, 698, 227);
        
        tagTextView.frame = CGRectMake(94, 196, 527, 60);
        addressTextView.frame = CGRectMake(103, 351, 259, 70);
        contactNoTextView.frame = CGRectMake(476, 351, 235, 70);
        emailIdTextView.frame = CGRectMake(458, 273, 259, 41);
        websiteTextView.frame = CGRectMake(103, 274, 259, 40);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addWebsite:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    // dataFwdObj.noteTagsArray  = [[NSMutableArray alloc] init];
    [dataFwdObj.noteTagsArray removeAllObjects];
    dataFwdObj.noteTagsArray= WebsiteArray;
    dataFwdObj.fieldCalled= @"addWebsite" ;
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
    //    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:testVC animated:YES completion:nil];
}

- (IBAction)addAddress:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    [dataFwdObj.noteTagsArray removeAllObjects];
    dataFwdObj.noteTagsArray= AddressArray;
    dataFwdObj.fieldCalled= @"addAddress" ;
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
    //    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:testVC animated:YES completion:nil];
}
- (IBAction)addContactNo:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    [dataFwdObj.noteTagsArray removeAllObjects];
    dataFwdObj.noteTagsArray= ContactsArray;
    dataFwdObj.fieldCalled= @"addContactNo" ;
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
    //    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:testVC animated:YES completion:nil];
    
    
}
- (IBAction)addEmail:(UIButton *)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    [dataFwdObj.noteTagsArray removeAllObjects];
    dataFwdObj.noteTagsArray= EmailIDArray;
    dataFwdObj.fieldCalled= @"addEmail" ;
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
    //    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:testVC animated:YES completion:nil];
}




- (void)goToCamera:(id)sender
{
    GlobalClass     *obj = [GlobalClass getInstance];
    obj.vendorid1=vendorid;
    if (obj.vendorid1.length >0) {
        
    }else{
        
        NSLog(@" obj.vendorid1=%@", obj.vendorid1);

    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MM-yyyy hh:mm"];
    
    
    NSString *tempDate = [dateFormat stringFromDate:date];
    
    
    check=1;
    
//    NSString *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_vendor ( vendor_name , user_id , tags , alias , description , website , path , created_date , security_pin , old_security_pin , last_modified_security_pin , geo_latitude , geo_longitude , last_modified_date , is_deleted , delete_date, vendor_title ) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", nameTextField.text, @"1", tagTextView.text, @"", descriptionTextField.text, websiteTextView.text, @"path", tempDate, @"securepin", @"oldpin", @"last_modified_security_pin",@"geolat",@"geolng", @"lastmodified" , @"YES",@"Deletedate", titleTextField.text];
    
    

   NSString   *insertquery = [NSString stringWithFormat:@"INSERT INTO ba_tbl_vendor ( vendor_name , user_id , tags , alias , description , website , path , created_date , security_pin , old_security_pin , last_modified_security_pin , geo_latitude , geo_longitude , last_modified_date , is_deleted , delete_date, email_id , address , contact_no , vendor_title ) VALUES ( \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", nameTextField.text, @"1", tagTextViewString, @"", descriptionTextField.text, websiteTextViewString, @"path", tempDate, @"securepin", @"oldpin", @"last_modified_security_pin",@"geolat",@"geolng", tempDate , @"YES",@"Deletedate",emailIdTextViewString,addressTextViewString,contactNoTextViewString,titleTextField.text ];
    
    NSLog(@"insertquery = %@ ",insertquery);
    
    
    [self saveData:insertquery];
    }
    CameraAudioVideoNote *goToCameraView = [[CameraAudioVideoNote alloc]initWithNibName:@"CameraAudioVideoNote" bundle:nil];
  
    [self.navigationController pushViewController:goToCameraView animated:YES];
}

- (IBAction)tagButton:(id)sender
{
    dataFwdObj=[DataFwdClass getInstance];
    [dataFwdObj.noteTagsArray removeAllObjects];
    dataFwdObj.noteTagsArray= tagsArray;
    dataFwdObj.fieldCalled= @"tagButton" ;
    NSLog(@"dataFwdObj.noteTagsArray 1 %@",dataFwdObj.noteTagsArray);
    
    
    NoteTableViewController *testVC=[[NoteTableViewController alloc]initWithNibName:@"NoteTableViewController" bundle:nil];
    [self.navigationController pushViewController:testVC animated:YES];
    //    testVC.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:testVC animated:YES completion:nil];
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
