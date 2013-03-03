//
//  EventTimeController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-23.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventController1.h"

/**
 It is for handling the start time and end time of add/edit event.
 */
@interface EventTimeController : UITableViewController <UITableViewDelegate,UIPickerViewDelegate> {
	/**
	 The date picker
	 */
	IBOutlet UIDatePicker *datePicker;
	/**
	 An instance of last view
	 */
	AddEventController1 *addEvent;
	/**
	 It holds the information of the times + dates entered
	 */
	NSMutableArray *tableRowsArray;
	
	/**
	 It holds the index for the row that it is selected
	 */
	NSIndexPath *selectedRow;
	/**
	 It is true if the table row has been just selected.
	 */
	BOOL justSelected;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) AddEventController1 *addEvent;

/**
 Checks if a row is selected and updates the row.
 */
-(IBAction) changeStartTimeCell:(id)sender;
/**
 Updates the start time and the row for it in the table.
 */
-(void) updateStartTime;
/**
 Updates the end time and the row for it in the table.
 */
-(void) updateEndTime;
/**
 It gets the date from the date picker and formats it in proper way
 */
-(NSMutableString*) getTimeFromDatePicker;
/**
 If the dates are selected, it updates the date on the picker according
 to the start and end time when a row is selected.
 @param input is the date that the date picker should show.
 
 */
-(void) changeDateOnDatePicker:(NSString*)input;

@end
