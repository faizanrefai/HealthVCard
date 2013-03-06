//
//  Contact_Detail.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Contact_Detail.h"
#import "JSONParser.h"
#import "AlertHandler.h"
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;

@implementation Contact_Detail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




#pragma mark textField


//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//	if ([textField isEqual:txtcountry])
//    {
//		
//			
//		[txtview resignFirstResponder];
//		[txtname resignFirstResponder];
//		[txttitle resignFirstResponder];
//		[txtadd resignFirstResponder];
//		[txtcity resignFirstResponder];
//		[txtstate resignFirstResponder];
//		[txtpostal resignFirstResponder];
//		[txtcountry resignFirstResponder];
//		[txtphone resignFirstResponder];
//		[txtwork resignFirstResponder];
//		[txtemail resignFirstResponder];
//		[txtcell resignFirstResponder];
//        if (!actionSheet)
//        {
//			
//            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//            [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
//			
//            CGRect pickerFrame;
//			
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//                pickerFrame = CGRectMake(0, 40, 768, 300);
//            else
//                pickerFrame = CGRectMake(0, 40, 320, 200);
//			
//            picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
//            picker.showsSelectionIndicator = YES;
//            picker.userInteractionEnabled = TRUE;
//            picker.dataSource = self;
//            picker.delegate = self;
//            [actionSheet addSubview:picker];
//			
//            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
//            closeButton.momentary = YES;
//			
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
//            else
//                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
//			
//			
//            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
//            closeButton.tintColor = [UIColor blackColor];
//            [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
//            [actionSheet addSubview:closeButton];
//            [closeButton release];
//			
//			
//            CGRect frame;
//			
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
//            else
//                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
//			
//            [actionSheet setFrame:frame];
//            [self.view addSubview:actionSheet];
//			
//            return NO;           
//        }
//    }
//    else {
//        return YES;
//    }
//    return 0;
//}
//

- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    CGRect textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
	if([txtview.text isEqualToString:@"Write Here......"]){
		txtview.text=@"";
	}
	
	// Any new character added is passed in as the "text" parameter
	if ([text isEqualToString:@"\n"]) {
		// Be sure to test for equality using the "isEqualToString" message
		[txtview resignFirstResponder];
		
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
	self.view.frame = CGRectMake(0,0, 320, 460);
	
	
	[txtview resignFirstResponder];
	
	[UIView commitAnimations];   
	
	
}
-(void)JSONSave{
	
	[AlertHandler showAlertForProcess];
	NSString *url;
	NSString *txtname1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtname.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txttitle1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txttitle.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtadd1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtadd.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtcity1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtcity.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtstate1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtstate.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtpostal1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtpostal.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtphone1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtphone.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtwork1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtwork.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtcell1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtcell.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtemail1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtemail.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtview1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtview.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtcountry1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtcountry.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);

	if(objappdel.flag==16){
		
		url=[NSString stringWithFormat:@"%@update_emergancy_contact.php?Name=%@&Title=%@&Address=%@&State=%@&City=%@&Zip=%@&Country=%@&Phone_home=%@&Phone_work=%@&Phone_cell=%@&Email=%@&Additional_Info=%@&eid=%@",
					   objappdel.strUrl,txtname1,txttitle1,txtadd1,txtstate1,txtcity1,txtpostal1,txtcountry1,txtphone1,txtwork1,txtcell1,txtemail1,txtview1,objappdel.actID];
	
		
		
	}
	else{
		
		url=[NSString stringWithFormat:@"%@add_emergancy_contact.php?Name=%@&Title=%@&Address=%@&State=%@&City=%@&Zip=%@&Country=%@&Phone_home=%@&Phone_work=%@&Phone_cell=%@&Email=%@&Additional_Info=%@&userid=%@&account_id=%@",
				objappdel.strUrl,txtname1,txttitle1,txtadd1,txtstate1,txtcity1,txtpostal1,txtcountry1,txtphone1,txtwork1,txtcell1,txtemail1,txtview1,objappdel.appUserId,objappdel.strAccount_id];
	}
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultSave:) andHandler:self];
	
	
	
}
-(void)searchResultSave:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
    NSLog(@"%@",dictionary);
	
	if(objappdel.flag==16)
	{
		
		if([[dictionary valueForKey:@"msg"]isEqualToString:@"Values Updated Successfully"])
		{
						
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Updates"
														  message:@"Values updated successfully" 
														 delegate:self 
												cancelButtonTitle:nil 
												otherButtonTitles:@"OK",nil];
			alert.tag=1;
			[alert show];
			[alert release];
			
			
			
		}
		else if([[dictionary valueForKey:@"msg"]isEqualToString:@"Name is Already available"])
		{
			
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
														  message:@"Name is Already available" 
														 delegate:self 
												cancelButtonTitle:nil 
												otherButtonTitles:@"OK",nil];
			alert.tag=0;
			[alert show];
			[alert release];
			
			
			
		}
		
		
		
		
		
		
	}
	else{
	if([[dictionary valueForKey:@"msg"]isEqualToString:@"Please fill out all required field"])
	{
		
		
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
														  message:@"Please fill out all required field" 
														 delegate:self 
												cancelButtonTitle:nil 
												otherButtonTitles:@"OK",nil];
			
		alert.tag=0;	
		[alert show];
		[alert release];
		
		
		
	}
	else if([[dictionary valueForKey:@"msg"]isEqualToString:@"Name is Already available"])
		{
			
			
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
														  message:@"This Name already exists" 
														 delegate:self 
												cancelButtonTitle:nil 
												otherButtonTitles:@"OK",nil];
			
			alert.tag=0;	
			[alert show];
			[alert release];
			
			
			
		}
	else if([[dictionary valueForKey:@"msg"] isEqualToString:@"Record Inserted Successfully"]){
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Done"
												  message:@"Contact Added Successfully" 
												 delegate:self 
										cancelButtonTitle:nil 
										otherButtonTitles:@"OK",nil];
		alert.tag=1;
		[alert show];
	[alert release];
	
	
	}
	
	}
	
	
}
-(void)JSONDisplay{
	
	[AlertHandler showAlertForProcess];
	
	NSString *url=[NSString stringWithFormat:@"%@emergancy_contact_list.php?eid=%@",objappdel.strUrl,objappdel.actID];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultDisplay:) andHandler:self];
	
	
	
}
-(void)searchResultDisplay:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
    NSLog(@"%@",dictionary);
	
	arrlist=[[NSMutableArray alloc]init];
	
	arrlist = (NSMutableArray*)[dictionary valueForKey:@"emergancy_contact"];
	
	txtname.text=[[arrlist objectAtIndex:0]valueForKey:@"Name"];
	txttitle.text=[[arrlist objectAtIndex:0]valueForKey:@"Title"];
	txtphone.text=[[arrlist objectAtIndex:0]valueForKey:@"Phone_home"];
	txtwork.text=[[arrlist objectAtIndex:0]valueForKey:@"Phone_work"];
	txtcell.text=[[arrlist objectAtIndex:0]valueForKey:@"Phone_cell"];
	txtstate.text=[[arrlist objectAtIndex:0]valueForKey:@"State"];
	
	txtadd.text=[[arrlist objectAtIndex:0]valueForKey:@"Address"];
	txtcity.text=[[arrlist objectAtIndex:0]valueForKey:@"City"];	
	txtpostal.text=[[arrlist objectAtIndex:0]valueForKey:@"Zip"];
	txtcountry.text=[[arrlist objectAtIndex:0]valueForKey:@"Country"];
	//for(int i=0;i<[objappdel.arrCountry count];i++){
