//
//  FlatProvider.m
//  libOAuthDemo
//
//  Created by Tobias Heine on 26.10.11.
//  Copyright (c) 2011 Immobilienscout24. All rights reserved.
//

#import "FlatProvider.h"
#import "OAuthManager.h"
#import "JSONParser.h"
#import "ImmopolyManager.h"
#import "Constants.h"
#import "ASIHTTPRequest.h"

@implementation FlatProvider

- (void)getFlatsFromLocation:(CLLocationCoordinate2D)_location {
    OAuthManager *manager = [[OAuthManager alloc] init];
    
    NSString *url = [[NSString alloc]initWithFormat:@"%@search/radius.json?realEstateType=apartmentrent&pagenumber=1&geocoordinates=%f;%f;3.0",urlIS24API,_location.latitude,_location.longitude];
    
    ASIHTTPRequest* request = [manager grabURLInBackground:url withFormat:@"application/json" withDelegate:self];
    [request setFailedBlock:^{
        NSError *error = [request error];
        
        NSLog(@"Error: %@ for location %@",[error localizedDescription],_location);
    }];
    
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSError *err=nil;
        [[ImmopolyManager instance] setImmoScoutFlats:[JSONParser parseFlatData:responseString :&err]]; 
        
        if (err) {
            //Handle Error here
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:err forKey:@"error"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"flatProvider/parse fail" object:nil userInfo:errorInfo];
        }else{
            [[ImmopolyManager instance] callFlatsDelegate];
            NSLog(@"Response: %@",responseString);
        }
    }];
    
    [manager release];
    [url release];
}


@end
