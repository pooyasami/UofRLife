//
//  MyEventsController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-18.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "MyEventsController.h"
#import "TabBar1AppDelegate.h"
#import "AddEventController1.h"
#import "Parser.h"
#import "PostMethod.h"
#import "ShowEventInformationController.h"
#import "Reachability.h"

@implementation MyEventsController

@synthesize username, password;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"My Events";
	sectionNamesArray = [[NSMutableArray alloc] initWithObjects:@"My Events", @"Subscriptions", nil];
	icons = [[EventIcons alloc] init];
	
	//NSLog(@"number of items in icons = %i", [icons count]);

	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	[self getMyEventsInfo];
	[self getSubscriptionInfo];
	app.networkActivityIndicatorVisible = NO;
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithTitle:@"New Event" style:UIBarButtonItemStylePlain target:self action:@selector(goToAddNewEvent)]autorelease];
	self.navigationItem.rightBarButtonItem = addButton;

}

-(void) getMyEventsInfo {
	NSString *post = [NSString stringWithFormat:@"action=myevents&username=%@&password=%@", username,password];
	PostMethod *pm = [[PostMethod alloc] init];
	
	NSData *data1 = [pm postThisString:post];
    
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"id",@"name",@"timestart",@"timeend",@"description",@"agerange",@"location",@"room",@"event_type",nil] delimiter:@"event"];
	data = [parser parseXML];
	[parser release];
}

-(void) getSubscriptionInfo {
	NSString *post = [NSString stringWithFormat:@"action=getsubscribed&username=%@&password=%@", username,password];
	PostMethod *pm = [[PostMethod alloc] init];
	
	NSData *data1 = [pm postThisString:post];
    
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"id",@"name",@"timestart",@"timeend",@"description",@"agerange",@"location",@"room",@"event_type",nil] delimiter:@"event"];
	subscriptionData = [parser parseXML];
	[parser release];
}

-(void)goToAddNewEvent{
	AddEventController1 *addEvent = [[AddEventController1 alloc] initWithNibName:@"AddEventController1" bundle:nil];
	[addEvent setUsername:username];
	[addEvent setPassword:password];
	[addEvent setMyEvents:self];
	[self.navigationController pushViewController:addEvent animated:YES];
	[addEvent release];
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


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
		return [data count];
	} 
	
	if (section == 1) {
		return [subscriptionData count];
	}
	
	return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	if ([indexPath section] == 0) {
		[cell.textLabel setText:[[data objectAtIndex:[indexPath row]]objectForKey:@"name"]];
		[cell.detailTextLabel setText:[[data objectAtIndex:[indexPath row]]objectForKey:@"description"]];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		NSLog(@"%i",[indexPath row]);
		//cell.imageView.image = [UIImage imageNamed:@"83-calendar.png"];
		cell.imageView.image = [icons imageAccordingToEventType:[[data objectAtIndex:[indexPath row]]objectForKey:@"event_type"]];
	}
	
	if ([indexPath section] == 1) {
		[cell.textLabel setText:[[subscriptionData objectAtIndex:[indexPath row]]objectForKey:@"name"]];
		[cell.detailTextLabel setText:[[subscriptionData objectAtIndex:[indexPath row]]objectForKey:@"description"]];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		NSLog(@"%i",[indexPath row]);
		//cell.imageView.image = [UIImage imageNamed:@"83-calendar.png"];
		cell.imageView.image = [icons imageAccordingToEventType:[[subscriptionData objectAtIndex:[indexPath row]]objectForKey:@"event_type"]];
	}
	
	
	return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [sectionNamesArray objectAtIndex:section];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
	
	if ([indexPath section] == 0) {
		AddEventController1 *editEventController = [[AddEventController1 alloc] initWithNibName:@"AddEventController1" bundle:nil];
		[editEventController setEventDictionary:[data objectAtIndex:[indexPath row]]];
		[editEventController setUsername:username];
		[editEventController setPassword:password];
		[editEventController setMyEvents:self];
	
		NSLog(@"location ******** = %@",[[data objectAtIndex:[indexPath row]] objectForKey:@"location"]);
	
		[self.navigationController pushViewController:editEventController animated:YES];
		[editEventController release];
	}
	
	if ([indexPath section] == 1 && [self checkConnection]) {
		ShowEventInformationController *eic = [[ShowEventInformationController alloc] initWithNibName:@"ShowEventInformationController" bundle:nil];
		eic.eventID = [[subscriptionData objectAtIndex:[indexPath row]] objectForKey:@"id"];
		
		[self.navigationController pushViewController:eic animated:YES];
		[eic release];
	} else if (![self checkConnection]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} 

}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[username release];
	[password release];
	[data release];
}


@end

