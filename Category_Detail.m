//
//  Category_Detail.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Category_Detail.h"
#import "AlertHandler.h"
#import "JSONParser.h"
@implementation Category_Detail
@synthesize tblViewCell;

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
	objappdel=(HealthVCardAppDelegate *)[[UIApplication sharedApplication]delegate];
//    self.title=[NSString stringWithFormat:@"%@",objappdel.appUserName];

    scrl.scrollEnabled=YES;
	self.title=[NSString stringWithFormat:@"%@",objappdel.appUserName];
	
	CGSize size = {320,600};
	self.navigationItem.hidesBackButton=TRUE;
	scrl.contentSize = size;
	arrNote=[[NSMutableArray alloc]init];
	arrTitle=[[NSMutableArray alloc]init];
	arrNid=[[NSMutableArray alloc]init];
    //lblselct.text=objappdel.strselect;
    //lblselct1.text=objappdel.strselect;
 
    if ([objappdel.strselect isEqualToString:@"new"]) {
       
		lblMsg.hidden=FALSE;
        lblcatogory1.hidden=FALSE;
		lblcatogory1.text=objappdel.strcategory;
        tblcategory.hidden=TRUE;
        
    }
    else{
		self.title=[NSString stringWithFormat:@"%@",objappdel.appActName];
        lblMsg.hidden=TRUE;
		lblcatogory1.hidden=TRUE;
		lblselct1.text=[NSString stringWithFormat:@"%@ Information-%@",objappdel.strInfotype,objappdel.strcategory];
		lblselct.text=[NSString stringWithFormat:@"%@ Information-%@",objappdel.strInfotype,objappdel.strcategory];
      // lblcatogory1.hidden=TRUE;
		//if(objappdel.flag==11){
//			
//			lblselct.text=@"Benefits Information";
//			lblselct1.text=@"Benefits Information";
//			
//		}
//		else {
//			lblselct.text=@"Medical Information";
//			lblselct1.text=@"Medical Information";
//
//		}

		
		
        
		lblMsg.text=@"No notes exist for";
       lblcatogory1.text=objappdel.strcategory;
		lblcatogory2.text=objappdel.strcategory;
		lblcatogory.text=objappdel.strcategory;
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
	objappdel.sign=@"a";
	NSLog(@"%@",objappdel.strcategory);
	lblName.text=objappdel.appActName;
	for(int i=1;i<=7;i++)
	{
		if([objappdel.actID isEqualToString:[NSString stringWithFormat:@"%d",i]])
		{
			
			btndelete.hidden=TRUE;
			lblselct.hidden=TRUE;
			lblcatogory.hidden=TRUE;
			
		}
	}
	
	//lblName.text=[NSString stringWithFormat:@"%@",objappdel.appUserName];
	[self JSONDisplayNote];
	
}

