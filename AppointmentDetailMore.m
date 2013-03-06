//
//  AppointmentDetailMore.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppointmentDetailMore.h"
#import "JSONParser.h"
#import "AlertHandler.h"
@implementation AppointmentDetailMore
@synthesize pickerViewDOB;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)JSONDel{
	[AlertHandler showAlertForProcess];
	
	
	
	
	
	NSString *url;
	url=[NSString stringWithFormat:@"%@delete_appointment.php?app_id=%@",objappdel.strUrl,objappdel.actID];
	
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultUpdate:) andHandler:self];
	
}
-(void)searchResultUpdate:(NSDictionary*)dictionary{
	[AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	
		
	
	isflag=TRUE;
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"Appointment Deleted Successfully"]){
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Done"
													  message:@"Appointment Deleted Successfully" 
													 delegate:self 
											cancelButtonTitle:nil 
											otherButtonTitles:@"OK",nil];
		alert.tag=0;
		[alert show];
		[alert release];
		
		
	}
	
	
	
}

-(void)JSONUpdate{
	[AlertHandler showAlertForProcess];
	
	
	
	
		
		NSString *url;
		url=[NSString stringWithFormat:@"%@appointment_list.php?app_id=%@",objappdel.strUrl,objappdel.actID];
			 
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultUpdate1:) andHandler:self];
			 
}
-(void)searchResultUpdate1:(NSDictionary*)dictionary{
	[AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	
	arrlist = (NSMutableArray*)[dictionary valueForKey:@"Appointments"];
	
	txttitle.text=[[arrlist objectAtIndex:0]valueForKey:@"Title"];
	txtstarttime.text=[[arrlist objectAtIndex:0]valueForKey:@"Start_time"];
	txtendtime.text=[[arrlist objectAtIndex:0]valueForKey:@"End_time"];
	if([[[arrlist objectAtIndex:0]valueForKey:@"Whole_Day_event"] isEqualToString:@"TRUE"]){
		check=FALSE;
		[txtworkday setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];

		
		
	}
	else {
        check=TRUE;
		[txtworkday setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];

	}

	//txtworkday.text=[[arrlist objectAtIndex:0]valueForKey:@"Whole_Day_event"];
	txtdetail.text=[[arrlist objectAtIndex:0]valueForKey:@"Details"];
	
		
				 
				 
				 
						 
			 
}
			 
-(void)JSONSave{
	

	[AlertHandler showAlertForProcess];
	
	objappdel.flag=33;
	//start = [NSDate timeIntervalSinceReferenceDate];
	NSString *txttitle1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txttitle.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtstarttime1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtstarttime.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtendtime1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtendtime.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
//	NSString *txtworkday1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtworkday.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *txtdetail1=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)txtdetail.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *url;
	NSString *txtworkday1;
	if(!check)
	{
		txtworkday1=[NSString stringWithFormat:@"TRUE"];
		
	}
	else{
						 
			txtworkday1=[NSString stringWithFormat:@"FALSE"];
	}
					 
	
	
	if([objappdel.strselect isEqualToString:@"New"]){
		
		url=[NSString stringWithFormat:@"%@add_Appointment.php?Title=%@&Date=%@&Start_time=%@&End_time=%@&Whole_Day_event=%@&Details=%@&userid=%@&account_id=%@",
			 objappdel.strUrl,txttitle1,objappdel.strdate,txtstarttime1,txtendtime1,txtworkday1,txtdetail1,objappdel.appUserId,objappdel.strAccount_id];

		
				
	}
	else{
		url=[NSString stringWithFormat:@"%@update_appointment.php?Title=%@&Start_time=%@&End_time=%@&Whole_Day_event=%@&Details=%@&app_id=%@",
			 objappdel.strUrl,txttitle1,txtstarttime1,txtendtime1,txtworkday1,txtdetail1,objappdel.actID];	
	}
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultSave:) andHandler:self];
	
	
	
}
-(void)searchResultSave:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
    NSLog(@"%@",dictionary);
	
		
		
		
	isflag=FALSE;
	
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"Record Inserted Successfully"]){
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Done"
													  message:@"Appointment Added Successfully" 
													 delegate:self 
											cancelButtonTitle:nil 
								otherButtonTitles:@"OK",nil];
		[alert show];
		
		[alert release];
		
		
	}
	if([[dictionary valueForKey:@"msg"] isEqualToString:@"Values Updated Successfully"]){
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Done"
													  message:@"Values Updated Successfully" 
													 delegate:self 
											cancelButtonTitle:nil 
											otherButtonTitles:@"OK",nil];
		alert.tag=0;
		[alert show];
		[alert release];
		
		
	}
	
	
	
	
}



- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	
	
	
	if(actionSheet.tag==0){
		
		[self.navigationController popViewControllerAnimated:YES];
		
	}
	else if(actionSheet.tag==1){
		
		if(buttonIndex==0){
			[self JSONDel];
			
		}
		else {
			
		}

		
	}
	else if(actionSheet.tag==2){
		
		
	}
	//if (buttonIndex == 0)
//	{
//		if(objappdel.flag==33){
//			objappdel.flag=0;
//			
//		}
//		else{
//		
//		}
//		
//	}
//	else {
//		
//		
//					
//			
//		
//		
//	}
}
- (void)dealloc
{
    [super dealloc];
	if(arrlist!=nil)
	{
		arrlist=nil;
		[arrlist release];
		
	}
	[lbldate release];
	[txtdetail release];
	[txttitle release];
	[txtendtime release];
	[txtstarttime release];
	[txtworkday release];
	[btndelete release];
	
	
}
#pragma mark IBAction
-(IBAction)cancel{
    [txttitle resignFirstResponder];
    [txtdetail resignFirstResponder];
    [txtendtime resignFirstResponder];
    [txtstarttime resignFirstResponder];
	[self.navigationController popViewControllerAnimated:YES];
	
}
-(IBAction)deleteappo{
    [txttitle resignFirstResponder];
    [txtdetail resignFirstResponder];
    [txtendtime resignFirstResponder];
    [txtstarttime resignFirstResponder];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Are You Sure" message:[NSString stringWithFormat:@"You are about to delete everything pertaining to %@ on %@",txttitle.text,txtstarttime.text] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm",@"Cancel",nil];
    alert.tag=1;
	[alert show];
    [alert release];
    
}


