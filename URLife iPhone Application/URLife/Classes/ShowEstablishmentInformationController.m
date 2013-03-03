//
//  ShowEstablishmentInformationController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-07.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "ShowEstablishmentInformationController.h"
#import "Parser.h"
#import "PostMethod.h"
#import "ShowEstablishmentItems.h"
#import "EventFeedback.h"
#import "Reachability.h"


@implementation ShowEstablishmentInformationController

@synthesize establishmentID;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[self getEstablishmentInfo];
	[self getCommentInfo];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	establshmentInfoDictionary = [establshmentInfoArray objectAtIndex:0];
	
	tableTitles = [[NSMutableArray alloc] initWithObjects:@"Establishment Name", @"Description",
				   @"Time Open", @"Time Close",@"", [NSString stringWithFormat:@"Comments (%i)",[commentsInfoArray count]] , nil];
		
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) getEstablishmentInfo {
	NSString *post = [NSString stringWithFormat:@"action=getestablishment&establishment_id=%@", establishmentID];
	PostMethod *pm = [[PostMethod alloc] init];
	NSData *data1 = [pm postThisString:post];
	
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"id",@"vendor",@"timeopen",@"timeclose",@"description",@"location",nil] delimiter:@"establishment"];
	establshmentInfoArray = [parser parseXML];
	[parser release];
	
}
-(void) getCommentInfo {
	NSString *post = [NSString stringWithFormat:@"action=establishmentfeedback&establishment_id=%@", establishmentID];
	PostMethod *pm = [[PostMethod alloc] init];	
	NSData *data1 = [pm postThisString:post];
	
	Parser *parser = [[Parser alloc] initWithData:data1 withKeys:[[NSArray alloc]initWithObjects:@"comment",@"name",nil] delimiter:@"feedback"];
	commentsInfoArray = [parser parseXML];
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
    
	NSLog(@"number of sections = %i", [tableTitles count] + 1);
	return [tableTitles count] + 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 5) {
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
    
    // Configure the cell...
	cell.detailTextLabel.text = @"";
	cell.imageView.image = nil;
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	// @"id",@"vendor",@"timeopen",@"timeclose",@"description",@"location",nil
	
	if ([indexPath section] == 0) {
		cell.textLabel.text = [establshmentInfoDictionary objectForKey:@"vendor"];
	}
	if ([indexPath section] == 1) {
		cell.textLabel.text = [establshmentInfoDictionary objectForKey:@"description"];
	}
	if ([indexPath section] == 2) {
		cell.textLabel.text = [establshmentInfoDictionary objectForKey:@"timeopen"];
		cell.imageView.image = [UIImage imageNamed:@"11-clock.png"];
	}
	if ([indexPath section] == 3) {
		cell.textLabel.text = [establshmentInfoDictionary objectForKey:@"timeclose"];
		cell.imageView.image = [UIImage imageNamed:@"11-clock.png"];
	}
	if ([indexPath section] == 4) {
		cell.textLabel.text = @"Items/Specials";
		cell.imageView.image = [UIImage imageNamed:@"125-food.png"];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if ([indexPath section] == 5) {
		cell.textLabel.text = [[commentsInfoArray objectAtIndex:[indexPath row]] objectForKey:@"name"];
		cell.detailTextLabel.text = [[commentsInfoArray objectAtIndex:[indexPath row]] objectForKey:@"comment"];
	}
	if ([indexPath section] == 6) {
		cell.textLabel.text = @"Click to Leave Feedback";
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.imageView.image = [UIImage imageNamed:@"08-chat.png"];
	}
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if (section == 6) {
		return @"";
	}
	return [tableTitles objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *cellText =[[NSMutableString alloc] init];
	
	if ([indexPath section] == 0) {
		cellText = [establshmentInfoDictionary objectForKey:@"vendor"];
	}
	if ([indexPath section] == 1) {
		cellText = [establshmentInfoDictionary objectForKey:@"description"];
	}
	if ([indexPath section] == 2) {
		cellText = [establshmentInfoDictionary objectForKey:@"timeopen"];
	}
	if ([indexPath section] == 3) {
		cellText = [establshmentInfoDictionary objectForKey:@"timeclose"];
	}
	if ([indexPath section] == 4) {
		cellText =[NSMutableString stringWithFormat:@"%@",@"Items/Specials"];
	}
	if ([indexPath section] == 5) {
		cellText = [[commentsInfoArray objectAtIndex:[indexPath row]] objectForKey:@"comment"];
	}
	if ([indexPath section] == 6) {
		cellText =[NSMutableString stringWithFormat:@"%@",@"Click to Leave Feedback"];
		
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
	
	if ([indexPath section] == 4) {
		if ([self checkConnection]) {
			ShowEstablishmentItems *estItems = [[ShowEstablishmentItems alloc] initWithNibName:@"ShowEstablishmentItems" bundle:nil];
			[estItems setEstablishmentID:establishmentID];
			[self.navigationController pushViewController:estItems animated:YES];
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"Please connect to the Internet and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}

	}
	
	if ([indexPath section] == 6) {
		NSLog(@"go 2 feedback page");
		EventFeedback *fb = [[EventFeedback alloc] initWithNibName:@"EventFeedback" bundle:nil];
		[fb setShowEstablishment:self];
		[fb setEstablishmentID:[establshmentInfoDictionary objectForKey:@"id"]];
		//fb.title = @"Establishment Comment";
		[self.navigationController pushViewController:fb animated:YES];
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

