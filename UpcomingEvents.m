//
//  UpcomingEvents.m
//  HealthVCard
//
//  Created by girish on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UpcomingEvents.h"
#import "AppointmentDetail.h"
#import "AppointmentDetailMore.h"
@implementation UpcomingEvents

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	   appdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	self.navigationItem.hidesBackButton=TRUE;
	
	
	
}
-(void)viewWillAppear:(BOOL)animated{
	
	newArr=[[NSMutableArray alloc]init];
	 self.title=[NSString stringWithFormat:@"%@",appdel.appActName];
	appdel.sign=@"a";
	newArr=[self sortByStringDate:appdel.arrSort];
	if(reverseArray!=nil){
		reverseArray=nil;
		[reverseArray release];
		
	}
	reverseArray = [NSMutableArray arrayWithCapacity:[newArr count]];; 
	
	for (id element in [newArr reverseObjectEnumerator]) {
		[reverseArray addObject:element];
		
	}
	[reverseArray retain];
		
	NSLog(@"reverseed array is %@",reverseArray);

	[tblEvent reloadData];
	

		
}
-(NSMutableArray *)sortByStringDate:(NSMutableArray *)unshortedArray
{
    NSMutableArray *tempArray=[NSMutableArray array];
    for(int i=0;i<[unshortedArray count];i++)
    {
		NSString *objModel;
        NSDateFormatter *df=[[NSDateFormatter alloc]init];
		NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
		[df setDateFormat:@"yyyy-MM-dd"];
		[df setTimeZone:gmt];
		
		objModel=[unshortedArray objectAtIndex:i];
		
        [df setDateFormat:@"yyyy-MM-dd"];
        NSDate *date=[df dateFromString:objModel];
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:objModel forKey:@"entity"];
        [dict setObject:date forKey:@"date"];
        [tempArray addObject:dict];
		NSLog(@"%@",dict);
    }
	
    NSInteger counter=[tempArray count];
    NSDate *compareDate;
    NSInteger index;
    for(int i=0;i<counter;i++)
    {
        index=i;
        compareDate=[[tempArray objectAtIndex:i] valueForKey:@"date"];
        NSDate *compareDateSecond;
        for(int j=i+1;j<counter;j++)
        {
            compareDateSecond=[[tempArray objectAtIndex:j] valueForKey:@"date"];
            NSComparisonResult result = [compareDate compare:compareDateSecond];
			if(result == NSOrderedAscending)
			{
				compareDate=compareDateSecond;
				index=j;
			}
        }
        if(i!=index)
			[tempArray exchangeObjectAtIndex:i withObjectAtIndex:index];
    }
	
	
    [unshortedArray removeAllObjects];
    for(int i=0;i<[tempArray count];i++)
    {
        [unshortedArray addObject:[[tempArray objectAtIndex:i] valueForKey:@"entity"]];
    }
    return unshortedArray;
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if([reverseArray count]==0){
		
		return 1;
		
	}
	else
    return [reverseArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	NSLog(@"%@",reverseArray);
	if([reverseArray count]==0){
		
		cell.textLabel.text=@"No Upcoming events";
		
	}
	else
		cell.textLabel.text=[reverseArray objectAtIndex:indexPath.row];   
   // cell.textLabel.text=[NSString stringWithFormat:@"%@-%@",[arrtitle objectAtIndex:indexPath.row],[startTime objectAtIndex:indexPath.row] ];    
    
    // Configure the cell.
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentDetail *objappo=[[AppointmentDetail alloc]initWithNibName:@"AppointmentDetail" bundle:nil];
    appdel.flag=19;
    appdel.strselect=@"Detail";
	
	//appdel.appStrSubTitle=[arrtitle objectAtIndex:indexPath.row];
	if([reverseArray count]==0){
		
		
	}
	else{
	appdel.strdate=[reverseArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:objappo animated:YES];
    [objappo release];
    }
	
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIImageView *imgView;
    
    UILabel *lblSection;
    lblSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320 , 20)];
    lblSection.text = [NSString stringWithFormat:@"Upcoming Events"];
   lblSection.textColor = [UIColor whiteColor];
    [lblSection setBackgroundColor:[UIColor clearColor]];
    
    
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewAccntHeader.png"]];
    [imgView addSubview:lblSection];
    
    return imgView;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
}


@end
