//
//  Emergency_Contacts.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Emergency_Contacts.h"
#import "JSONParser.h"
#import "AlertHandler.h"

@implementation Emergency_Contacts

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)JSONNames{
	[AlertHandler showAlertForProcess];
	
	
	
	
	NSString *url=[NSString stringWithFormat:@"%@emergancy_contact_list.php?account_id=%@&userid=%@",objappdel.strUrl,objappdel.strAccount_id,objappdel.appUserId];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
	
}
-(void)searchResult:(NSDictionary*)dictionary{
			 
	[AlertHandler hideAlert];
	
	
	NSLog(@"%@",dictionary);
	arrlist=[[[dictionary valueForKey:@"emergancy_contact"]valueForKey:@"Name"]copy];
	arrEid=[[[dictionary valueForKey:@"emergancy_contact"]valueForKey:@"eid"]copy];
	NSLog(@"%@",arrlist);
	[tblcontact reloadData]; 
	
	
	
	
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIImageView *imgView;
    
    UILabel *lblSection;
    lblSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320 , 20)];
    lblSection.text = @"Emergency Contacts";
    lblSection.textColor = [UIColor whiteColor];
    [lblSection setBackgroundColor:[UIColor clearColor]];
    
    
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewAccntHeader.png"]];
    [imgView addSubview:lblSection];
    
    return imgView;
}


-(IBAction)newcontact{
    Contact_Detail *obj=[[Contact_Detail alloc]initWithNibName:@"Contact_Detail" bundle:nil];
    objappdel.strselect=@"New";
    
    objappdel.flag=1;
    
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    
    cell.textLabel.text=[arrlist objectAtIndex:indexPath.row];
	
            
        
    
    
    
    // Configure the cell.
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objappdel.flag=16;
    Contact_Detail *obj=[[Contact_Detail alloc]initWithNibName:@"Contact_Detail" bundle:nil];
    objappdel.strselect=@"Detail";
    
    objappdel.actID=[arrEid objectAtIndex:indexPath.row];
    objappdel.appStrSubTitle=[arrlist objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];
    
}



- (void)dealloc
{
    [super dealloc];
	if(arrlist!=nil)
	{
		arrlist=nil;
		[arrlist release];
		
	}
	if(arrEid!=nil)
	{
		arrEid=nil;
		[arrEid release];
		
	}
	[tblcontact release];
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
  
//       self.title=@"John Smith";
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
	
	
	arrEid=[[NSMutableArray alloc ]init];
	arrlist=[[NSMutableArray alloc ]init];
	objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
	self.navigationItem.hidesBackButton=TRUE;
    self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
	objappdel.sign=@"no";
	[self JSONNames];
	
	
	
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
