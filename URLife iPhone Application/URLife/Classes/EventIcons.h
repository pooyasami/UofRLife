//
//  EventIcons.h
//  TabBar1
//
//  Created by Developer on 11-03-21.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class is for handling the icons of the events in the tableviews
 */
@interface EventIcons : NSObject {
	/**
	 It is for holding the icons of the event types
	 */
	NSMutableArray *icons;
}

/**
 returns the proper image according to the type of the event
 @param type the type of the event
 @return returns the proper image according to the event type
 */
-(UIImage*) imageAccordingToEventType:(NSString*)type;

@end
