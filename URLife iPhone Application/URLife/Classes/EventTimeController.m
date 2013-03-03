//
//  EventTimeController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-23.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "EventTimeController.h"


@implementation EventTimeController

@synthesize datePicker, addEvent;//, tableView;

#pragma mark -
#pragma mark View lifecycle
-(IBAction) changeStartTimeCell:(id)sender {
	
	if (selectedRow != nil) {
		if ([selectedRow row] == 0) {
			[self updateStartTime];
			
		}
		
		if ([selectedRow row] == 1) {
			[self updateEndTime];
			
		}
	}
}

-(void) updateStartTime {
	if (addEvent.eventStartTime == nil) {
		
		addEvent.eventStartTime = [[NSMutableString alloc] init];
		addEvent.eventStartTime = [NSMutableString stringWithFormat:@"%@",[self getTimeFromDatePicker]];
		NSLog(@"date from update start time = %@", addEvent.eventStartTime);
	} else {
		addEvent.eventStartTime = [self getTimeFromDatePicker];
	}
	NSLog(@"start time = %@", addEvent.eventStartTime);
	UITableViewCell *cell =  [[self tableView] cellForRowAtIndexPath:selectedRow];
	NSString *timeDetail = [[NSString alloc] initWithFormat:@"Start : %@", [addEvent.eventStartTime substringToIndex:16]];
	[cell.textLabel setText:timeDetail];
	
}

-(void) updateEndTime {
	if (addEvent.eventEndTime == nil) {
		
		addEvent.eventEndTime = [[NSMutableString alloc] init];
		addEvent.eventEndTime = [NSMutableString stringWithFormat:@"%@",[self getTimeFromDatePicker]];
		
	} else {
		addEvent.eventEndTime = [self getTimeFromDatePicker];
	}
	
	UITableViewCell *cell =  [[self tableView] cellForRowAtIndexPath:selectedRow];
	NSString *timeDetail = [[NSString alloc] initWithFormat:@"End : %@", [addEvent.eventEndTime substringToIndex:16]];
	[cell.textLabel setText:timeDetail];
	
}

-(NSString*) getTimeFromDatePicker {
	
	NSDate *selected = [datePicker date];
	NSTimeZone *timeZone = [NSTimeZone localTimeZone];
	NSInteger difference = [timeZone secondsFromGMTForDate:selected];
	NSLog(@"difference = %i", difference);
	NSTimeInterval timeInterval = difference;
	NSDate *converted = [selected dateByAddingTimeInterval:timeInterval];
	NSString *subString = [[NSString alloc] initWithFormat:@"%@", converted];
	NSLog(@"converted = %@",converted );
	return subString;

}

-(void) changeDateOnDatePicker:(NSMutableString*)input {
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"YYYY-MM-dd HH:mm:ss Z"];
	NSDate *date = [df dateFromString:input];
	NSLog(@"change date on date picker string = %@ date = %@", input, date);
	[datePicker setDate:[date dateByAddingTimeInterval:60*60*6]];

	
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	datePicker.timeZone = [NSTimeZone systemTimeZone];	
	[datePicker setDate:[[NSDate date]dateByAddingTimeInterval:60*60*24]];
	
	//tableRowsArray = [[NSMutableArray alloc] initWithObjects:@"Start",@"End", nil];
	tableRowsArray = [[NSMutableArray alloc] init];
	if (addEvent.eventStartTime != nil) {
		NSString *temp = [[NSString alloc] initWithFormat:@"Start : %@", [addEvent.eventStartTime substringToIndex:16]];
		[tableRowsArray addObject:temp];
		[temp release];
	} else {
		[tableRowsArray addObject:@"Start"];
	}

	if (addEvent.eventEndTime != nil) {
		NSString *temp = [[NSString alloc] initWithFormat:@"End : %@", [addEvent.eventEndTime substringToIndex:16]];
		[tableRowsArray addObject:temp];
		[temp release];
	} else {
		[tableRowsArray addObject:@"End"];
	}

	
	justSelected = NO;
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)]autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)done {
	if (addEvent.eventStartTime != nil && addEvent.eventEndTime != nil) {
		NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:1];
		UITableViewCell *cell =  [[addEvent tableView]cellForRowAtIndexPath:ip];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		[self.navigationController popViewControllerAnimated:YES];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Event Start Time and Event End Time should be initiated." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [tableRowsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell.textLabel setText:[tableRowsArray objectAtIndex:[indexPath row]]];
    // Configure the cell...
    
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
	
//	if ([indexPath row] == 0) {
//		if (addEvent.eventStartTime == nil) {
//			addEvent.eventStartTime = [[NSMutableString alloc] init];
//			addEvent.eventStartTime = [NSMutableString stringWithFormat:@"%@",datePicker.date];
//			NSLog(@"event start time = %@",addEvent.eventStartTime);
//						
//		} else {
//			//addEvent.eventStartTime = [[NSMutableString alloc] init];
//			addEvent.eventStartTime = [NSMutableString stringWithFormat:@"%@",datePicker.date];
//			NSLog(@"event start time = %@",addEvent.eventStartTime);
//						
//		}
//	}
//	
//	if ([indexPath row] == 1) {
//		if (addEvent.eventEndTime == nil) {
//			datePicker.timeZone = [NSTimeZone localTimeZone];
//			addEvent.eventEndTime = [[NSMutableString alloc] init];
//			addEvent.eventEndTime = [NSMutableString stringWithFormat:@"%@",datePicker.date];
//			NSLog(@"event end time = %@",addEvent.eventEndTime);
//			
//		} else {
//			addEvent.eventEndTime = [NSMutableString stringWithFormat:@"%@",datePicker.date];
//			NSLog(@"event end time = %@",addEvent.eventEndTime);
//		}
//	}
	
	selectedRow = indexPath;
	justSelected = YES;
	
	if ([indexPath row] == 0) {
		if (addEvent.eventStartTime != nil) {
			
			[self changeDateOnDatePicker:addEvent.eventStartTime];
			justSelected = NO;
		} else {
			[self updateStartTime];
		}


	}
	
	if ([indexPath row] == 1) {
		if (addEvent.eventEndTime != nil) {
			
			[self changeDateOnDatePicker:addEvent.eventEndTime];
			justSelected = NO;
		} else {
			[self updateEndTime];
		}

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

