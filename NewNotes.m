//
//  NewNotes.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewNotes.h"
#import "JSONParser.h"
#import "AlertHandler.h"
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
@implementation NewNotes

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)Save{
    [txttitle resignFirstResponder];
    [txtnote resignFirstResponder];
	if([txttitle.text isEqualToString:@""] || [txtnote.text isEqualToString:@""])
	{
		 flag=0;
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please Enter All Feilds" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
		
	}
	else{
		 flag=1;
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
		[self JSONBenefit];
	else
	[self JSON];
	
	}
}

-(IBAction)cancel{
    [txttitle resignFirstResponder];
    [txtnote resignFirstResponder];
	[self.navigationController popViewControllerAnimated:YES];
	
}
-(void)JSON{
	[AlertHandler showAlertForProcess];
	

	NSString *txttitle1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txttitle.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtnote1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtnote.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);

	
	NSString *url=[NSString stringWithFormat:@"%@add_note.php?title=%@&note=%@&userid=%@&cid=%@&account_id=%@",
				   objappdel.strUrl,txttitle1,txtnote1,objappdel.appUserId,objappdel.actID,objappdel.strAccount_id];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
	
}
-(void)searchResult:(NSDictionary*)dictionary{
    
    [AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"Record Inserted Successfully"])
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Notes Saved" message:@"New Note Created" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else {
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Failed" message:@"Note is Already available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	
	
	
	
}
-(void)JSONBenefit{
	[AlertHandler showAlertForProcess];
	
	
	NSString *txttitle1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txttitle.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtnote1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtnote.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	
	
	NSString *url=[NSString stringWithFormat:@"%@add_note_benefits.php?title=%@&note=%@&cid=%@&userid=%@&account_id=%@",
				   objappdel.strUrl,txttitle1,txtnote1,objappdel.actID,objappdel.appUserId,objappdel.strAccount_id];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultBenefit:) andHandler:self];
	
	
	
}
-(void)searchResultBenefit:(NSDictionary*)dictionary{
    
    [AlertHandler hideAlert];
	
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"Record Inserted Successfully"])
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Notes Saved" message:@"New Note Created" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	else if([[dictionary valueForKey:@"msg"] isEqualToString:@"Enter valid data"])
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter valid data" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	
	else {
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Failed" message:@"Note is Already available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		
	}
	
	
	
	
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		if(flag==0)
		{
			
			
		}
		else		
			[self.navigationController popViewControllerAnimated:YES];
		
	}
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
	if([txtnote.text isEqualToString:@"Write Here......"]){
		txtnote.text=@"";
	}
	
	// Any new character added is passed in as the "text" parameter
	if ([text isEqualToString:@"\n"]) {
		// Be sure to test for equality using the "isEqualToString" message
		[txtnote resignFirstResponder];
		
		// Return FALSE so that the final '\n' character doesn't get added
		return FALSE;
	}
	// For any other character return TRUE so that the text gets added to the view
	return TRUE;
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
	
	CGRect textFieldRect =[self.view.window convertRect:textView.bounds fromView:textView];
	CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
	
	CGFloat midline = textFieldRect.origin.y + 1.0 * textFieldRect.size.height;
	CGFloat numerator =midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	animatedDistance = floor(162.0 * heightFraction);
	
	CGRect viewFrame = self.view.frame;
	
	viewFrame.origin.y -= animatedDistance;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[self.view setFrame:viewFrame];
    [UIView commitAnimations];   
}
-(void) textViewDidEndEditing:(UITextView *)textView{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	self.view.frame = CGRectMake(0,-70, 320, 460);
	[txtnote resignFirstResponder];
	[UIView commitAnimations];   
	
	
}

- (void)dealloc
{
    [super dealloc];
	[lblselct release];
	[lblCategory release];
	[lblselect release];
	[scrl release];
	[txtnote release];
	[txtSubTit release];
	[txttitle release];
	
	
	
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
	objappdel.sign=@"a";
    self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
	//00txtSubTit.text=objappdel.strcategory;
    lblCategory.text=objappdel.strcategory;
   // 00lblselect.text=objappdel.appActName;
	 //lblselect.text=[NSString stringWithFormat:@"%@ %@ Information-%@",objappdel.appActName,objappdel.strInfotype,objappdel.strcategory];
	lblselect.text=[NSString stringWithFormat:@"%@ Information-%@",objappdel.strInfotype,objappdel.strcategory];

	
//	if(objappdel.flag==11){
//		
//		00lblselct.text=@"Benefits Information";
//	}
//	else {
//		lblselct.text=@"Medical Information";
//	}
	
	
//       self.title=@"John Smith";
	scrl.contentSize = CGSizeMake(320, 600);
     self.navigationItem.hidesBackButton=TRUE;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)click{

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
