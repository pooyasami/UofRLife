//
//  MapViewController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-17.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 It is the class that handles the events from the map and also loads the 
 proper icons on the map
 */
@interface MapViewController : UIViewController <UIScrollViewDelegate> {
	/**
	 A reference to the Scroll View
	 */
	UIScrollView *scrollV;
	/**
	 A reference to the imageView
	 */
	UIImageView *imageV;
	/**
	 Names of the locations
	 */
	NSMutableArray *locationsArray;
	/**
	 it keeps the information of the locations. It is for populating
	 the map with icons.
	 */
	NSMutableArray *locationsInfo;
	/**
	 It is the location of the legend button on the map
	 */
	CGRect legendButtonLocation;
	
}

@property (nonatomic, retain) UIScrollView *scrollV;
@property (nonatomic, retain) UIImageView *imageV;

/**
 Recieves the location info using a post method and saves it in the
 locationInfo array
 */
-(void) loadLocationsInfo;
/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;

@end
