//
//  PostMethod.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-03-04.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class uses the post method to request for the data
 and returns the response in NSData format.
 */
@interface PostMethod : NSObject {
}

/**
 This function posts the request and recieves the result.
 @param string the properly formatted string to be posted to the URL
 @return returns the response
 */

-(NSData*) postThisString:(NSString*) string;

@end
