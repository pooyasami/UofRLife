//
//  ShowVMachineInformationController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-23.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This class is for showing the Vending Machines information
 */
@interface ShowVMachineInformationController : UITableViewController {
	/**
	 The holder for the Vmachine information
	 */
	NSMutableDictionary *vMachineDictionary;
	/**
	 It holds the table titles
	 */
	NSMutableArray *titlesArray;
	/**
	 it holds the information of the comments submitted for events
	 */
	NSMutableArray *commentsArray;
}

@property (nonatomic, retain) NSMutableDictionary *vMachineDictionary;

/**
 It uses the post method to query and receive the comments.
 */
-(void) getComments;

@end
