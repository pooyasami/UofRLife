//
//  EventDetailsController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-22.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "EventDetailsController.h"



@implementation EventDetailsController

@synthesize addEventController;
@synthesize eventName;
@synthesize eventDescription;
@synthesize eventAgeRange;
@synthesize eventTypePicker;

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
	self.title = @"Event Details";
	
	eventTypeArray = [[NSMutableArray alloc] init];
	[eventTypeArray addObject:@"food"];
	[eventTypeArray addObject:@"party"];
	[eventTypeArray addObject:@"presentation"];
	[eventTypeArray addObject:@"fair"];
	[eventTypeArray addObject:@"sport"];
	
	if (addEventController.eventName != nil) {
		eventName.text = addEventController.eventName;
	} 
	
	if (addEventController.eventDescription != nil) {
		eventDescription.text = addEventController.eventDescription;
	}
	
	if (addEventController.eventAgeRange != nil) {
		eventAgeRange.text = addEventController.eventAgeRange;
	}
	
	
	NSLog(@"event type = %@", addEventController.eventType);
	
	if (addEventController.eventType == nil) {
		addEventController.eventType = [[NSMutableString alloc] initWithString:@"Food"];
	} else {
		int index = 0;
		while (![[eventTypeArray objectAtIndex:index] isEqual:addEventController.eventType]) {
			index++;
		}
		[eventTypePicker selectRow:index inComponent:0 animated:NO];
	}
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)]autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
	
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [eventTypeArray count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [eventTypeArray	objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	addEventController.eventType = [eventTypeArray objectAtIndex:row];
}

-(void)done{
	if (([eventName.text length] == 0) || ([eventDescription.text length] == 0)) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Event Name and Event Description cannot be empty." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		addEventController.eventName = [[NSMutableString alloc] initWithString:eventName.text];
		addEventController.eventDescription = [[NSMutableString alloc] initWithString:eventDescription.text];
		addEventController.eventAgeRange = [[NSMutableString alloc] initWithString:eventAgeRange.text];
		NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
		UITableViewCell *cell =  [[addEventController tableView]cellForRowAtIndexPath:ip];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		[self.navigationController popViewControllerAnimated:YES];
	}
}

-(IBAction) backgroundClick:(id)sender {
	[eventName resignFirstResponder];
	[eventDescription resignFirstResponder];
	[eventAgeRange resignFirstResponder];
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
	[addEventController release];
    [super dealloc];
}


@end
