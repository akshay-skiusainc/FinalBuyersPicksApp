//
//  HomeViewController.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 12/12/13.
//  Copyright (c) 2013 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"

@interface HomeViewController : DatabaseClass<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UISplitViewControllerDelegate,UIScrollViewDelegate>


{
    UIButton *vendorImage[5000];
    UIButton *createVendor;
    UIButton *tickmarkButtonlist[5000];
    UIButton *tickmarkButtonlistLand[5000];
    UIButton *tickmarkButtonGrid[5000];
    UIButton *tickmarkButtonGridLand[5000];
    UIImageView *lineImage[5000];
    UIView *viewForList[5000];
    UILabel *vendorName[5000];
    UILabel *vendorTitle[5000];
    UILabel *vendorDate[5000];
    UILabel *vendorDetails[5000];

    
    UIButton *vendorImageLand[5000];
    UIButton *createVendorLand;
   
    UIImageView *lineImageLand[5000];
    UIView *viewForListLand[5000];
    UILabel *vendorNameLand[5000];
    UILabel *vendorTitleLand[5000];
    UILabel *vendorDateLand[5000];
    UILabel *vendorDetailsLand[5000];
    UIImageView *imageOnVendorGrid[5000];
    UIImageView *imageOnVendorList[5000];
}
@property (strong, nonatomic) IBOutlet UIButton *offEditModeBtn;
@property (strong, nonatomic) IBOutlet UIButton *offEditModeBtnLand;

- (IBAction)offEditModeBtn:(id)sender;
@property(nonatomic, strong) UIPopoverController *masterPopoverController;
@property (nonatomic,retain)NSMutableArray *dateForListTableViewHeader;
@property (nonatomic)int navBarButtonsIndex;
@property (nonatomic)int totalVendors;
@property (nonatomic)int INDEX;
@property (nonatomic)int listAndGridIndex;
@property (nonatomic,retain)NSMutableArray *deleteItems;

@property (nonatomic,retain)NSArray *sortedArray;
@property (strong, nonatomic) IBOutlet UIView *pView;
@property (strong, nonatomic) IBOutlet UIView *lView;
@property (strong, nonatomic) IBOutlet UIButton *listView;
@property (strong, nonatomic) IBOutlet UIButton *gridView;
@property (strong, nonatomic) IBOutlet UIButton *sortByDate;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *allVendorsButton;
@property (strong, nonatomic) IBOutlet UIButton *syncButton;
@property (strong, nonatomic) IBOutlet UIScrollView *vendorScroller;
@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (strong, nonatomic) IBOutlet UIImageView *tableViewBgImage;
@property (strong, nonatomic) IBOutlet UITableView *sortingTable;
@property (strong, nonatomic) IBOutlet UIButton *deleteVendorButton;
@property (strong, nonatomic) IBOutlet UIButton *shareVendorButton;
@property (strong, nonatomic) IBOutlet UITableView *listViewTable;
- (IBAction)createNewVendorButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *createNewVendorLabel;
@property (strong, nonatomic) IBOutlet UIButton *createNEwVendorButton;
@property (strong, nonatomic) IBOutlet UIView *createVendorBgView;


//landcsape
@property (strong, nonatomic) IBOutlet UIButton *listViewLand;
@property (strong, nonatomic) IBOutlet UIButton *gridViewLand;
@property (strong, nonatomic) IBOutlet UIButton *sortByDateLand;
@property (strong, nonatomic) IBOutlet UIButton *shareButtonLand;
@property (strong, nonatomic) IBOutlet UIButton *allVendorsButtonLand;
@property (strong, nonatomic) IBOutlet UIButton *syncButtonLand;
@property (strong, nonatomic) IBOutlet UIScrollView *vendorScrollerLand;
@property (strong, nonatomic) IBOutlet UIImageView *tableViewBgImageLand;
@property (strong, nonatomic) IBOutlet UITableView *sortingTableLand;
@property (strong, nonatomic) IBOutlet UIButton *deleteVendorButtonLand;
@property (strong, nonatomic) IBOutlet UIButton *shareVendorButtonLand;
@property (strong, nonatomic) IBOutlet UILabel *createNewVendorLabelLand;
@property (strong, nonatomic) IBOutlet UIButton *createNEwVendorButtonLand;
@property (strong, nonatomic) IBOutlet UIView *createVendorBgViewLand;

- (IBAction)sortByDate:(id)sender;
- (IBAction)displayGridView:(id)sender;
- (IBAction)displayListView:(id)sender;
- (IBAction)syncButton:(id)sender;
- (IBAction)allVendorsButton:(id)sender;
- (IBAction)sharedButton:(id)sender;
- (IBAction)deleteVendorButton:(id)sender;
- (IBAction)shareVendorButton:(id)sender;
@end
