//
//  ShowEstablishmentInformationController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-07.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 It is the view for showing an establishment information
 */
@interface ShowEstablishmentInformationController : UITableViewController {
	/**
	 establishment ID
	 */
	NSMutableString *establshmentID;
	/**
	 the establishment information array
	 */
	NSMutableArray *establshmentInfoArray;
	/**
	 comments information
	 */
	NSMutableArray *commentsInfoArray;
	/**
	 pointer to the dictionary containing the information of the establishment
	 */
	NSMutableDictionary *establshmentInfoDictionary;
	/**
	 titles of the table
	 */
	NSMutableArray *tableTitles;
}

@property (nonatomic, retain) NSMutableString *establishmentID;

/**
 It sends a request and gets the result and stores it in the establishmentInfoArray
 */
-(void) getEstablishmentInfo;
/**
 It sends a request and gets the result and stores it in the commentsInfoArray
 */
-(void) getCommentInfo;
/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;

@end
