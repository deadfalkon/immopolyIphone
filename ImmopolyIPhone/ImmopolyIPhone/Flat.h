//
//  Flat.h
//  libOAuthDemo
//
//  Created by Tobias Buchholz on 26.10.11.
//  Copyright (c) 2011 Immobilienscout24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Flat : NSObject <MKAnnotation> {

    int exposeId;
    int houseNumber;
    int numberOfRooms;
    
    double price;
    double livingSpace;
    
    long creationDate;
    
    NSString *name;
    NSString *description;
    NSString *locationNode;
    NSString *city;
    NSString *postcode;
    NSString *street;
    NSString *quarter;
    NSString *titlePictureSmall;
    NSString *currency;
    NSString *priceValue;
    NSString *priceIntervaleType;
    NSString *pictureUrl;

    CLLocationCoordinate2D coordinate;
    NSMutableArray *flatsAtAnnotation;
    UIImage *image;

}

@property(nonatomic, assign) int exposeId;
@property(nonatomic, assign) int houseNumber;
@property(nonatomic, assign) int numberOfRooms;

@property(nonatomic, assign) double price;
@property(nonatomic, assign) double livingSpace;

@property(nonatomic, assign) long creationDate;

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *description;
@property(nonatomic, retain) NSString *locationNode;
@property(nonatomic, retain) NSString *city;
@property(nonatomic, retain) NSString *postcode;
@property(nonatomic, retain) NSString *street;
@property(nonatomic, retain) NSString *quarter;
@property(nonatomic, retain) NSString *titlePictureSmall;
@property(nonatomic, retain) NSString *currency;
@property(nonatomic, retain) NSString *priceValue;
@property(nonatomic, retain) NSString *priceIntervaleType;
@property(nonatomic, retain) NSString *pictureUrl;

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain) NSMutableArray *flatsAtAnnotation;
@property(nonatomic, retain) UIImage *image;


- (id)initWithName:(NSString*)_name description:(NSString*)_description coordinate:(CLLocationCoordinate2D)_oordinate exposeId:(int)_lexposeId;


@end
