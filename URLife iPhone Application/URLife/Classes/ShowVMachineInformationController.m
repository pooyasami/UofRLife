//
//  ShowVMachineInformationController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-23.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "ShowVMachineInformationController.h"
#import "EventFeedback.h"
#import "Parser.h"
#import "PostMethod.h"


@implementation ShowVMachineInformationController

@synthesize vMachineDictionary;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[self getComments];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	titlesArray = [[NSMutableArray alloc] initWithObjects:@"Location",@"Floor",@"Items",@"Card Enabled",[NSString stringWithFormat:@"Comments (%i)",[commentsArray count]],@"",nil];

}

-(void) getComments {
	NSString *post = [NSString stringWithFormat:@"action=vmachinefeedback&vmachine_id=%@", [vMachineDictionary objectForKey:@"id"]];
	PostMethod *pm = [[PostMethod alloc] init];
	NSData *data1 = [pm postThisString:post];
	
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"name",@"comment",nil] delimiter:@"feedback"];
	commentsArray = [parser parseXML];
	[parser release];
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
    return [titlesArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 4) {
		return [commentsArray count];
	}
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = @"";
	cell.detailTextLabel.text = @"";
	cell.imageView.image = nil;
	
    // Configure the cell...
	if ([indexPath section] == 0) {
		cell.textLabel.text = [vMachineDictionary objectForKey:@"location"];
		cell.imageView.image = [UIImage imageNamed:@"177-building.png"];
	}
	if ([indexPath section] == 1) {
		cell.textLabel.text = [vMachineDictionary objectForKey:@"floor"];
		cell.imageView.image = [UIImage imageNamed:@"74-location.png"];
	}
	if ([indexPath section] == 2) {
		cell.textLabel.text = [vMachineDictionary objectForKey:@"items"];
	}
	if ([indexPath section] == 3) {
		cell.textLabel.text = [vMachineDictionary objectForKey:@"card"];
		cell.imageView.image = [UIImage imageNamed:@"192-credit-card.png"];
	}
	if ([indexPath section] == 4) {
		// put the code here
		cell.textLabel.text = [[commentsArray objectAtIndex:[indexPath row]] objectForKey:@"name"];
		cell.detailTextLabel.text = [[commentsArray objectAtIndex:[indexPath row]] objectForKey:@"comment"];
		
	}
    if ([indexPath section] == 5) {
		cell.textLabel.text = @"Click to Leave Feedback";
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.imageView.image = [UIImage imageNamed:@"08-chat.png"];
	}
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [titlesArray objectAtIndex:section];
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
	
	if ([indexPath section] == 5) {
		EventFeedback *fb = [[EventFeedback alloc] initWithNibName:@"EventFeedback" bundle:nil];
		[fb setVMachineID:[vMachineDictionary objectForKey:@"id"]];
		[fb setShowVendingMachine:self];
		
		[self.navigationController pushViewController:fb animated:YES];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSMutableString *cellText = [[NSMutableString alloc] init];
	
	if ([indexPath section] == 0) {
		cellText = [vMachineDictionary objectForKey:@"location"];
	}
	if ([indexPath section] == 1) {
		cellText = [vMachineDictionary objectForKey:@"floor"];
	}
	if ([indexPath section] == 2) {
		cellText = [vMachineDictionary objectForKey:@"items"];
	}
	if ([indexPath section] == 3) {
		cellText = [vMachineDictionary objectForKey:@"card"];
	}
	if ([indexPath section] == 4) {
		// put the code here
		cellText = [[commentsArray objectAtIndex:[indexPath row]] objectForKey:@"comment"];
	}
    if ([indexPath section] == 5) {
		cellText = [NSMutableString stringWithFormat:@"%@", @"Click to Leave Feedback"];
	}
	
	UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
	CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + 20;
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

