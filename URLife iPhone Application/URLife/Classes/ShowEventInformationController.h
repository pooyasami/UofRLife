//
//  ShowEventInformationController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-03.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 It is the view for showing an event information
 */
@interface ShowEventInformationController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	/**
	 Event ID
	 */
	NSMutableString *eventID;
	/**
	 It holds the information of the event
	 */
	NSMutableArray *eventInfoArray;
	/**
	 It holds the comments
	 */
	NSMutableArray *commentsInfoArray;
	/**
	 It is a pointer to the first item in the eventInfoArray
	 */
	NSMutableDictionary *eventInfoDictionary;
	/**
	 It holds the titles of the sections in the table
	 */
	NSMutableArray *tableTitles;
	/**
	 if the user has already logged in, it is true when the user
	 is subscribed and vice versa
	 */
	BOOL isSubscribed;
}

@property (nonatomic, retain) NSMutableString *eventID;

/**
 It sends a request and gets the result and stores it in the eventInfoArray
 */
-(void) getEventInfo;
/**
 It sends a request and gets the result and stores it in the commentsInfoArray
 */
-(void) getCommentInfo;
/**
 When the user taps the subscribe button, at first it checks if the user is logged in, if yes,
 it changes switches (subscribed/unsubscribed) and if not, directs it to the login view.
 */
-(BOOL) subscribeUnsubscribe;
/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;

@end
