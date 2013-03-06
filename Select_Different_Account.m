//
//  Select_Different_Account.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Select_Different_Account.h"
#import "AlertHandler.h"
#import "JSONParser.h"
#import "MainMenu.h"
@implementation Select_Different_Account

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
	
	appdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
   	NSLog(@"%@",appdel.appUserName);
	self.title=[NSString stringWithFormat:@"%@",appdel.appUserName];
				 
	self.navigationItem.hidesBackButton=TRUE;
			
}
-(void)viewWillAppear:(BOOL)animated{
	arrlist=[[NSMutableArray alloc]init];
	arrActId=[[NSMutableArray alloc]init];
	appdel.sign=@"a";
	[self JSONDisplayNames];

	
}


-(void)JSONDisplayNames{
				 [AlertHandler showAlertForProcess];
	NSString *url;
	if(appdel.flag==21){				 
				 
				 
				url=[NSString stringWithFormat:@"%@account_Detalis_userid.php?userid=%@",appdel.strUrl,appdel.appUserId];
	}
	else if(appdel.flag==22){
		
		url=[NSString stringWithFormat:@"%@account_Detalis_userid.php?userid=%@&account_id=%@",appdel.strUrl,appdel.appUserId,appdel.strAccount_id];

	}
	else if(appdel.flag==67){
		url=[NSString stringWithFormat:@"%@account_Detalis_userid.php?userid=%@",appdel.strUrl,appdel.appUserId];

	}

	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
				 
				 
				 
			 }
-(void)searchResult:(NSDictionary*)dictionary{
	//[arrlist removeAllObjects];			 
	[AlertHandler hideAlert];
	
	if([[dictionary valueForKey:@"msg"]isEqualToString:@"No Data Found"])
		{
			
			arrlist=[[[dictionary valueForKey:@"result"]valueForKey:@"name"]copy];

			NSLog(@"arr%@",arrlist);
			//[tblaccount reloadData];
			
			
		}
	else{
		NSLog(@"%@",dictionary);
		arrlist=[[[dictionary valueForKey:@"result"]valueForKey:@"name"]copy];
		arrActId=[[[dictionary valueForKey:@"result"]valueForKey:@"account_id"]copy];
		NSLog(@"%@",arrlist);
		//tblaccount.frame=CGRectMake(0, 0, 320, [arrlist count]*50+20);
		[tblaccount reloadData]; 
		}
				 
				 
				 
	}
			 
- (void)dealloc
{
    [super dealloc];
	//[arrlist release];
	//[arrActId release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)newaccount{
    New_Account *objNew=[[New_Account alloc]initWithNibName:@"New_Account" bundle:nil];
    [self.navigationController pushViewController:objNew animated:YES];
    [objNew release];
    

}
#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    
    return @"Select Account";

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    
    UIImageView *imgView;
    
    UILabel *lblSection;
    lblSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320,20)];
    lblSection.text = @"Select Account";
    lblSection.textColor = [UIColor whiteColor];
    [lblSection setBackgroundColor:[UIColor clearColor]];
    
    
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewAccntHeader.png"]];
    [imgView addSubview:lblSection];
    
    return imgView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrlist count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	  	if([arrlist count]!=0)
		cell.textLabel.text=[arrlist objectAtIndex:indexPath.row];
		
        // Configure the cell.
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

	appdel.actID=[arrActId objectAtIndex:indexPath.row];
	appdel.appActName=[arrlist objectAtIndex:indexPath.row];
	appdel.strAccount_id=[arrActId objectAtIndex:indexPath.row];
	cell.accessoryType=UITableViewCellAccessoryCheckmark;
	
	if(appdel.flag==22){
    Account_Information  *detailViewController = [[Account_Information alloc] initWithNibName:@"Account_Information" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
	}
	else{
			appdel.sign=@"change";
			MainMenu *obj=[[MainMenu alloc]initWithNibName:@"MainMenu" bundle:nil];
			[self.navigationController pushViewController:obj animated:YES];
			[obj release];
		//[self.navigationController popViewControllerAnimated:YES];
				
			
		
	}
	
    
}

#pragma mark - View lifecycle


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
