//
//  LoginViewController.h
//  TabBar1
//
//  Created by Pooya Samizadeh-Yazd on 11-02-18.
//  Copyright 2011 University of Regina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This class is for handling the Login view for MyEvents and Subscription.
 */
@interface LoginViewController : UIViewController {
	/**
	 the textfield for username
	 */
	IBOutlet UITextField *username;
	/**
	 the textfield for password
	 */
	IBOutlet UITextField *password;
	/**
	 the event ID if it is coming from the Subscription page.
	 */
	NSMutableString *eventID;
	
}

@property (nonatomic,retain) IBOutlet UITextField *username;
@property (nonatomic,retain) IBOutlet UITextField *password;
@property (nonatomic, retain) NSMutableString *eventID;

/**
 This function checks the username and password from the textfields and gets 
 executed when the user presses the submit button.
 @param sender the action coming from the button
 */
-(IBAction) login:(id)sender;
/**
 It's a function that checks the username and password and returns true
 if they are right. It posts the credentials and gets the respond.
 @param userName username
 @param passWord password
 @return returns true if the credentials are right
 */
-(BOOL)login:(NSString*)userName WithPassword:(NSString*)passWord;

/**
 It is for releasing the keyboard.
 */
-(IBAction) backgroundTouched:(id)sender;
/**
 It checks if there is internet connection.
 @return true if there is internet connection
 */
-(BOOL) checkConnection;
/**
 It redirects the user to the registration page on the website.
 */
-(IBAction) registeration:(id)sender;

@end
