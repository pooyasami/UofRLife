//
//  ShowInformationAccordingToLocation.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-02.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "ShowInformationAccordingToLocation.h"
#import "ShowEventInformationController.h"
#import "Parser.h"
#import "PostMethod.h"
#import "ShowEstablishmentInformationController.h"
#import "ShowVMachineInformationController.h"
#import "Reachability.h"


@implementation ShowInformationAccordingToLocation

@synthesize location;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	icons = [[EventIcons alloc] init];
	
	self.title = location;
	self.navigationController.navigationBarHidden = NO;
	
	UIApplication *app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	[self parseEvents];
	[self parseEstablishments];
	[self parseVMachines];
	app.networkActivityIndicatorVisible = NO;
}

-(void)parseEvents {
	NSString *post = [NSString stringWithFormat:@"action=getevents&location=%@", location];
	PostMethod *pm = [[PostMethod alloc] init];
	NSData *data1 = [pm postThisString:post];
	[pm release];
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"id",@"name",@"timestart",@"timeend",@"description",@"agerange",@"location",@"event_type",@"room",nil] delimiter:@"event"];
	eventsData = [parser parseXML];
	[parser release];

}

-(void)parseEstablishments {
	NSString *post = [NSString stringWithFormat:@"action=getestablishments&location=%@", location];
	PostMethod *pm = [[PostMethod alloc] init];
	NSData *data1 = [pm postThisString:post];
	[pm release];
	
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"id",@"vendor",@"timeopen",@"timeclose",@"description",@"location",nil] delimiter:@"establishment"];
	establishmentsData = [parser parseXML];
	[parser release];
}

-(void)parseVMachines {
	NSString *post = [NSString stringWithFormat:@"action=getvmachines&location=%@", location];
	PostMethod *pm = [[PostMethod alloc] init];
	NSData *data1 = [pm postThisString:post];
	[pm release];
	
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"id",@"floor",@"items",@"location",@"card",nil] delimiter:@"vmachine"];
	vmachinesData = [parser parseXML];
	[parser release];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if (section == 0) {
		return [NSString stringWithFormat:@"Events (%i)", [eventsData count]];
	}
	
	if (section == 1) {
		return [NSString stringWithFormat:@"Establishments (%i)", [establishmentsData count]];
	}
	
	if (section == 2) {
		return [NSString stringWithFormat:@"Vending Machines (%i)", [vmachinesData count]];
	}
	
	return @"error";
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
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
		return [eventsData count];
	} 
	
	if (section == 1) {
		return [establishmentsData count];
	}
	
	if (section == 2) {
		return [vmachinesData count];
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
		[cell.textLabel setText:[[eventsData objectAtIndex:[indexPath row]]objectForKey:@"name"]];
		[cell.detailTextLabel setText:[[eventsData objectAtIndex:[indexPath row]]objectForKey:@"description"]];
		cell.imageView.image = [icons imageAccordingToEventType:[[eventsData objectAtIndex:[indexPath row]]objectForKey:@"event_type"]];
	}
	
	if ([indexPath section] == 1) {
		[cell.textLabel setText:[[establishmentsData objectAtIndex:[indexPath row]]objectForKey:@"vendor"]];
		[cell.detailTextLabel setText:[[establishmentsData objectAtIndex:[indexPath row]]objectForKey:@"description"]];
		cell.imageView.image = [UIImage imageNamed:@"48-fork-and-knife.png"];
	}
	
	if ([indexPath section] == 2) {
		cell.textLabel.text = [NSString stringWithFormat:@"@ Floor %@",[[vmachinesData objectAtIndex:[indexPath row]] objectForKey:@"floor"]];
		cell.detailTextLabel.text = [[vmachinesData objectAtIndex:[indexPath row]] objectForKey:@"items"];
		cell.imageView.image = [UIImage imageNamed:@"142-wine-bottle.png"];
	}
	
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
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
	
	if ([self checkConnection]) {
		if ([indexPath section] == 0) {
			ShowEventInformationController *eic = [[ShowEventInformationController alloc] initWithNibName:@"ShowEventInformationController" bundle:nil];
			//eic.eventID = [[NSMutableString alloc] init];
			eic.eventID = [[eventsData objectAtIndex:[indexPath row]]objectForKey:@"id"];
			eic.title = @"Event Details";
	
			[self.navigationController pushViewController:eic animated:YES];
		} 
	
		if ([indexPath section] == 1) {
			ShowEstablishmentInformationController *establishmentInfoCont = [[ShowEstablishmentInformationController alloc] 
																			initWithNibName:@"ShowEstablishmentInformationController" bundle:nil];
			//establishmentInfoCont.establishmentID = [[NSMutableString alloc]init];
			establishmentInfoCont.establishmentID = [[establishmentsData objectAtIndex:[indexPath row]] objectForKey:@"id"];
			establishmentInfoCont.title = @"Establishment Details";
		
			[self.navigationController pushViewController:establishmentInfoCont animated:YES];
		}
	
		if ([indexPath section] == 2) {
			ShowVMachineInformationController *vMachineInfoCont = [[ShowVMachineInformationController alloc] initWithNibName:@"ShowVMachineInformationController" bundle:nil];
			vMachineInfoCont.vMachineDictionary = [vmachinesData objectAtIndex:[indexPath row]];
		
			[self.navigationController pushViewController:vMachineInfoCont animated:YES];
		}
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
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
	
	[eventsData release];
	[establishmentsData release];
	[vmachinesData release];
	[location release];
	[icons release];
}


@end

