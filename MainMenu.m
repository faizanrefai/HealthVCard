//
//  MainMenu.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "Select_Different_Account.h"
#import "Bottom_View.h"
#import "AlertHandler.h"
#import "JSONParser.h"
@implementation MainMenu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
	//[btnchange release];
	//[btnhome release];
	//[btnlogut release];
	//[BtnPre release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

    return [arrInfo count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    static NSString *cellIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [arrInfo objectAtIndex:indexPath.row];
    return  cell;
    

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

   NSLog(@"%@",objappdel.strAccount_id);
    switch (indexPath.row) 
    {
        case 0:
            objappdel.flag=21;
            selAccnt=[[Select_Different_Account alloc]initWithNibName:@"Select_Different_Account" bundle:nil];
            
            [self.navigationController pushViewController:selAccnt animated:YES];
          //  [selAccnt release];
            
                        
            break;
		case 1:
            objappdel.flag=22;
			if(!objappdel.strAccount_id){
				
				
				
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
															  message:@"Please Select an Account" 
															 delegate:self 
													cancelButtonTitle:nil 
													otherButtonTitles:@"OK",nil];
				[alert show];
				[alert release];
				
			}
			else{
            selAccnt=[[Account_Information alloc]initWithNibName:@"Account_Information" bundle:nil];
            
            [self.navigationController pushViewController:selAccnt animated:YES];
           // [selAccnt release];
            
			}
            break;

        case 2:
            if(!objappdel.strAccount_id){
				
				
				
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
															  message:@"Please Select an Account" 
															 delegate:self 
													cancelButtonTitle:nil 
													otherButtonTitles:@"OK",nil];
				[alert show];
				[alert release];
				
			}else{
            mediInfo = [[Medical_Information alloc] initWithNibName:@"Medical_Information" bundle:nil];
            
            [self.navigationController pushViewController:mediInfo animated:YES];
            [mediInfo release];
	}
            break;

        case 3:
            if(!objappdel.strAccount_id){
				
				
				
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
															  message:@"Please Select an Account" 
															 delegate:self 
													cancelButtonTitle:nil 
													otherButtonTitles:@"OK",nil];
				[alert show];
				[alert release];
				
			}else{
            beniInfo = [[Benefits_Information alloc] initWithNibName:@"Benefits_Information" bundle:nil];
            
            [self.navigationController pushViewController:beniInfo animated:YES];
            [beniInfo release];
            }
            break;

        case 4:
            if(!objappdel.strAccount_id){
				
				
				
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
															  message:@"Please Select an Account" 
															 delegate:self 
													cancelButtonTitle:nil 
													otherButtonTitles:@"OK",nil];
				[alert show];
				[alert release];
				
			}else{
            emgCont = [[Emergency_Contacts alloc] initWithNibName:@"Emergency_Contacts" bundle:nil];
            
            [self.navigationController pushViewController:emgCont animated:YES];
            [emgCont release];
            }
            break;

        case 5:
            if(!objappdel.strAccount_id){
				
				
				
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
															  message:@"Please Select an Account" 
															 delegate:self 
													cancelButtonTitle:nil 
													otherButtonTitles:@"OK",nil];
				[alert show];
				[alert release];
				
			}
			else{
            impAdd = [[ImportantAddresses alloc] initWithNibName:@"ImportantAddresses" bundle:nil];
            
            
            [self.navigationController pushViewController:impAdd animated:YES];
            [impAdd release];
            }
            break;

        case 6:
            if(!objappdel.strAccount_id){
				
				
				
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
															  message:@"Please Select an Account" 
															 delegate:self 
													cancelButtonTitle:nil 
													otherButtonTitles:@"OK",nil];
				[alert show];
				[alert release];
				
			}else{
            app = [[Appointments alloc] initWithNibName:@"Appointments" bundle:nil];
            
            [self.navigationController pushViewController:app animated:YES];
            [app release];
			} 
            
            break;

            
        default:
            break;
    }

}
#pragma mark AlertHandler
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0)
	{
		if(flag1==1){
			
			
		[self.navigationController popToRootViewControllerAnimated:YES];
			flag1=0;
			
		}
		
	}
	else {
		
	}

}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    objappdel.toolbar.hidden=FALSE;
    objappdel.flag=2;
	objappdel.sign=@"hi";
	
	//UIBarButtonItem *barBtnLogout = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStyleBordered target:self action:@selector(Logout)];
