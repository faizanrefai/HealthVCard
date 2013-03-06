//
//  MainMenu.h
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "Select_Different_Account.h"

@interface MainMenu : UIViewController<UITableViewDataSource,UITableViewDelegate> 
{

    HealthVCardAppDelegate *objappdel; 
    
    Select_Different_Account *selAccnt;
    Medical_Information *mediInfo;
    Benefits_Information *beniInfo;
    Emergency_Contacts *emgCont;
    ImportantAddresses *impAdd;
    Appointments *app;
    
    NSArray *arrInfo;
    IBOutlet UIButton *BtnPre;
    IBOutlet UIButton *btnhome;
    IBOutlet UIButton *btnlogut;
    IBOutlet UIButton *btnchange;
    BOOL flag;
    int flag1;
}
-(void)JSON;
-(IBAction)Home;
-(IBAction)Logout;
-(IBAction)Account_Information;
-(IBAction)Medical_Information;
-(IBAction)Benefits_Information;
-(IBAction)Emergency_Contacts;
-(IBAction)Important_Addresses;
-(IBAction)Appointments;
-(IBAction)back;



-(IBAction)ChangeAccount;


@end
