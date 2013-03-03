//
//  LoginViewController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-18.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "LoginViewController.h"
#import "MyEventsController.h"
#import "PostMethod.h"
#import "TabBar1AppDelegate.h"
#import "Reachability.h"

@implementation LoginViewController

@synthesize username,password,eventID;

-(IBAction) registeration:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.myurlife.ca/users/add"]];
}

-(IBAction) backgroundTouched:(id)sender {
	[username resignFirstResponder];
	[password resignFirstResponder];
}

-(IBAction) login:(id)sender {
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	
	if ([self checkConnection]) {
	
		if ([self login:username.text WithPassword:password.text]) {
			if (eventID == nil) {
				MyEventsController *myEvents = [[MyEventsController alloc] initWithNibName:@"MyEventsController" bundle:nil];
			
				[myEvents setUsername:username.text];
				[myEvents setPassword:password.text];
				
				
				app.networkActivityIndicatorVisible = NO;
				[self.navigationController pushViewController:myEvents animated:YES];
				[myEvents release];
			} else {
				TabBar1AppDelegate *delegate = (TabBar1AppDelegate*)[[UIApplication sharedApplication] delegate];
				NSString *post = [NSString stringWithFormat:@"action=subscribe-unsubscribetoevent&event_id=%@&username=%@&password=%@", eventID, delegate.username, delegate.password];
				PostMethod *pm = [[PostMethod alloc] init];
				NSData *data1 = [pm postThisString:post];
				
				app.networkActivityIndicatorVisible = NO;
				[self.navigationController popViewControllerAnimated:YES];
			}
		
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong Username or Password" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}

	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	app.networkActivityIndicatorVisible = NO;
	
}

-(BOOL)login:(NSString*)userName WithPassword:(NSString*)passWord {
	
	NSString *post = [NSString stringWithFormat:@"action=login&username=%@&password=%@", userName,passWord];
	PostMethod *pm = [[PostMethod alloc] init];
	
	NSData *data = [pm postThisString:post];
	NSString *response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	if ([response isEqualToString:@"<p>You successfully logged in.</p>"]) {
		[response release];
		
		TabBar1AppDelegate *delegate = (TabBar1AppDelegate*)[[UIApplication sharedApplication]delegate];
		[delegate setUsername:[NSMutableString stringWithFormat:@"%@",userName]];
		[delegate setPassword:[NSMutableString stringWithFormat:@"%@",passWord]];
		
		return YES;
	} else {
		[response release];
		return NO;
	}
	
}

-(BOOL) checkConnection {
	Reachability* reachability = [Reachability reachabilityWithHostName:@"www.myurlife.ca"];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
	if (remoteHostStatus == NotReachable) { 
		NSLog(@"not connected.");
		return NO;
	} else {
		NSLog(@"connected.");
		return YES;
	}	
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)viewWillAppear:(BOOL)animated{
	
	TabBar1AppDelegate *delegate = (TabBar1AppDelegate*)[[UIApplication sharedApplication]delegate];
	
	if (delegate.username != nil && delegate.password != nil) {
		if ([self login:delegate.username WithPassword:delegate.password]) {
//			MyEventsController *myEvents = [[MyEventsController alloc] initWithNibName:@"MyEventsController" bundle:nil];
//			
//			[myEvents setUsername:delegate.username];
//			[myEvents setPassword:delegate.password];
//			
//			[self.navigationController pushViewController:myEvents animated:YES];
//			[myEvents release];
			
			username.text = delegate.username;
			password.text = delegate.password;
		}
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	password.secureTextEntry = YES;
    [super viewDidLoad];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Logout";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[username release];
	[password release];
}


@end
