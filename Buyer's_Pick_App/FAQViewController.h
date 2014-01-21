//
//  FAQViewController.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 17/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString *dataForSection[1000];
}
@property (nonatomic,retain)UILabel *placeHolderTitle;
@property (retain, nonatomic) IBOutlet UITableView *faqTable;
@property (retain, nonatomic) NSString *dataForSection0;
@property (retain, nonatomic) NSString *dataForSection2;
@property (retain, nonatomic) NSMutableArray *demoData;
@property (retain, nonatomic) NSMutableArray *ansArray;
@property (nonatomic) int selectedValueIndex;
@property (nonatomic) bool isShowingList;
@end
