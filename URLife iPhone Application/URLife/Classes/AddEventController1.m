//
//  AddEventController1.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-22.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "AddEventController1.h"
#import "EventDetailsController.h"
#import "EventTimeController.h"
#import "EventLocationController.h"
#import "PostMethod.h"
#import "Reachability.h"

@implementation AddEventController1

@synthesize username, password;
@synthesize eventDictionary;

@synthesize eventName;
@synthesize eventDescription;
@synthesize eventAgeRange;
@synthesize eventStartTime;
@synthesize eventEndTime;
@synthesize eventLocation;
@synthesize myEvents;
@synthesize eventRoom;
@synthesize eventType;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)]autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
	if (eventDictionary != nil) {
		eventRoom = [eventDictionary objectForKey:@"room"];
		NSLog(@"room =%@", eventRoom);
		eventName = [eventDictionary objectForKey:@"name"];
		eventDescription = [eventDictionary objectForKey:@"description"];
		eventAgeRange = [eventDictionary objectForKey:@"agerange"];
		eventStartTime = [eventDictionary objectForKey:@"timestart"];
		[eventStartTime appendString:@" +0000"];
		eventEndTime = [eventDictionary objectForKey:@"timeend"];
		[eventEndTime appendString:@" +0000"];
		eventLocation = [eventDictionary objectForKey:@"location"];	
		eventType = [eventDictionary objectForKey:@"event_type"];
		sectionsArray = [[NSMutableArray alloc] initWithObjects:@"Name / Description / Age Range / Type",@"Start / End Time",@"Location",@"               Delete",nil];
	} else {
		sectionsArray = [[NSMutableArray alloc] initWithObjects:@"Name / Description / Age Range / Type",@"Start / End Time",@"Location",nil];
	}

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) done {
	if (eventLocation != nil && eventName != nil && eventDescription != nil 
		&& eventStartTime != nil && eventEndTime != nil) {
		UIApplication *app = [UIApplication sharedApplication];
		app.networkActivityIndicatorVisible = YES;
		
		if ([self checkConnection]) {
			
			if (eventDictionary == nil) {
				NSString *post = [NSString stringWithFormat:@"action=addevent&username=%@&password=%@&location=%@&event_name=%@&event_description=%@&event_start_time=%@&event_end_time=%@&event_age_range=%@&room=%@&event_type=%@"
								  , username,password,eventLocation,eventName,eventDescription,eventStartTime,eventEndTime,eventAgeRange,eventRoom,eventType];
				PostMethod *pm = [[PostMethod alloc] init];
				NSData *data1 = [pm postThisString:post];
			} else {
				NSString *post = [NSString stringWithFormat:@"action=editevent&username=%@&password=%@&event_id=%@&location=%@&event_name=%@&event_description=%@&event_start_time=%@&event_end_time=%@&event_age_range=%@&room=%@&event_type=%@"
							  , username,password,[eventDictionary objectForKey:@"id"],eventLocation,eventName,eventDescription,eventStartTime,eventEndTime,eventAgeRange,eventRoom,eventType];
				PostMethod *pm = [[PostMethod alloc] init];
				NSData *data1 = [pm postThisString:post];
			}

			[myEvents viewDidLoad];
			[myEvents.tableView reloadData];
		
			app.networkActivityIndicatorVisible = NO;
			[self.navigationController popViewControllerAnimated:YES];
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}

		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please complete the unchecked fields." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *cellText =[[NSMutableString alloc] init];
	
	cellText =  [sectionsArray objectAtIndex:[indexPath section]];
	
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + 20;
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
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
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
    return [sectionsArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

	cell.detailTextLabel.text = @"";
	
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
	cell.imageView.image = nil;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.textColor = [UIColor blackColor];
	
    // Configure the cell...
	[cell.textLabel setText:[sectionsArray objectAtIndex:[indexPath section]]];
	if ([indexPath section] == 0) {
		cell.imageView.image = [UIImage imageNamed:@"179-notepad.png"];
		
	}
	
	if ([indexPath section] == 1) {
		cell.imageView.image = [UIImage imageNamed:@"11-clock.png"];
	}
	if ([indexPath section] == 2) {
		cell.imageView.image = [UIImage imageNamed:@"177-building.png"];
	}
	
	if ([indexPath section] == 3) {
		cell.backgroundColor = [UIColor colorWithRed:0x69/255.0 green:0x13/255.0 blue:0x13/255.0 alpha:1.0];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.imageView.image = [UIImage imageNamed:@"22-skull-n-bones.png"];
	}
		
    return cell;
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
	
	if ([indexPath section] == 0 ){
		
		EventDetailsController *eventDetails = [[EventDetailsController alloc] initWithNibName:@"EventDetailsController" bundle:nil];
		eventDetails.addEventController = self;
		[self.navigationController pushViewController:eventDetails animated:YES];
		
	} if ([indexPath section] == 1){
		EventTimeController *eventTime = [[EventTimeController alloc] initWithNibName:@"EventTimeController" bundle:nil];
		eventTime.addEvent = self;
		[self.navigationController pushViewController:eventTime animated:YES];
		
	} if ([indexPath section] == 2) {
		EventLocationController *eventLocController = [[EventLocationController alloc] initWithNibName:@"EventLocationController" bundle:nil];
		eventLocController.addEvent = self;
		[self.navigationController pushViewController:eventLocController animated:YES];
	}
	
	if ([indexPath section] == 3) {
		// add the method to do the delete event here
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Are you sure if you want to delete %@ from your events?", eventName] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
		[alert show];
		[alert release];

	}
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex == 1 && [self checkConnection]) {
			
		NSString *post = [NSString stringWithFormat:@"action=deleteevent&username=%@&password=%@&event_id=%@"
									, username,password,[eventDictionary objectForKey:@"id"]];
		PostMethod *pm = [[PostMethod alloc] init];
		NSData *data1 = [pm postThisString:post];
				
		[myEvents viewDidLoad];
		[myEvents.tableView reloadData];
		[self.navigationController popViewControllerAnimated:YES];

	} else if (buttonIndex != 0) {
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
}


@end

