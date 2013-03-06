//
//  Benefits_Information.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Benefits_Information.h"
#import "AlertHandler.h"
#import "JSONParser.h"

@implementation Benefits_Information

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated{
	arrBenID=[[NSMutableArray alloc ]init];
	arrlist=[[NSMutableArray alloc ]init];
	objappdel.strInfotype=@"Benefits";
	objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	objappdel.sign=@"no";
	[self JSONNames];
	
	
}
-(void)JSONNames{
	[AlertHandler showAlertForProcess];
	
	
	
	
	NSString *url=[NSString stringWithFormat:@"%@Benefits_category_list.php?account_id=%@",objappdel.strUrl,objappdel.strAccount_id];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
	
}
-(void)searchResult:(NSDictionary*)dictionary{
	//[arrlist removeAllObjects];			 
	[AlertHandler hideAlert];
	
	
	NSLog(@"%@",dictionary);
	arrlist=[[[dictionary valueForKey:@"category_benefits"]valueForKey:@"title"]copy];
	arrBenID=[[[dictionary valueForKey:@"category_benefits"]valueForKey:@"cbid"]copy];
	NSLog(@"%@",arrlist);
	[tblbenefits reloadData]; 
	
	
	
	
}

- (void)dealloc
{
    [super dealloc];
	[tblbenefits release];
	if(arrlist!=nil){
		arrlist=nil;
		[arrlist release];
		
		
	}
	if(arrBenID!=nil){
		arrBenID=nil;
		[arrBenID release];
		
		
	}
	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(IBAction)New_Benefits{
	objappdel.flag=10;
    NewCategory *objNew=[[NewCategory alloc]initWithNibName:@"NewCategory" bundle:nil];
    [self.navigationController pushViewController:objNew animated:YES];
    [objNew release];
    

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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIImageView *imgView;
    
    UILabel *lblSection;
    lblSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320 , 20)];
    lblSection.text = @"Benefits Information";
    lblSection.textColor = [UIColor whiteColor];
    [lblSection setBackgroundColor:[UIColor clearColor]];
    
    
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewAccntHeader.png"]];
    [imgView addSubview:lblSection];
    
    return imgView;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   objappdel.strInfotype=@"Benefits";
	objappdel.flag=11;
    Category_Detail  *detailViewController = [[Category_Detail alloc] initWithNibName:@"Category_Detail" bundle:nil];
    objappdel.strcategory=[arrlist objectAtIndex:indexPath.row];
    objappdel.actID=[arrBenID objectAtIndex:indexPath.row];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
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
    objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
     self.navigationItem.hidesBackButton=TRUE;
       
   self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];;
    // Do any additional setup after loading the view from its nib.
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
