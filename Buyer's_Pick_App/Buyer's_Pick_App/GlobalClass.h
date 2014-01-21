//
//  GlobalClass.h
//  Dabaang2Application
//
//  Created by Javed Sunesra on 11/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalClass : NSObject

@property(strong,nonatomic)NSString* fetchall;
@property(strong,nonatomic)NSString* vendorid1;


+(GlobalClass*)getInstance; 
//+(GlobalClass *)getCheck;

@end
