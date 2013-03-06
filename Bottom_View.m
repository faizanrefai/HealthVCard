//
//  Bottom_View.m
//  HealthVCard
//
//  Created by apple on 9/15/11.
//  Copyright 2011 354456. All rights reserved.
//

#import "Bottom_View.h"
#import "Select_Different_Account.h"
#import "Login.h"
@implementation Bottom_View

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
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)Home{
      [self.navigationController popToRootViewControllerAnimated:YES];
   
}
-(IBAction)Logout{

    Login *obj=[[Login alloc]initWithNibName:@"Login" bundle:nil];
    [self.navigationController popToViewController:obj animated:YES];
    [obj release];
    
}
-(IBAction)ChangeAccount{
    Select_Different_Account *obj=[[Select_Different_Account alloc]initWithNibName:@"Select_Different_Account" bundle:nil];
    [self.navigationController popToViewController:obj animated:YES];
    [obj release];
    


}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