//		
//		if([str isEqualToString: [objappdel.arrCountryId objectAtIndex:i]])
//		{
//			
//			txtcountry.text=[objappdel.arrCountry objectAtIndex:i];
//			break;
//			
//		}
//	}
//	
	
	
	
	
	txtemail.text=[[arrlist objectAtIndex:0]valueForKey:@"Email"];	
	txtview.text=[[arrlist objectAtIndex:0]valueForKey:@"Additional_Info"];	
	
   
	
	
}
-(void)JSONDel{
	[AlertHandler showAlertForProcess];
	
	
	
	NSString *url=[NSString stringWithFormat:@"%@delete_emergancy_contact.php?eid=%@",objappdel.strUrl,objappdel.actID];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult10:) andHandler:self];
	
	
	
}
-(void)searchResult10:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	if([[dictionary valueForKey:@"msg"]isEqualToString:@"Record Deleted Successfully"])
	{
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Contact Deleted" message:@"Contact has been deleted successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		alert.tag=1;
		[alert show];
		[alert release];
		
	}
	else {
		
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Contact Delete" message:@"No such Contact exists" delegate:self cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];
		alert.tag=0;
		[alert show];
		[alert release];
	}
	
	
	
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if(actionSheet.tag==0){
		
		
		
		
	}
	else if(actionSheet.tag==1){
		
		[self.navigationController popViewControllerAnimated:YES];
		
	}
	else {
		
		if (buttonIndex == 0){
			[self JSONDel];
		}
	}

		
}
-(IBAction)Done{
	picker.hidden=TRUE;
	tool.hidden=TRUE;
	btnDone.hidden=TRUE;
	
	
}
-(IBAction)PickerClick{
	
	picker.hidden=FALSE;
	//scrl.scrollEnabled=FALSE;
	tool.hidden=FALSE;
	btnDone.hidden=FALSE;
	
	//picker = [[UIPickerView alloc] init];
	//picker.frame=CGRectMake(0, 0, 480, 100);
	
	
	
}

