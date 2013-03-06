//
//  AppointmentDetail.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppointmentDetail.h"
#import "AlertHandler.h"
#import "JSONParser.h"

@implementation AppointmentDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
	arrApid=[[NSMutableArray alloc]init];
	arrtitle=[[NSMutableArray alloc]init];
	startTime=[[NSMutableArray alloc]init];
	sorted=[[NSMutableArray alloc]init];
	arrDict=[[NSMutableArray alloc]init];
	appdel.sign=@"a";;
	[self JSONDisplayApt];	
}
-(void)JSONDisplayApt{
	[AlertHandler showAlertForProcess];
	
	NSString *url;
	
	url=[NSString stringWithFormat:@"%@appointment_list.php?userid=%@&Date=%@&account_id=%@",
		 appdel.strUrl,appdel.appUserId,appdel.strdate,appdel.strAccount_id];
	
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult1:) andHandler:self];
	
	
}
-(void)searchResult1:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	arrDict=(NSMutableArray *)[dictionary valueForKey:@"Appointments"];
	[arrDict retain];
	NSLog(@"array of dic is%@",arrDict);
	
	
	
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"No data Found"])
	{
		[tblcontact reloadData];
		
	}
	else{
		arrtitle=[[[dictionary valueForKey:@"Appointments"]valueForKey:@"Title"]copy];
		arrApid=[[[dictionary valueForKey:@"Appointments"]valueForKey:@"app_id"]copy];
		startTime=[[dictionary valueForKey:@"Appointments"]valueForKey:@"Start_time"];
		for(int i=0;i<[startTime count];i++){
            
            if([[startTime objectAtIndex:i]isEqualToString:@""])
            {
                [startTime removeLastObject];
            }
        }
		sorted=[self sortByStringDate:startTime];
		[tblcontact reloadData];
	}
	
}
-(NSMutableArray *)sortByStringDate:(NSMutableArray *)unshortedArray
{
    NSMutableArray *tempArray=[NSMutableArray array];
    for(int i=0;i<[unshortedArray count];i++)
    {
		NSString *objModel;
        NSDateFormatter *df=[[NSDateFormatter alloc]init];
		NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
		[df setDateFormat:@"h:mm a"];
		[df setTimeZone:gmt];
		
		objModel=[unshortedArray objectAtIndex:i];
		
        [df setDateFormat:@"h:mm a"];
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
	
	
    //[unshortedArray removeAllObjects];
	unshortedArray=[[NSMutableArray alloc]init];
	
    for(int i=[tempArray count]-1;i>=0;i--)
    {
		
        [unshortedArray addObject:[[tempArray objectAtIndex:i] valueForKey:@"entity"]];
		}
	NSLog(@"%@",unshortedArray);
    return unshortedArray;
	
}

#pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrtitle count];
}
-(IBAction)NewAppo{

    AppointmentDetailMore *objappo=[[AppointmentDetailMore alloc]initWithNibName:@"AppointmentDetailMore" bundle:nil];
    
    appdel.strselect=@"New";
    
    [self.navigationController pushViewController:objappo animated:YES];
    [objappo release];
    
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSLog(@"%@",arrtitle);
	for(int i=0;i<[arrtitle count];i++){{
				if([[sorted objectAtIndex:indexPath.row] isEqualToString:[[arrDict valueForKey:@"Start_time"]objectAtIndex:i]])
				cell.textLabel.text=[NSString stringWithFormat:@"%@-%@",[[arrDict valueForKey:@"Title"]objectAtIndex:i],[sorted objectAtIndex:indexPath.row] ];    
    }}
    // Configure the cell.
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentDetailMore *objappo=[[AppointmentDetailMore alloc]initWithNibName:@"AppointmentDetailMore" bundle:nil];
    appdel.flag=19;
    appdel.strselect=@"Detail";
//	appdel.appStrSubTitle=[objectAtIndex:indexPath.row];
	NSString *temp=[sorted objectAtIndex:indexPath.row];
	NSLog(@"%@",temp);
	for(int i=0;i<[sorted count];i++){
		
		if([[sorted objectAtIndex:indexPath.row] isEqualToString:[[arrDict valueForKey:@"Start_time"]objectAtIndex:i]])
			
			
			appdel.actID=[[arrDict valueForKey:@"app_id"] objectAtIndex:i];
		
		
	}
    [self.navigationController pushViewController:objappo animated:YES];
    [objappo release];
    

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIImageView *imgView;
    
    UILabel *lblSection;
    lblSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320 , 20)];
    lblSection.text = [NSString stringWithFormat:@"Appointments %@",appdel.strdate];
    lblSection.textColor = [UIColor whiteColor];
    [lblSection setBackgroundColor:[UIColor clearColor]];
    
    
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewAccntHeader.png"]];
    [imgView addSubview:lblSection];
    
    return imgView;
}



- (void)dealloc
{
    [super dealloc];
	if(arrApid!=nil)
	{
		arrApid=nil;
		[arrApid release];
		
	}
	if(arrtitle!=nil)
	{
		arrtitle=nil;
		[arrtitle release];
		
	}
	if(startTime!=nil)
	{
		startTime=nil;
		[startTime release];
		
	}
	[lbldate release];
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
       //self.title=@"John Smith";
    appdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.title=[NSString stringWithFormat:@"%@",appdel.appActName];

     self.navigationItem.hidesBackButton=TRUE;
    lbldate.text=appdel.strdate;
    
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
