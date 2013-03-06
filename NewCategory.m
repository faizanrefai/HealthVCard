//
//  NewCategory.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewCategory.h"
#import "JSONParser.h"
#import "AlertHandler.h"
@implementation NewCategory

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
	[lblselect release];
	[txtcate release];
	
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark IBAction
-(IBAction)click{

}
-(IBAction)save{
    [txtcate resignFirstResponder];
	if([txtcate.text isEqualToString:@""])
		{
			
			
			flag=1;
				
				UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Category empty" message:@"Please Enter Category" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
		
			
			
			
	
		}
	else{
		flag=0;
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
		[self JSONBenefit];
	else
		[self JSON];
	}
}
-(void)JSON{
	[AlertHandler showAlertForProcess];
	NSString *txtcate1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtcate.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *url=[NSString stringWithFormat:@"%@add_category.php?title=%@&userid=%@&account_id=%@",objappdel.strUrl,txtcate1,objappdel.appUserId,objappdel.strAccount_id];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
	
}
-(IBAction)Cancel{
	[txtcate resignFirstResponder];
	[self.navigationController popViewControllerAnimated:YES];
	
	
}

-(void)searchResult:(NSDictionary*)dictionary{
    
    
	[AlertHandler hideAlert];
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"Category Inserted Successfully"])
	{
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Category Saved" message:@"Category Created" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else {
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Failed" message:@"Category is Already available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}

	
	
	
}
-(void)JSONBenefit{
	[AlertHandler showAlertForProcess];
	NSString *txtcate1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtcate.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	NSString *url=[NSString stringWithFormat:@"%@add_category_benefits.php?title=%@&userid=%@&account_id=%@",
				   objappdel.strUrl,txtcate1,objappdel.appUserId,objappdel.strAccount_id];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultBenefit:) andHandler:self];
	
	
	
}
-(void)searchResultBenefit:(NSDictionary*)dictionary{
    
    
	[AlertHandler hideAlert];
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"Category Inserted Successfully"])
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Category Saved" message:@"Category Created" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else {
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Failed" message:@"Category is Already available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	
	
	
	
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		if(flag==1)
		{
			
		}
		else	
			[self.navigationController popViewControllerAnimated:YES];
		
	}
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
      // self.title=@"John Smith";
    objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
	NSLog(@"%@",objappdel.appActName);
    self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
	objappdel.sign=@"a";
	
    self.navigationItem.hidesBackButton=TRUE;
	NSLog(@"%@",objappdel.strInfotype);
	lblselect.text=[NSString stringWithFormat:@"%@ Information",objappdel.strInfotype];
    
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
