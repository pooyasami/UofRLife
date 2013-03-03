//
//  ShowEventInformationController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-03.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "ShowEventInformationController.h"
#import "EventFeedback.h"
#import "Parser.h"
#import "PostMethod.h"
#import "TabBar1AppDelegate.h"
#import <EventKit/EventKit.h>
#import "LoginViewController.h"
#import "ShowSubscribersController.h"
#import "Reachability.h"

@implementation ShowEventInformationController

@synthesize eventID;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	[self getEventInfo];
	[self getCommentInfo];
	app.networkActivityIndicatorVisible = NO;
	
	
	//NSLog(@"event info array count = %d", [eventInfoArray count]);
	if ([eventInfoArray count] == 1) {
		eventInfoDictionary = [eventInfoArray objectAtIndex:0];
		tableTitles = [[NSMutableArray alloc] initWithObjects:@"Event Name", @"Description",
					   @"Start Time", @"End Time", @"Room", @"Location" ,@"Age Range",[NSString stringWithFormat:@"Comments (%i)",[commentsInfoArray count]], nil];
		isSubscribed = [self subscribeUnsubscribe];
	}
}

-(void) getEventInfo {
	NSString *post = [NSString stringWithFormat:@"action=getevent&event_id=%@", eventID];
	PostMethod *pm = [[PostMethod alloc] init];
	NSData *data1 = [pm postThisString:post];
	
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"id",@"name",@"timestart",@"timeend",@"description",@"agerange",@"location",@"room",nil] delimiter:@"event"];
	eventInfoArray = [parser parseXML];
	[parser release];
}

-(void) getCommentInfo {
	NSString *post = [NSString stringWithFormat:@"action=eventfeedback&event_id=%@", eventID];
	PostMethod *pm = [[PostMethod alloc] init];
	NSData *data1 = [pm postThisString:post];
		
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"comment",@"name",nil] delimiter:@"feedback"];
	commentsInfoArray = [parser parseXML];
	[parser release];
	
}