-(IBAction)Addnew{

    NewNotes *objNew=[[NewNotes alloc]initWithNibName:@"NewNotes" bundle:nil];
    [self.navigationController pushViewController:objNew animated:YES];
    [objNew release];
    
}
-(void)JSONDelALl{
	[AlertHandler showAlertForProcess];
	NSString *url;
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
	{
		url=[NSString stringWithFormat:@"%@delete_benefits_category.php?cbid=%@",objappdel.strUrl,objappdel.actID];

		
		
	}
	else{
	url=[NSString stringWithFormat:@"%@delete_medical_category.php?cid=%@",objappdel.strUrl,objappdel.actID];
	}
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
	
}
-(void)searchResult:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	if([[dictionary valueForKey:@"msg"]isEqualToString:@"category Deleted Successfully"])
	{
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Category Delete" message:@"Category has been deleted successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		alert.tag=1;
		[alert show];
		[alert release];
		
	}
	else {
		
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"No such account exists" delegate:self cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];
		alert.tag=0;
		[alert show];
		[alert release];
	}
	
	
	
}
-(void)JSONDisplayNote{
	[AlertHandler showAlertForProcess];
	
	NSString *url;
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
	{
		url=[NSString stringWithFormat:@"%@Benifits_note_list.php?account_id=%@&userid=%@&cid=%@",objappdel.strUrl,objappdel.strAccount_id,objappdel.appUserId,objappdel.actID];
		NSLog(@"%@",url);
		
	}
	else{
		////////left*******
	url=[NSString stringWithFormat:@"%@Medical_note_list.php?userid=%@&cid=%@&account_id=%@",objappdel.strUrl,objappdel.appUserId,objappdel.actID,objappdel.strAccount_id];
		NSLog(@"%@",url);

	}NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser ;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult1:) andHandler:self];
	
	
}
-(void)searchResult1:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	
	
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
	{
		
		if([[dictionary valueForKey:@"msg"] isEqualToString:@"No data Found"])
		{
			lblMsg.hidden=FALSE;
			lblcatogory2.hidden=FALSE;	
		}
		else{
			lblcatogory2.hidden=TRUE;
			lblMsg.hidden=TRUE;
			arrNote=[[[dictionary valueForKey:@"note_benefits"]valueForKey:@"note"]copy];
			arrTitle=[[[dictionary valueForKey:@"note_benefits"]valueForKey:@"title"]copy];
			arrNid=[[[dictionary valueForKey:@"note_benefits"]valueForKey:@"nbid"]copy];
			[tblcategory reloadData];
		}
	

		
		
	}
	else{
	
		if([[dictionary valueForKey:@"msg"] isEqualToString:@"No data Found"])
		{
			
			lblMsg.hidden=FALSE;
			lblcatogory2.hidden=FALSE;
			
				
			
			
			
		}
		else{
			lblcatogory2.hidden=TRUE;
			lblMsg.hidden=TRUE;
			
			arrNote=[[[dictionary valueForKey:@"Medical_note"]valueForKey:@"note"]copy];
			arrTitle=[[[dictionary valueForKey:@"Medical_note"]valueForKey:@"title"]copy];
			arrNid=[[[dictionary valueForKey:@"Medical_note"]valueForKey:@"nid"]copy];
			[tblcategory reloadData];
			}
	}
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrNote count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   	
	static NSString *cellIdentifier = @"MyIdentifire";
	TableCell *cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if(cell == nil)
	{
		[[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
		cell=self.tblViewCell;
		self.tblViewCell=nil;
        
		UIButton *dltBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		dltBtn.tag=indexPath.row;
		
		[dltBtn setTitle:@"Save" forState:UIControlStateNormal];
		dltBtn.frame = CGRectMake(25, 110, 75, 30);
		[dltBtn setImage:[UIImage imageNamed:@"Delete.png"] forState:UIControlStateNormal];
		[dltBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:dltBtn];
		
		UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		cancelBtn.tag=indexPath.row;
		
		[cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
		cancelBtn.frame = CGRectMake(115, 110, 75, 30);
		[cancelBtn setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
		[cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:cancelBtn];
		
		UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		saveBtn.tag=indexPath.row;
		
		[saveBtn setTitle:@"Delete" forState:UIControlStateNormal];
		saveBtn.frame = CGRectMake(205, 110, 75, 30);
		[saveBtn setImage:[UIImage imageNamed:@"Save.png"] forState:UIControlStateNormal];
		[saveBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:saveBtn];
		
        
    } 
	
	NSLog(@"dfrdstg%@",cell.txtnote.text);
	cell.txtnote.text=[arrNote objectAtIndex:indexPath.row];
	cell.txttitle.text=[arrTitle objectAtIndex:indexPath.row];
    
   
    
    // Configure the cell.
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return  150;
    
}

-(IBAction) save:(id)sender;
{
	UIButton *btn=(UIButton *)sender;
    
    int i=btn.tag;
	
	
	TableCell *cell;
    
    cell = (TableCell *)[tblcategory cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    
		
	NSString *strid=[arrNid objectAtIndex:i];
	
	[AlertHandler showAlertForProcess];
	//static NSString *cellIdentifier = @"MyIdentifire";
//	TableCell *cell = (TableCell*)[tblcategory dequeueReusableCellWithIdentifier:cellIdentifier];
	//TableCell *cell=[[UITableViewCell alloc]init];
	NSString *url;
	
	NSString *strnote=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)cell.txtnote.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	NSString *strtitle=(NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)cell.txttitle.text, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
	{
		url=[NSString stringWithFormat:@"%@update_benefits_note.php?nbid=%@&title=%@&note=%@",objappdel.strUrl,strid,strtitle,strnote];

		
	}	
	else {
		url=[NSString stringWithFormat:@"%@update_medical_note.php?nid=%@&title=%@&note=%@",objappdel.strUrl,strid,strtitle,strnote];
		
	}

	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResultSave:) andHandler:self];
	
	
	
	
}
-(void)searchResultSave:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
	NSLog(@"%@",dictionary);
	if([[dictionary valueForKey:@"msg"]isEqualToString:@"Value Updated Successfully"])
	{
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Note updated" message:@"Note has been updated successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		alert.tag=1;
		[alert show];
		[alert release];
		
	}
	else {
		
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"No such note exists" delegate:self cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];
		alert.tag=0;
		[alert show];
		[alert release];
	}
	
	
	
}

