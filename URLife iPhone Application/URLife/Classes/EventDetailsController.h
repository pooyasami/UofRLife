//
//  EventDetailsController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-22.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventController1.h"

/**
 It is for entering the event details (name, description, age range, type).
 */
@interface EventDetailsController : UIViewController {
	/**
	 An instance of the last view
	 */
	AddEventController1 *addEventController;
	/**
	 Textfield for Event Name
	 */
	IBOutlet UITextField *eventName;
	/**
	 Textfield from event description
	 */
	IBOutlet UITextField *eventDescription;
	/**
	 Textfield for Age Range
	 */
	IBOutlet UITextField *eventAgeRange;
	
	/**
	 Array for holding the event types
	 */
	NSMutableArray *eventTypeArray;
	/**
	 Picker view for the event type
	 */
	IBOutlet UIPickerView *eventTypePicker;
}

@property (nonatomic, retain) AddEventController1 *addEventController;
@property (nonatomic, retain) IBOutlet UITextField *eventName;
@property (nonatomic, retain) IBOutlet UITextField *eventDescription;
@property (nonatomic, retain) IBOutlet UITextField *eventAgeRange;
@property (nonatomic, retain) IBOutlet UIPickerView *eventTypePicker;

/**
 The function that first checks if the fields are not empty and then
 posts them to the server. It gets invoked when the "Done" button is
 tapped.
 */
-(void)done;
/**
 it is for releasing the keyboard.
 */
-(IBAction) backgroundClick:(id)sender;
@end