- (void)dealloc
{
    [super dealloc];
	[txtphone release];
	[txtadd release];
	[txtcell release];
	[txtcity release];
	[txtcountry release];
	[txtemail release];
	[txtname release];
	[txtphone release];
	[txtpostal release];
	[txtstate release];
	[txtview release];
	[txttitle release];
	[tool release];
	[picker release];
	if(arrlist!=nil){
		arrlist=nil;
		[arrlist release];
		
		
	}
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
	objappdel =(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	
	picker.hidden=TRUE;
	tool.hidden=TRUE;
	btnDone.hidden=TRUE;
	
    
    scrl.scrollEnabled = TRUE;
	 self.navigationItem.hidesBackButton=TRUE;
	CGSize size = {320,900};
	
	scrl.contentSize = size;
    
   
	  


    // Do any additional setup after loading the view from its nib.
}
-(IBAction)click{

}
-(IBAction)cancel{
    [txtview resignFirstResponder];
    		[txtname resignFirstResponder];
    		[txttitle resignFirstResponder];
    		[txtadd resignFirstResponder];
    		[txtcity resignFirstResponder];
    		[txtstate resignFirstResponder];
    		[txtpostal resignFirstResponder];
    		[txtcountry resignFirstResponder];
    		[txtphone resignFirstResponder];
    		[txtwork resignFirstResponder];
    		[txtemail resignFirstResponder];
        [txtcell resignFirstResponder];
	[self.navigationController popViewControllerAnimated:YES];
	
}
-(void)viewWillAppear:(BOOL)animated{
	
	objappdel.sign=@"a";
	if([objappdel.strselect isEqualToString:@"Detail"]){
		
		self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
		[self JSONDisplay];
		
		
	}

	else{
		
		txtname.text=@"";
        txtname.text=@"";
        txttitle.text=@"";
        txtpostal.text=@"";
        txtphone.text=@"";
        txtwork.text=@"";
        txtcell.text=@"";
        txtadd.text=@"";
        txtcity.text=@"";
        txtstate.text=@"";
        txtcountry.text=@"";
        txtemail.text=@"";
		btndelete.hidden=TRUE;
		
	}
	
	
}
-(IBAction)Save{
    [txtview resignFirstResponder];
    		[txtname resignFirstResponder];
    		[txttitle resignFirstResponder];
    		[txtadd resignFirstResponder];
    		[txtcity resignFirstResponder];
    		[txtstate resignFirstResponder];
    		[txtpostal resignFirstResponder];
    		[txtcountry resignFirstResponder];
    		[txtphone resignFirstResponder];
    		[txtwork resignFirstResponder];
    		[txtemail resignFirstResponder];
    		[txtcell resignFirstResponder];
	if([txtname.text isEqualToString:@""])
	{
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please Enter the Name" message:@"Press OK to Continue" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil];
		alert.tag=0;
		[alert show];
		[alert release];
		
		
	}
	else{
	[self JSONSave];
	}
}
-(IBAction)deletedata{
	[txtview resignFirstResponder];
    [txtname resignFirstResponder];
    [txttitle resignFirstResponder];
    [txtadd resignFirstResponder];
    [txtcity resignFirstResponder];
    [txtstate resignFirstResponder];
    [txtpostal resignFirstResponder];
    [txtcountry resignFirstResponder];
    [txtphone resignFirstResponder];
    [txtwork resignFirstResponder];
    [txtemail resignFirstResponder];
    [txtcell resignFirstResponder];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Are You Sure" message:[NSString stringWithFormat:@"You are about to delete everything pertaining to Emergency Contact %@",txtname.text] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm",@"Cancel", nil];
    alert.tag=2;
	[alert show];
    [alert release];

}

#pragma mark picker


-(void)dismissActionSheet
{
    if (actionSheet)
    {
        if ([txtcountry.text isEqualToString:@""])
        {
            txtcountry.text=[NSString stringWithFormat:@"%@",[objappdel.arrCountry objectAtIndex:0]];
        }       
    }
	
	
    actionSheet.hidden = TRUE;
    
    [actionSheet release];
    actionSheet=nil;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == picker) {
        return 1;
    }
	return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
    if (pickerView == picker)
    {
        a =  [objappdel.arrCountry objectAtIndex:row];
		strCID=[objappdel.arrCountryId objectAtIndex:row];
		NSLog(@"%@",strCID);
        txtcountry.text= [NSString stringWithFormat:@"%@",a];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    if(pickerView == picker)
    {
        if (component==0)
        {
            return [objappdel.arrCountry count];
        }
    }
	return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

{
    if(pickerView == picker)
    {
        if (component==0)
        {
            return [objappdel.arrCountry objectAtIndex:row];
        }
    }
	return 0;
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
