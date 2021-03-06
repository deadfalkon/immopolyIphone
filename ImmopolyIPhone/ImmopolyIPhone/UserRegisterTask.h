//
//  UserRegisterTask.h
//  ImmopolyIPhone
//
//  Created by Tobias Buchholz on 17.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterDelegate.h"

@interface UserRegisterTask : NSObject {
    NSURLConnection *connection;
    NSMutableData *data;
    id<RegisterDelegate>delegate;
}

@property(nonatomic, retain) NSURLConnection *connection;
@property(nonatomic, retain) NSMutableData *data;
@property(nonatomic, assign) id<RegisterDelegate>delegate;

- (void)performRegistration:(NSString *)_userName withPassword:(NSString *)_password withEmail:(NSString *)_email withTwitter:(NSString *)_twitter;

@end
