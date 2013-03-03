//
//  AddEventController1.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-22.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEventsController.h"

/**
 It is for handling the add/edit event view.
 */
@interface AddEventController1 : UITableViewController <UIAlertViewDelegate>{
	/**
	 username
	 */
	NSString *username;
	/**
	 password
	 */
	NSString *password;
	/**
	 It's for holding the titles of the table sections
	 */
	NSMutableArray *sectionsArray;
	/**
	 It holds an instance of the last view
	 */
	MyEventsController *myEvents;
	/**
	 A dictionary holding the information of the event to be added/edited
	 */
	NSDictionary *eventDictionary;
	
	/**
	 Event name
	 */
	NSMutableString *eventName;
	/**
	 Event Description
	 */
	NSMutableString *eventDescription;
	/**
	 Event Description
	 */
	NSMutableString *eventAgeRange;
	/**
	 Event Start Time
	 */	
	NSMutableString *eventStartTime;
	/**
	 Event End Time
	 */
	NSMutableString *eventEndTime;
	/**
	 Event Location
	 */
	NSMutableString *eventLocation;
	/**
	 Event Room Number
	 */
	NSMutableString	*eventRoom;
	/**
	 Event Type
	 */
	NSMutableString *eventType;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) MyEventsController *myEvents;
@property (nonatomic, retain) NSDictionary *eventDictionary;

@property (nonatomic, retain) NSString *eventName;
@property (nonatomic, retain) NSString *eventDescription;
@property (nonatomic, retain) NSString *eventAgeRange;
@property (nonatomic, retain) NSString *eventStartTime;
@property (nonatomic, retain) NSString *eventEndTime;
@property (nonatomic, retain) NSString *eventLocation;
@property (nonatomic, retain) NSMutableString *eventRoom;
@property (nonatomic, retain) NSMutableString *eventType;

/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;

@end
