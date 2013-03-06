//
//  HealthVCardAppDelegate.m
//  HealthVCard
//
//  Created by Vivek Rajput on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HealthVCardAppDelegate.h"

@implementation HealthVCardAppDelegate


@synthesize window=_window,strInfotype,arrDate,sign,arrSort,strUrl;
@synthesize appUserId,flag,appUserName,actID,appActName,appNid,appStrTitle,appStrNote;
@synthesize navigationController=_navigationController,count;
@synthesize strcategory,strselect,strdate,appStrSubTitle,arrCountry,arrCountryId,strAccount_id;
@synthesize toolbar=toolbar;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
	arrSort=[[NSMutableArray alloc]init];
	strUrl=@"http://health.selectpath.ca/webservices/";
      [self.window makeKeyAndVisible];
	
	
    return YES;
}
-(void)JSON{
	//[AlertHandler showAlertForProcess];
	//start = [NSDate timeIntervalSinceReferenceDate];
	//NSString *url=[NSString stringWithFormat:@"http://openxcellaus.info/healthVcard/registration.php?LoginID=%@&Password=%@&FirstName=%@&LastName=%@&Email=%@",txtUserName.text,txtPwd.text,txtFirstNm.text,txtLastNm.text,txtEmail.text];
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://openxcellaus.info/healthVcard/CountriList.php"]];
	JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
	
	
	
}
-(void)searchResult:(NSDictionary*)dictionary{
    
    
	//[AlertHandler hideAlert];
	
	arrCountry=[[NSMutableArray alloc]init];
	arrCountryId=[[NSMutableArray alloc]init];
	
	arrCountry=[[[dictionary valueForKey:@"CountryList"]valueForKey:@"CountryName"] retain] ;
	arrCountryId=[[[dictionary valueForKey:@"CountryList"]valueForKey:@"CountryId"] retain] ;
	//[picker reloadAllComponents];
	
	
	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
	
    [super dealloc];
}

@end
