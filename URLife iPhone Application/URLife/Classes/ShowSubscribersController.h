//
//  ShowSubscribersController.h
//  TabBar1
//
//  Created by Developer on 11-03-22.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The view for showing the users that are subscribed to a particular event
 */
@interface ShowSubscribersController : UITableViewController {
	/**
	 The event ID of the selected event
	 */
	NSMutableString *event_id;
	/**
	 An array that holds the names of the subscribers
	 */
	NSMutableArray *subscribersArray;
	/**
	 The image for the subscribers
	 */
	UIImage *image;
}

@property (nonatomic, retain) NSMutableString *event_id;

/**
 It uses a post methods to get a list of subscribers and keeps them in 
 an array.
 */
-(void)getSubscribers;

@end