-(BOOL) subscribeUnsubscribe {
	
	TabBar1AppDelegate *delegate = (TabBar1AppDelegate*)[[UIApplication sharedApplication]delegate];
	if (delegate.username != nil) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
		NSString *post = [NSString stringWithFormat:@"action=issubscribed&event_id=%@&username=%@", eventID,delegate.username];
		PostMethod *pm = [[PostMethod alloc] init];
		NSData *data1 = [pm postThisString:post];
		
		NSString *result = [[NSString alloc] initWithData:data1 encoding:NSASCIIStringEncoding];
		
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		if ([result isEqual:@"subscribed"]) {
			return YES;
		} else {
			return NO;
		}
	} else {
		return NO;
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
    return [tableTitles count] + 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 7) {
		return [commentsInfoArray count];
	} else {
		return 1;
	}
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.detailTextLabel.text = @"";
	cell.imageView.image = nil;
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	
	if ([indexPath section] == 0) {
		cell.textLabel.text = [eventInfoDictionary objectForKey:@"name"];
	}
	
	if ([indexPath section] == 1) {
		cell.textLabel.text = [eventInfoDictionary objectForKey:@"description"];
	}
	if ([indexPath section] == 2) {
		cell.textLabel.text = [[eventInfoDictionary objectForKey:@"timestart"] substringToIndex:16];
		cell.imageView.image = [UIImage imageNamed:@"11-clock.png"];
	}
	if ([indexPath section] == 3) {
		cell.textLabel.text = [[eventInfoDictionary objectForKey:@"timeend"] substringToIndex:16];
		cell.imageView.image = [UIImage imageNamed:@"11-clock.png"];
	}
	if ([indexPath section] == 4) {
		cell.textLabel.text = [eventInfoDictionary objectForKey:@"room"];
		cell.imageView.image = [UIImage imageNamed:@"74-location.png"];
	} 
	if ([indexPath section] == 5) {
		cell.textLabel.text = [eventInfoDictionary objectForKey:@"location"];
		cell.imageView.image = [UIImage imageNamed:@"177-building.png"];
	}
	if ([indexPath section] == 6){
		cell.textLabel.text = [eventInfoDictionary objectForKey:@"agerange"];
	}
	
	if ([indexPath section] == 7) {
		cell.textLabel.text = [[commentsInfoArray objectAtIndex:[indexPath row]] objectForKey:@"name"];
		cell.detailTextLabel.text = [[commentsInfoArray objectAtIndex:[indexPath row]] objectForKey:@"comment"];
	} 
	if ([indexPath section] == 8) {
		cell.textLabel.text = @"Click to Leave Feedback";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.imageView.image = [UIImage imageNamed:@"08-chat.png"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if ([indexPath section] == 9) {
		cell.textLabel.text = @"Add Event To Calendar";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.imageView.image = [UIImage imageNamed:@"83-calendar.png"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} 
	
	if ([indexPath section] == 10) {
		cell.textLabel.text = @"Subscribe/Unsubscribe";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.imageView.image = [UIImage imageNamed:@"117-todo.png"];
		
		if (isSubscribed) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			NSLog(@"is subscribed.");
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}

	} 
	
	if ([indexPath section] == 11) {
		cell.textLabel.text = @"Who's Attending";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.imageView.image = [UIImage imageNamed:@"112-group.png"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
	
	return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if (section == 8 || section == 9 || section == 10 || section == 11) {
		return @"";
	}
	return [tableTitles objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *cellText =[[NSMutableString alloc] init];
	
	if ([indexPath section] == 0) {
		cellText =  [eventInfoDictionary objectForKey:@"name"];
	}
	
	if ([indexPath section] == 1) {
		cellText =  [eventInfoDictionary objectForKey:@"description"];
	}
	if ([indexPath section] == 2) {
		cellText =  [eventInfoDictionary objectForKey:@"timestart"];
	}
	if ([indexPath section] == 3) {
		cellText =  [eventInfoDictionary objectForKey:@"timeend"] ;
	}
	if ([indexPath section] == 4) {
		cellText =  [eventInfoDictionary objectForKey:@"room"];
	}
	if ([indexPath section] == 5) {
		cellText = [eventInfoDictionary objectForKey:@"location"];
	}
	if ([indexPath section] == 6) {
		cellText = [eventInfoDictionary objectForKey:@"agerange"];
	}
	if ([indexPath section] == 7) {
		cellText = [[commentsInfoArray objectAtIndex:[indexPath row]] objectForKey:@"comment"];
	}
	if ([indexPath section] == 8) {
		cellText = [NSMutableString stringWithFormat:@"%@",@"Click to Leave Feedback"];
	}
	if ([indexPath section] == 9) {
		
		cellText = [NSMutableString stringWithFormat:@"%@",@"Add Event To Calendar"];
	}
	if ([indexPath section] == 10) {
		
		cellText = [NSMutableString stringWithFormat:@"%@",@"Subscribe/Unsubscribe"];
	} 
	
	if ([indexPath section] == 11) {
		cellText = [NSMutableString stringWithFormat:@"%@",@"Who's Attending"];
	}
	
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + 20;
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
	
	if ([indexPath section] == 8) {
		NSLog(@"go 2 feedback page");
		EventFeedback *fb = [[EventFeedback alloc] initWithNibName:@"EventFeedback" bundle:nil];
		[fb setShowEvent:self];
		[fb setEventID:eventID];
		fb.title = @"Event Comment";
		[self.navigationController pushViewController:fb animated:YES];
	}
	if ([indexPath section] == 9) {
		NSLog(@"add event to calendar is selected");
		EKEventStore *eventStore = [[EKEventStore alloc] init];
		
		EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
		event.title     = [eventInfoDictionary objectForKey:@"name"];
		
		
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
		
		NSDate *startDate = [df dateFromString:[eventInfoDictionary objectForKey:@"timestart"]];
		NSDate *endDate = [df dateFromString:[eventInfoDictionary objectForKey:@"timeend"]];
		
		event.startDate = startDate;
		event.endDate = endDate;
//		for testing
//		NSLog(@"String start date = %@ end date = %@",[eventInfoDictionary objectForKey:@"timestart"], [eventInfoDictionary objectForKey:@"timeend"]);
//		NSLog(@"start date = %@ end date = %@", [df dateFromString:[eventInfoDictionary objectForKey:@"timestart"]], [df dateFromString:[eventInfoDictionary objectForKey:@"timeend"]]);
//		NSLog(@"event.startdate = %@ event.enddate = %@", event.startDate, event.endDate);
//		
		[event setCalendar:[eventStore defaultCalendarForNewEvents]];
		NSError *err;
		[eventStore saveEvent:event span:EKSpanThisEvent error:&err];  
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:[[NSString alloc] initWithFormat:@"Event %@ has been added to your Calendar.", [eventInfoDictionary objectForKey:@"name"]]delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
	
	if ([indexPath section] == 10) {
		NSLog(@"subscribe");
		TabBar1AppDelegate *delegate = (TabBar1AppDelegate*)[[UIApplication sharedApplication] delegate];
		if (delegate.username == nil || delegate.password == nil) {
			LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
			loginVC.eventID = [eventInfoDictionary objectForKey:@"id"];
			[self.navigationController pushViewController:loginVC animated:YES];
		} else {
			
			if ([self checkConnection]) {
				
				[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
				NSString *post = [NSString stringWithFormat:@"action=subscribe-unsubscribetoevent&event_id=%@&username=%@&password=%@", eventID, delegate.username, delegate.password];
				PostMethod *pm = [[PostMethod alloc] init];
				NSData *data1 = [pm postThisString:post];
				[tableView deselectRowAtIndexPath:indexPath animated:YES];
				isSubscribed = [self subscribeUnsubscribe];
			
			
				if (isSubscribed) {
					[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
				} else {
					[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
				}
			
				[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			} else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}

		}

	}
	
	if ([indexPath section] == 11) {
		if ([self checkConnection]) {
			
			NSLog(@"get all subscribers");
			ShowSubscribersController *subs = [[ShowSubscribersController alloc] initWithNibName:@"ShowSubscribersController" bundle:nil];
			subs.event_id = eventID;
			subs.title = @"Who's Attending";
			[self.navigationController pushViewController:subs animated:YES];
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
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

