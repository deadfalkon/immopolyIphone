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

@implementation UserLoginTask

@synthesize connection, data, delegate; 

-(void)dealloc{
    [connection release];
    [data release];
}

// TODO: releasing url and request (not possible?)
- (void)performLogin:(NSString *)userName password:(NSString *)password {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://immopoly.appspot.com/user/login?username=%@&password=%@",userName, password]];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    
    [self setConnection: [NSURLConnection connectionWithRequest:request delegate:self]];
    
    
    if ([self connection]) {
        [self setData: [[NSMutableData data] retain]];
    }
}

// TODO: releasing url and request (not possible?)
- (void)performLoginWithToken:(NSString *) userToken {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://immopoly.appspot.com/user/info?token=%@", userToken]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    
    [self setConnection: [NSURLConnection connectionWithRequest:request delegate:self]];
    
    
    if ([self connection]) {
        [self setData: [[NSMutableData data] retain]];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    [[self data] appendData:d];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
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
}

@end