-(IBAction) deleteCell:(id)sender;
{
	UIButton *btn=(UIButton *)sender;
    
    int i=btn.tag;
	strid=[arrNid objectAtIndex:i];
	flag=1;
	strTitle=[[NSString stringWithFormat:@"%@",[arrTitle objectAtIndex:i]]copy];
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Note Delete" message:[NSString stringWithFormat:@"You are about to Delete the notes associated with %@ Information %@ %@.This can not be undone",objappdel.strInfotype,lblcatogory2.text,strTitle] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm",@"Cancel", nil];
	alert.tag=2;
	[alert show];
	[alert release];
	
	
	
	
}
-(void)JSONDeleteNote{
		
	[AlertHandler showAlertForProcess];
	NSString *url;
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
	{
		url=[NSString stringWithFormat:@"%@delete_benefits_note.php?nbid=%@",objappdel.strUrl,strid];
		
		
	}else {
		url=[NSString stringWithFormat:@"%@delete_medical_note.php?nid=%@",objappdel.strUrl,strid];
		
	}
	
	
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	JSONParser *parser;
	parser= [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult12:) andHandler:self];
}

-(void)searchResult12:(NSDictionary*)dictionary{
    [AlertHandler hideAlert];
	//UIButton *btn=(UIButton *)sender;
    
    //int i=btn.tag;
	//NSString *strid=[arrNote objectAtIndex:i];
	NSLog(@"%@",strTitle);
	
	if([[dictionary valueForKey:@"msg"]isEqualToString:@"note Deleted Successfully"])
	{
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Note Delete" message:@"Note Deleted Successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		alert.tag=1;
		[alert show];
		[alert release];
		
	}
	else {
		
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"No such note exists" delegate:self cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];
		alert.tag=0;
		[alert show];
		[alert release];
	}
	
	
	
}

-(IBAction)cancel:(id)sender
{
	//UIButton *btn=(UIButton *)sender;
//    TableCell *cell=[[TableCell alloc]init];
//    int i=btn.tag;
//	//NSString *strid=[arrNid objectAtIndex:i];
//	
//	cell.txttitle.text=@"";
//	cell.txtnote.text=@"";
	
	[self.navigationController popViewControllerAnimated:YES];
	
	
	
}
-(IBAction)cancel1:(id)sender
{
		
	[self.navigationController popViewControllerAnimated:YES];
	
	
	
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objappdel.appNid=[arrNid objectAtIndex:indexPath.row];
	NSLog(@"NID%@",objappdel.appNid);
     
}
//-(IBAction)Delete{
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Are You Sure" message:@"You are about to Delete the notes associated with Medical Information " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm Note Deletio", nil];
//    [alert show];
//    [alert release];
//
//
//}
-(IBAction)DeleteCate{
	if([objappdel.strInfotype isEqualToString:@"Benefits"])
	{
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Are You Sure" message:@"You are about to delete everything  pertaining to Benefit Information " delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm",@"Cancel", nil];
		alert.tag=3;
		[alert show];
		[alert release];
		
		
	}
	else{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Are You Sure" message:@"You are about to delete everything  pertaining to Medical Information " delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm",@"Cancel", nil];
	alert.tag=3;
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
	else if(actionSheet.tag==2){
		
		if(buttonIndex==0){
			
			[self JSONDeleteNote];
		}
	}
	else {
		if(buttonIndex==0)
		[self JSONDelALl];
	}

	
}

- (void)dealloc
{
    [super dealloc];
	[tblcategory release];
	[lblMsg release];
	[lblcatogory release];
	[lblcatogory1 release];
	[lblcatogory2 release];
	[lblName release];
	[lblselct release];
	[lblselct1 release];
	[scrl release];
	[btndelete release];
	
	if(arrNid!=nil){
		
		arrNid=nil;
		[arrNid release];
		
	}
	if(arrTitle!=nil){
		
		arrTitle=nil;
		[arrTitle release];
		
	}
	if(arrNote!=nil){
		
		arrNote=nil;
		[arrNote release];
		
	}
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
