//
//  EventLocationController.m
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-26.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import "EventLocationController.h"


@implementation EventLocationController

@synthesize locationPicker, addEvent, roomField;

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

-(IBAction) backgroundTouched:(id)sender {
	[roomField resignFirstResponder];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	locationsArray = [[NSMutableArray alloc] init];
	[locationsArray addObject:@"Administration-Humanities"];
	[locationsArray addObject:@"Campion College"];
	[locationsArray addObject:@"Centre of Kinesiology"];
	[locationsArray addObject:@"Classroom Building"];
	[locationsArray addObject:@"College West"];
	[locationsArray addObject:@"Day Care"];
	[locationsArray addObject:@"Education Building"];
	[locationsArray addObject:@"First Nation University of Canada"];
	[locationsArray addObject:@"Laboratory Building"];
	[locationsArray addObject:@"Luther College"];
	[locationsArray addObject:@"Language Institute"];
	[locationsArray addObject:@"Dr. John Archer Library"];
	[locationsArray addObject:@"North Residence"];
	[locationsArray addObject:@"Research and Innovation Centre"];
	[locationsArray addObject:@"Dr. William Riddell Centre"];
	[locationsArray addObject:@"South Residence"];
	
	if (addEvent.eventLocation == nil) {
		addEvent.eventLocation = [[NSMutableString alloc] initWithString:@"Administration-Humanities"];
	} else {
		int index = 0;
		while (![[locationsArray objectAtIndex:index] isEqual:addEvent.eventLocation]) {
			index++;
		}
		[locationPicker selectRow:index inComponent:0 animated:NO];
	}
	
	if (addEvent.eventRoom != nil) {
		[roomField setText:addEvent.eventRoom];
	} 
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)]autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
	
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [locationsArray count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [locationsArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	addEvent.eventLocation = [locationsArray objectAtIndex:row];
}
-(void)done{
	NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:2];
	UITableViewCell *cell =  [[addEvent tableView]cellForRowAtIndexPath:ip];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	addEvent.eventRoom = [[NSMutableString alloc] initWithString:roomField.text];
	[self.navigationController popViewControllerAnimated:YES];
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
