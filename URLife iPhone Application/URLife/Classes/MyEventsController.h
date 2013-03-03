//
//  MyEventsController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-18.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventIcons.h"

/**
 This class is for the MyEvents view.
 */
@interface MyEventsController : UITableViewController <UITableViewDelegate> {
	/**
	 The holder for the information of events that the user owns
	 */
	NSMutableArray *data;
	/**
	 The holder for the information of events that the user has subscribed
	 */
	NSMutableArray *subscriptionData;
	/**
	 The username
	 */
	NSString *username;
	/**
	 The password
	 */
	NSString *password;
	/**
	 The names of the sections in the table
	 */
	NSMutableArray *sectionNamesArray;
	/**
	 The icons object which holds the images for the event types.
	 */
	EventIcons *icons;
}

@property (retain, nonatomic) NSString *username;
@property (retain, nonatomic) NSString *password;

/**
 It gets executed when the user taps on the new event button and pushes
 AddEventController1 on the view.
 */
-(void)goToAddNewEvent;
/**
 It gets the data for the events that the user owns and puts it in the "data"
 field.
 */
-(void) getMyEventsInfo;
/**
 It gets the data for the subscriptions that the user has done and puts it in the "subscriptionData"
 field.
 */
-(void) getSubscriptionInfo;
/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;

@end
