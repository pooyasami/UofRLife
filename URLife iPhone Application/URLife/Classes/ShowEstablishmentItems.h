//
//  ShowEstablishmentItems.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-09.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This class is for showing the menu items for the establishments
 */
@interface ShowEstablishmentItems : UITableViewController {
	/**
	 The ID of the establishment
	 */
	NSMutableString *establishmentID;
	/**
	 The items array
	 */
	NSMutableArray *establishmentItemsArray;
}

@property (nonatomic, retain) NSMutableString *establishmentID;

/**
 it uses a post method to get the Items of the establishment and
 puts them in the array.
 */
-(void) getEstablishmentItmes;

@end