//	
//	self.navigationItem.rightBarButtonItem = barBtnLogout;
//	self.navigationItem.rightBarButtonItem.enabled =TRUE;
//	
//	UIBarButtonItem *barBtnLogIn = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(Home)];
//	
//	self.navigationItem.leftBarButtonItem = barBtnLogIn;
//	self.navigationItem.leftBarButtonItem.hidden =TRUE;
    
	if(!objappdel.appActName)
	{
		self.title=[NSString stringWithFormat:@"%@",objappdel.appUserName];
	}
	else {
		self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
	}
	
	self.navigationItem.hidesBackButton=YES;
	
	BtnPre = [UIButton buttonWithType:UIButtonTypeCustom];
	
	
	[BtnPre addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [BtnPre setBackgroundImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
	
	[BtnPre setTitle:@"Back" forState:UIControlStateNormal];
		
	BtnPre.frame = CGRectMake(20,10,30,20);
      
	[objappdel.toolbar addSubview:BtnPre];

    
    btnhome = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnhome addTarget:self action:@selector(Home) forControlEvents:UIControlEventTouchUpInside];
    
    [btnhome setBackgroundImage:[UIImage imageNamed:@"Home.png"] forState:UIControlStateNormal];
	
	[btnhome setTitle:@"Home" forState:UIControlStateNormal];
    
	btnhome.frame = CGRectMake(100,10,30,20);
    
	[objappdel.toolbar addSubview:btnhome];

    btnlogut = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnlogut addTarget:self action:@selector(Logout) forControlEvents:UIControlEventTouchUpInside];
    [btnlogut setBackgroundImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
	
	[btnlogut setTitle:@"Logout" forState:UIControlStateNormal];
    
	btnlogut.frame = CGRectMake(260,10,20,20);
    
	[objappdel.toolbar addSubview:btnlogut];
     
    
    btnchange = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnchange addTarget:self action:@selector(ChangeAccount) forControlEvents:UIControlEventTouchUpInside];
    
    [btnchange setBackgroundImage:[UIImage imageNamed:@"ChangeAccnt.png"] forState:UIControlStateNormal];
	
	[btnchange setTitle:@"ChangeAccount" forState:UIControlStateNormal];
    [btnchange sizeToFit];
    
	btnchange.frame = CGRectMake(180,10,30,20);
    
	[objappdel.toolbar addSubview:btnchange];
	
	

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
		//[self JSON];
    
    arrInfo = [[NSArray alloc] initWithObjects:@"Select Account",@"Account Information",@"Medical Information",@"Benefits Information",@"Emergency Contacts",@"Important Address",@"Appointments", nil];
   //self.navigationController.navigationBarHidden=TRUE;
  	
   
      
 

}
#pragma mark IBAction
-(IBAction)Account_Information{
    Select_Different_Account *objAcc=[[Select_Different_Account alloc]initWithNibName:@"Select_Different_Account" bundle:nil];
    objappdel.sign=@"a";
    
    [self.navigationController pushViewController:objAcc animated:YES];
    [objAcc release];
    
}
-(IBAction)Medical_Information{
    Medical_Information *objmedi=[[Medical_Information alloc]initWithNibName:@"Medical_Information" bundle:nil];
    objappdel.sign=@"a";
    objappdel.strselect=@"Medical Information";
    
    [self.navigationController pushViewController:objmedi animated:YES];
    [objmedi release];
    
}
-(IBAction)Benefits_Information{
    Benefits_Information *objmedi=[[Benefits_Information alloc]initWithNibName:@"Benefits_Information" bundle:nil];
    objappdel.sign=@"a";
    objappdel.strselect=@"Benefits Information";
    
    [self.navigationController pushViewController:objmedi animated:YES];
    [objmedi release];

}
-(IBAction)Emergency_Contacts{
 


    Emergency_Contacts *objmedi=[[Emergency_Contacts alloc]initWithNibName:@"Emergency_Contacts" bundle:nil];
    
    objappdel.sign=@"a";
    [self.navigationController pushViewController:objmedi animated:YES];
    [objmedi release];

}
-(IBAction)Important_Addresses{
    ImportantAddresses *objmedi=[[ImportantAddresses alloc]initWithNibName:@"ImportantAddresses" bundle:nil];
    
    objappdel.sign=@"a";
    [self.navigationController pushViewController:objmedi animated:YES];
    [objmedi release];
}
-(IBAction)Appointments{
    Appointments *objmedi=[[Appointments alloc]initWithNibName:@"Appointments" bundle:nil];
    
    objappdel.sign=@"a";
    [self.navigationController pushViewController:objmedi animated:YES];
    [objmedi release];
}
-(IBAction)back{
    flag=FALSE;
	if([objappdel.sign isEqualToString:@"hi"])
	{
		[self Logout];
		
	}else{
    [self.navigationController popViewControllerAnimated:YES];
	}
    
}


-(IBAction)ChangeAccount{
    

        if (selAccnt!=nil) {
			selAccnt=nil;
			[selAccnt release];
		}
		objappdel.flag=67;
		selAccnt=[[Select_Different_Account alloc]initWithNibName:@"Select_Different_Account" bundle:nil];
        
        
        [self.navigationController pushViewController:selAccnt animated:YES];
        //[selAccnt release];
       
    
    
}



-(IBAction)Home{
   
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
  
    
    
}
-(IBAction)Logout{
	flag1=1;
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Logout"
												  message:@"Please confirm you want to log out of Health vCard" 
												 delegate:self 
										cancelButtonTitle:nil
										otherButtonTitles:@"Logout",@"Cancel",nil];
	[alert show];
	[alert release];
	
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
