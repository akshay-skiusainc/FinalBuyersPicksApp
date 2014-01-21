//
//  SecurePin.h
//  Buyer's_Pick_App
//
//  Created by Ashwini Pawar on 15/01/14.
//  Copyright (c) 2014 Ashwini Pawar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurePin : UIViewController
@property (strong, nonatomic) IBOutlet UIView *MainBgView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIImageView *lockImage;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) IBOutlet UIView *createSecurePINView;
@property (strong, nonatomic) IBOutlet UIButton *createSecurePinBtn;
- (IBAction)createSecurePinBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *submitBtnForCreatePin;
- (IBAction)submitBtnForCreatePin:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *enterPinBgImage_Create;
@property (strong, nonatomic) IBOutlet UIImageView *confirmPinBgImage_Create;
@property (strong, nonatomic) IBOutlet UITextField *enterPinTxtFld_Create;
@property (strong, nonatomic) IBOutlet UITextField *confirmPinTxtFld_Create;
@property (strong, nonatomic) IBOutlet UIView *changeAndRemoveBgView;

@property (strong, nonatomic) IBOutlet UIButton *changePinBtn;
- (IBAction)changePinBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *removePinBtn;
- (IBAction)removePinBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *removePinBgView;
@property (strong, nonatomic) IBOutlet UIImageView *enterPinBgImage_Remove;
@property (strong, nonatomic) IBOutlet UITextField *enterPinTxtFld_Remove;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn_Remove;
- (IBAction)submitBtn_Remove:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *changePinbgView;
@property (strong, nonatomic) IBOutlet UIImageView *enterOldPinBgImage_Change;
@property (strong, nonatomic) IBOutlet UITextField *enterOldPinTxtFld_Change;
@property (strong, nonatomic) IBOutlet UIImageView *enterNewPinBgImage_Change;
@property (strong, nonatomic) IBOutlet UITextField *enterNewPinTxtFld_Change;
@property (strong, nonatomic) IBOutlet UIImageView *confirmNewPinBgImage_Change;
@property (strong, nonatomic) IBOutlet UITextField *confirmNewPinTxtFld_Change;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn_Change;
- (IBAction)submitBtn_Change:(id)sender;
@end
