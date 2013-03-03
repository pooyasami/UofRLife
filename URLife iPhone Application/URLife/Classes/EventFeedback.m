//
//  EventFeedback.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-03.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "EventFeedback.h"
#import "PostMethod.h"
#import "TabBar1AppDelegate.h"
#import "Reachability.h"


@implementation EventFeedback

@synthesize showEvent, eventID, commentTextfield, nameTextfield,passwordTextfield, showEstablishment, establishmentID, showVendingMachine, vMachineID;


-(IBAction) submitButtonPressed:(id)sender {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	if ([self checkConnection]) {
	
		if (showEvent != nil) {
			NSString *post = [NSString stringWithFormat:@"action=addeventfeedback&event_id=%@&feedback=%@&username=%@&password=%@", eventID, commentTextfield.text, nameTextfield.text, passwordTextfield.text];	
			PostMethod *pm = [[PostMethod alloc] init];	
			NSData *data1 = [pm postThisString:post];
		
			[showEvent viewDidLoad];	
			[showEvent.tableView reloadData];
		}
	
		if (showEstablishment != nil) {
			NSString *post = [NSString stringWithFormat:@"action=addestablishmentfeedback&establishment_id=%@&feedback=%@&username=%@&password=%@", establishmentID, commentTextfield.text, nameTextfield.text, passwordTextfield.text];	
			PostMethod *pm = [[PostMethod alloc] init];	
			NSData *data1 = [pm postThisString:post];
		
			[showEstablishment viewDidLoad];
			[showEstablishment.tableView reloadData];
		}
	
		if (showVendingMachine != nil) {
			NSString *post = [NSString stringWithFormat:@"action=addvmachinefeedback&vmachine_id=%@&feedback=%@&username=%@&password=%@", vMachineID, commentTextfield.text, nameTextfield.text, passwordTextfield.text];	
			PostMethod *pm = [[PostMethod alloc] init];	
			NSData *data1 = [pm postThisString:post];
		
			[showVendingMachine viewDidLoad];
			[showVendingMachine.tableView reloadData];
		}
	
	
		TabBar1AppDelegate *delegate = (TabBar1AppDelegate *)[[UIApplication sharedApplication]delegate	];
		delegate.username = [[NSMutableString alloc] initWithString:nameTextfield.text];
		delegate.password = [[NSMutableString alloc] initWithString:passwordTextfield.text];
		
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
		[self.navigationController popViewControllerAnimated:YES];
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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

-(IBAction) backgroundClick:(id)sender {
	[commentTextfield resignFirstResponder];
	[nameTextfield resignFirstResponder];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	TabBar1AppDelegate *delegate = (TabBar1AppDelegate*)[[UIApplication sharedApplication]delegate];
	nameTextfield.text = delegate.username;
	passwordTextfield.text = delegate.password;
	
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
}


@end
