//
//  ShowInformationAccordingToLocation.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-02.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventIcons.h"

/**
 This view is for showing all the information in a Location selected
 from the last view which is the Map.
 */
@interface ShowInformationAccordingToLocation : UITableViewController {
	/**
	 A place holder for Events
	 */
	NSMutableArray *eventsData;
	/**
	 A place holder for Establishments
	 */
	NSMutableArray *establishmentsData;
	/**
	 A place holder for Vending Machines
	 */
	NSMutableArray *vmachinesData;
	/**
	 The name of the location that has been selected
	 */
	NSMutableString *location;
	/**
	 The icons object which holds the images for the event types.
	 */
	EventIcons *icons;
}
@property (nonatomic, retain) NSMutableString *location;

/**
 It sends a request to the server with the location and stores
 the returened data into the eventsData
 */
-(void)parseEvents;
/**
 It sends a request to the server with the location and stores
 the returened data into the establishmentsData
 */
-(void)parseEstablishments;
/**
 It sends a request to the server with the location and stores
 the returened data into the vmachinesData
 */
-(void)parseVMachines;
/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;

@end
