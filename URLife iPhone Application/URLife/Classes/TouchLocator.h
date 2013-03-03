//
//  TouchLocator.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-05.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class holds the information for each building.
 */
@interface TouchLocator : NSObject {
	/**
	 The name of the building
	 */
	NSMutableString *name;
	/**
	 the rectangle area of the building.
	 */
	CGRect area;
	
}

@property (nonatomic, retain) NSMutableString *name;
@property (assign) CGRect area;

/**
 It initializes the building with its name and rectangle
 @param name1 name of the building
 @param area1 the rectangle that includes the building
 */
-(id) initWithName:(NSMutableString*)name1 andRectangle:(CGRect)area1;

/**
 checks if the point is inside the rectangle
 @param point the point that we want to check if it's inside the rectangle
 @return true if the point is inside the rectangle
 */
-(BOOL) findIfThePointIsInsideTheRectangle: (CGPoint)point;


@end
