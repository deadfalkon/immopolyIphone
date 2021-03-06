//
//  AppDelegate.h
//  ImmopolyIPhone
//
//  Created by Tobias Heine on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CoreLocationController.h"
#import "CustomTabBarController.h"
#import "LoginCheck.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate, CoreLocationControllerDelegate, UITabBarControllerDelegate, UserDataDelegate, LoginDelegate, NotifyViewDelegate> {
    
    // for getting phone coordinates
    CoreLocationController *CLController;
    CLGeocoder *geocoder;
    LoginCheck *loginCheck;
    UIViewController *selectedViewController;
}

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) CustomTabBarController *tabBarController;

@property(nonatomic, retain) CoreLocationController *CLController;
@property(nonatomic, retain) CLGeocoder *geocoder;
@property(nonatomic, retain) IBOutlet UILabel *adressLabel;

@property(nonatomic, retain) UIViewController *selectedViewController;


- (void)startLocationUpdate;
- (void)geocodeLocation:(CLLocation *)_location;
- (void)handleHistoryResponse:(NSNotification *)_notification;
- (void)handleErrorMsg:(NSNotification *)_notification;
- (void)enableAutomaticLogin;

-(void) showLoginViewController;
-(void) tryLoginWithToken;

@end
