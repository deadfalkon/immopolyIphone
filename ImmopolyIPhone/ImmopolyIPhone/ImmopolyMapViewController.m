//
//  ImmopolyMapViewController.m
//  libOAuthDemo
//
//  Created by Maria Guseva on 26.10.11.
//  Copyright (c) 2011 Immobilienscout24. All rights reserved.
//

#import "ImmopolyMapViewController.h"
#import "FlatLocation.h"
#import "ImmopolyManager.h"
#import "Flat.h"

@implementation ImmopolyMapViewController

@synthesize mapView,adressLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {  
    // 1
    
    CLLocationCoordinate2D zoomLocation = [[[ImmopolyManager instance]actLocation]coordinate];
    
    //zoomLocation.latitude = 52.521389; //39.281516;
    //zoomLocation.longitude = 13.411944; //-76.580806;
    // 2
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    // 3
    //MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    // 4
    //[mapView setRegion:adjustedRegion animated:YES]; 
    
   // [self displayFlatsOnMap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [ImmopolyManager instance].delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) displayCurrentLocation {
    CLLocationCoordinate2D zoomLocation = [[[ImmopolyManager instance]actLocation]coordinate];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    [mapView setRegion:adjustedRegion animated:YES]; 
    
    FlatLocation *annotation = [[[FlatLocation alloc] initWithName:@"My Location" address:@"" coordinate:zoomLocation] autorelease];
    [mapView addAnnotation: annotation];
}

- (void) displayFlatsOnMap {
    
    
    /*
    for (id<MKAnnotation> annotation in mapView.annotations) {
        [mapView removeAnnotation:annotation];
    }
     */
    
    for(Flat *flat in [ImmopolyManager instance].flats) {
        
        
        NSNumber * latitude = [[NSNumber alloc] initWithDouble: flat.lat];
        NSNumber * longitude = [[NSNumber alloc] initWithDouble: flat.lng];
        NSString * title = flat.name;
        //NSString * address = flat.address;
        
        
        /*NSNumber * latitude = [NSNumber numberWithFloat: 52.521389];
        NSNumber * longitude = [NSNumber numberWithFloat: 13.411944];
        NSString * title = [NSString stringWithFormat: @"Zentrale Lage mit allem pipapo"];
        NSString * address = [NSString stringWithFormat: @"Alexanderplatz 13"];*/
    
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;            
        FlatLocation *annotation = [[[FlatLocation alloc] initWithName:title address:@"" coordinate:coordinate] autorelease];
        [mapView addAnnotation: annotation];
    
        //place another one
        /*latitude = [NSNumber numberWithFloat: 52.521111];
        longitude = [NSNumber numberWithFloat: 13.41];
        title = [NSString stringWithFormat: @"Mitten in der Stadt"];
        address = [NSString stringWithFormat: @"Panoramastraße 1"];
    
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;            
        annotation = [[[FlatLocation alloc] initWithName:title address:address coordinate:coordinate] autorelease];
        [mapView addAnnotation: annotation];
        */
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"FlatLocation";
    
    if([annotation isKindOfClass:[FlatLocation class]]) {
        FlatLocation *location = (FlatLocation *) annotation;
     
        MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
             
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
     
        //Color
        
        if([location.title compare:@"My Location"] == NSOrderedSame) {
            annotationView.pinColor = MKPinAnnotationColorGreen;
        }
        else {
            annotationView.pinColor = MKPinAnnotationColorRed;
        }
        
        return annotationView;
    }
     
    return nil;
}


@end