-(IBAction)click{

}
-(IBAction)Save{
    [txttitle resignFirstResponder];
    [txtdetail resignFirstResponder];
    [txtendtime resignFirstResponder];
    [txtstarttime resignFirstResponder];
    
	if([txttitle.text isEqualToString:@""]){
		
		isflag=TRUE;
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Data not Saved" message:@"Fill the title" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		alert.tag=2;
		[alert show];
		[alert release];
		
		
	}
	else if([txtstarttime.text isEqualToString:@""] && check==TRUE){
		isflag=TRUE;
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Data not Saved" message:@"Please select the start time" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		alert.tag=2;
		[alert show];
		[alert release];
		
		
	}
	else
	{
	objappdel.flag=19;
	[self JSONSave];
	}
}
-(IBAction)checkMark{
	
	if(check){
	[txtworkday setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateNormal];
		check=FALSE;
	}
	else {
		[txtworkday setImage:[UIImage imageNamed:@"notselected.png"] forState:UIControlStateNormal];
		
		check=TRUE;
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
	    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    
    objappdel.sign=@"a";
    objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
	//self.view.frame = CGRectMake(0,0, 320, 460);
	check=TRUE;
    pickerViewDOB.hidden=TRUE;
	picker.hidden=TRUE;
    
	scrol.contentSize = CGSizeMake(320, 500);
    self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
    self.navigationItem.hidesBackButton=TRUE;
    lbldate.text=objappdel.strdate;
    if([objappdel.strselect isEqualToString:@"New"])
    {
        btndelete.hidden=TRUE;
        txttitle.text=@"";
        
        txtstarttime.text=@"";
        
        txtendtime.text=@"";
        
        //txtworkday.text=@"";
        
        txtdetail.text=@"";
		btnCancel.frame=CGRectMake(155, 364, 72, 37);
		//[btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
        
        
    }
    else
    {
        
        [self JSONUpdate];
        
        
        
    }

    
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag+1;
    
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder)
    {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}
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
	if([txtdetail.text isEqualToString:@"Write Here......"]){
		txtdetail.text=@"";
	}
	
	// Any new character added is passed in as the "text" parameter
	if ([text isEqualToString:@"\n"]) {
		// Be sure to test for equality using the "isEqualToString" message
		[textView resignFirstResponder];
		
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
	
	animatedDistance = floor(140.0 * heightFraction);
	
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

	
	[txtdetail resignFirstResponder];
	
	[UIView commitAnimations];   
	
	
}
#pragma mark UIDatePicker
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([textField isEqual:txtstarttime])
    {
		
        if (!actionSheetDOB)
        {
			[txttitle resignFirstResponder];
			[txtdetail resignFirstResponder];
            actionSheetDOB = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            [actionSheetDOB setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
			
            CGRect pickerFrame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                pickerFrame = CGRectMake(0, 40, 768, 300);
            else
                pickerFrame = CGRectMake(0, 40, 320, 200);
			
            pickerViewDOB = [[UIDatePicker alloc] initWithFrame:pickerFrame];
			pickerViewDOB.minuteInterval=1;
			pickerViewDOB.datePickerMode=UIDatePickerModeTime;
            //pickerViewDOB.showsSelectionIndicator = YES;
            pickerViewDOB.userInteractionEnabled = TRUE;
          //  pickerViewDOB.dataSource = self;
          //  pickerViewDOB.delegate = self;
            [actionSheetDOB addSubview:pickerViewDOB];
			
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"OK"]];
            closeButton.momentary = YES;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
            else
                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
			
			
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
            [actionSheetDOB addSubview:closeButton];
            [closeButton release];
			
			
            CGRect frame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
            else
                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
			
            [actionSheetDOB setFrame:frame];
            [self.view addSubview:actionSheetDOB];
			
            return NO;           
        }
    }
    
	else if ([textField isEqual:txtendtime])
    {
		
        if (!actionsheet)
        {
			[txttitle resignFirstResponder];
			[txtdetail resignFirstResponder];
            actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            [actionsheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
			
            CGRect pickerFrame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                pickerFrame = CGRectMake(0, 40, 768, 300);
            else
                pickerFrame = CGRectMake(0, 40, 320, 200);
			
            picker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
			picker.minuteInterval=1;
			picker.datePickerMode=UIDatePickerModeTime;
           // picker.showsSelectionIndicator = YES;
            picker.userInteractionEnabled = TRUE;
			//  picker.dataSource = self;
			//picker.delegate = self;
            [actionsheet addSubview:picker];
			
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"OK"]];
            closeButton.momentary = YES;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
            else
                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
			
			
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(dismissActionSheet1) forControlEvents:UIControlEventValueChanged];
            [actionsheet addSubview:closeButton];
            [closeButton release];
			
			
            CGRect frame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
            else
                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
			
            [actionsheet setFrame:frame];
            [self.view addSubview:actionsheet];
			
            return NO;           
        }
    }
    else {
        return YES;
    }
	
    return 0;
}
-(void)dismissActionSheet
{
    if (actionSheetDOB) 
    {
		
		NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
		[timeFormat setDateFormat:@"h:mm a"];
		NSString *theTime = [timeFormat stringFromDate:[pickerViewDOB date]];
		
		
       
        
       txtstarttime.text= theTime;
        
    }
    
    actionSheetDOB.hidden = TRUE;
    
    [actionSheetDOB release];
    actionSheetDOB=nil;
}
-(void)dismissActionSheet1
{
    if (actionsheet) 
    {
		NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
		[timeFormat setDateFormat:@"h:mm a"];
		NSString *theTime = [timeFormat stringFromDate:[picker date]];
		
		
		//NSDateFormatter *dtForm = [[NSDateFormatter alloc] init];
//		[dtForm setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];\
//		[dtForm setDateFormat:@"h:mm:ss a"];
//		NSString *str = [dtForm stringFromDate:[pickerViewDOB date]];
//		NSDate *dat = [dtForm dateFromString:str];
		
        //NSDate date = pickerViewDOB.date;
		//NSDate *selected = [picker date];
		
        //NSDateFormatter formatter = [[[NSDateFormatter alloc] init] autorelease];
	//	[formatter setDateFormat:@"h:mm:ss a"];
	//	NSString *date1= [[formatter stringFromDate:dtForm] retain];
        NSLog(@"date is %@",theTime);
		txtendtime.text= theTime;
        
    }
    
    actionsheet.hidden = TRUE;
    
    [actionsheet release];
    actionsheet=nil;
}

//- (void)pickerView:(UIDatePicker *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//	
//    if (pickerView == pickerViewDOB)
//    {
//        NSString *a =row;
//        txtstarttime.text= [NSString stringWithFormat:@"%@",a];
//    }
//}
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
