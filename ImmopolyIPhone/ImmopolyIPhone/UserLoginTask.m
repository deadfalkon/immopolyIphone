//
//  DataLoader.m
//  ImmopolyPrototype
//
//  Created by Tobias Buchholz on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UserLoginTask.h"
#import "JSONParser.h"
#import "ImmopolyManager.h"
#import "Constants.h"

@implementation UserLoginTask

@synthesize connection;
@synthesize data;
@synthesize delegate; 

-(void)dealloc{
    [connection release];
    [data release];
}

// TODO: releasing url and request (not possible?)
- (void)performLogin:(NSString *)_userName password:(NSString *)_password {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@login?username=%@&password=%@",urlImmopolyUser,_userName, _password]];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    
    [self setConnection: [NSURLConnection connectionWithRequest:request delegate:self]];
    
    
    if ([self connection]) {
        [self setData: [NSMutableData data]];
    }
}

// TODO: releasing url and request (not possible?)
- (void)performLoginWithToken:(NSString *)_userToken {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@info?token=%@",urlImmopolyUser,_userToken]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    
    [self setConnection: [NSURLConnection connectionWithRequest:request delegate:self]];
    
    
    if ([self connection]) {
        [self setData: [NSMutableData data]];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    [[self data] appendData:d];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)d {
    NSLog(@"didFailWithError");
    [delegate loginWithResult: NO];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([jsonString isEqualToString:@""]) {
        NSLog(@"jsonString is empty");
    }
    
    NSError *err=nil;
    [[ImmopolyManager instance] setUser:[JSONParser parseUserData:jsonString :&err]];
    
    if (err) {
        //Handle Error here
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:err forKey:@"error"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"user/login fail" object:nil userInfo:errorInfo];
        [delegate loginWithResult:NO];
    }else{
        [[ImmopolyManager instance] setLoginSuccessful:YES];
        [delegate loginWithResult: YES];
    }
    
    [jsonString release];
}

@end
