//
//  UserProfileViewController.h
//  ImmopolyIPhone
//
//  Created by Maria Guseva on 30.10.11.
//  Copyright (c) 2011 HTW Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataDelegate.h"
#import "LoginDelegate.h"
#import "LoginCheck.h"
#import "AbstractViewController.h"

@interface UserProfileViewController : AbstractViewController <UserDataDelegate> {
    
    IBOutlet UILabel *hello;
    IBOutlet UILabel *bank;
    IBOutlet UILabel *miete;
    IBOutlet UILabel *numExposes;
    IBOutlet UILabel *labelBank;
    IBOutlet UILabel *labelMiete;
    IBOutlet UILabel *labelNumExposes;
    IBOutlet UIView *badgesView;
    IBOutlet UIButton *showBadgesButton;
    BOOL bagdesViewClosed;
}

@property(nonatomic, retain) IBOutlet UILabel *hello;
@property(nonatomic, retain) IBOutlet UILabel *bank;
@property(nonatomic, retain) IBOutlet UILabel *miete;
@property(nonatomic, retain) IBOutlet UILabel *numExposes;
@property(nonatomic, retain) IBOutlet UILabel *labelBank;
@property(nonatomic, retain) IBOutlet UILabel *labelMiete;
@property(nonatomic, retain) IBOutlet UILabel *labelNumExposes;

@property(nonatomic, assign) BOOL badgesViewClosed;
@property(nonatomic, retain) IBOutlet UIView *badgesView;
@property(nonatomic, retain) IBOutlet UIButton *showBadgesButton;

- (NSString*)formatToCurrencyWithNumber:(double)number;
- (IBAction)toggleBadgesView;
- (void)displayBadges;

@end
