//
//  Medical_Information.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Medical_Information.h"
#import "AlertHandler.h"
#import "JSONParser.h"

@implementation Medical_Information

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    appdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
	arrlist=[[NSMutableArray alloc]init];
	arrMedId=[[NSMutableArray alloc]init];
		
	
	self.title=[NSString stringWithFormat:@"%@",appdel.appActName];
    //arr=[[NSArray alloc]initWithObjects:@"Blood Type",@"Allergies",@"Medications",@"Immunizations",@"Medical History",@"Custom Client Defined Category1",@"Custom Client Defined Category2", nil];
	self.navigationItem.hidesBackButton=TRUE;
	
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
	appdel.strInfotype=@"Medical";
	appdel.sign=@"no";
	[self JSONNames];
	
	
}
-(void)JSONNames{
	[AlertHandler showAlertForProcess];
	
	
	
	
	NSString *url=[NSString stringWithFormat:@"%@Medical_category_list.php?account_id=%@",appdel.strUrl,appdel.strAccount_id];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
	
}
-(void)searchResult:(NSDictionary*)dictionary{
	//[arrlist removeAllObjects];			 
	[AlertHandler hideAlert];
	
	
		NSLog(@"%@",dictionary);
	
		arrlist=[[[dictionary valueForKey:@"Medical_category"]valueForKey:@"title"]copy];
		arrMedId=[[[dictionary valueForKey:@"Medical_category"]valueForKey:@"cid"]copy];
			
		
		[tblmedical reloadData]; 
	
	
	
	
}
#pragma mark tableView
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
	//NSLog(@"%d",[arrlist count]);
	if(![arrlist count]==0){
		
		
		
			cell.textLabel.text=[arrlist objectAtIndex:indexPath.row];
		

	}
       // Configure the cell.
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    NSLog(@"index path  %d",indexPath.row);
    Category_Detail  *detailViewController = [[Category_Detail alloc] initWithNibName:@"Category_Detail" bundle:nil];
	appdel.strselect=@"detail";
    appdel.strcategory=[arrlist objectAtIndex:indexPath.row];
	appdel.actID=[arrMedId objectAtIndex:indexPath.row];
	NSLog(@"%@",appdel.actID);
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIImageView *imgView;
    
    UILabel *lblSection;
    lblSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320 , 20)];
    lblSection.text = @"Medicinal Information";
    lblSection.textColor = [UIColor whiteColor];
    [lblSection setBackgroundColor:[UIColor clearColor]];
    
    
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewAccntHeader.png"]];
    [imgView addSubview:lblSection];
    
    return imgView;
}
#pragma mark IBAction
-(IBAction)NewCategory{
	
	appdel.strselect=@"new";
    NewCategory *objNew=[[NewCategory alloc]initWithNibName:@"NewCategory" bundle:nil];
    [self.navigationController pushViewController:objNew animated:YES];
    [objNew release];
    
	
}


- (void)dealloc
{
    [super dealloc];
	if(arrlist!=nil){
		
		arrlist=nil;
		[arrlist release];
		
	}
	if(arrMedId!=nil){
		
		arrMedId=nil;
		[arrMedId release];
		
	}
	if(arrMedId!=nil){
		
		arrMedId=nil;
		[arrMedId release];
		
	}
	[tblmedical release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
