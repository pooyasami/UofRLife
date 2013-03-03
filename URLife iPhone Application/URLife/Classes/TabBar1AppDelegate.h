//
//  TabBar1AppDelegate.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-18.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 It is the delegate class for the app that holds the UITabBar view and is also a holder for username and password
 if they are already entered by the user.
*/
@interface TabBar1AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	/**
	 The username
	 */
	NSMutableString *username;
	/**
	 The password
	 */
	NSMutableString *password;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableString *username;
@property (nonatomic, retain) NSMutableString *password;


@end
