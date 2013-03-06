//
//  Login.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "HealthVCardAppDelegate.h"
@interface Login : UIViewController <UIAlertViewDelegate,UITextFieldDelegate>{
    
    IBOutlet UITextField *txtName;
    
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtEmail;
	IBOutlet UIButton *btnEmail;
	IBOutlet UIButton *btnLogin;
    CGFloat animatedDistance;
    HealthVCardAppDelegate *objappdel;
	NSTimer *timer;
	int count;
	
    
}
-(IBAction)click;

-(IBAction)Login:(id)sender;

-(IBAction)Registration:(id)sender;
-(void)JSON;
- (void) startTimer;
-(IBAction)Email:(id)sender;
@end
