//
//  EventLocationController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-26.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventController1.h"

/**
 This view is for add/edit information about the location and the room number of the 
 event.
 */
@interface EventLocationController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	/**
	 The pickerview for the location
	 */
	IBOutlet UIPickerView *locationPicker;
	/**
	 An instance of the last view
	 */
	AddEventController1 *addEvent;
	/**
	 It's an array that holds the location names.
	 */
	NSMutableArray *locationsArray;
	
	/**
	 the textfield for the room number
	 */
	IBOutlet UITextField *roomField;
}

@property (nonatomic, retain) IBOutlet UIPickerView *locationPicker;
@property (nonatomic, retain) AddEventController1 *addEvent;
@property (nonatomic, retain) IBOutlet UITextField *roomField;

/**
 It hides the keyboard when the background is touched.
 */
-(IBAction) backgroundTouched:(id)sender;

@end
