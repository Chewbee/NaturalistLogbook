//
//  FirstViewController.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"



@implementation MapViewController
@synthesize mapView, mapAnnotations, locateButton, toolbar ,cameraButton, uiaiv, bearingButton ,userLocation, userHeading, userView ;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [mapView setMapType:MKMapTypeHybrid ] ;
    
    
    [ self startLocationStandardUpdates ] ; 
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:FALSE];
    NSAssert(toolbar != NULL, @"Toolbar is NULL");
    NSAssert([toolbar superview]== [self view] , @"Tollbar is not a subview of this one");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [uiaiv release];
    uiaiv = nil;
    [bearingButton release];
    bearingButton = nil;
    
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [uiaiv release];
    [locationManager release ] ; 
    [bearingButton release];
    [userView release ];
    
    [super dealloc];
}

- (IBAction)locateUser:(id)sender
{
    [mapView setCenterCoordinate: userPosition animated:TRUE] ;
    
    MKCoordinateRegion region =  MKCoordinateRegionMakeWithDistance(userPosition , 100.0f, 100.0f);
    [mapView setRegion:region animated:TRUE];
}
- (IBAction)triggerCamera:(id)sender {
    
    UIImagePickerController *uipc = [[UIImagePickerController alloc ]init];
    [uipc presentModalViewController:self animated:TRUE ] ;
};

- (IBAction)toggleCompass:(id)sender {
    [locationManager startUpdatingHeading] ;
}

- (void)startLocationStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy: kCLLocationAccuracyBest];
    
    [locationManager setHeadingOrientation:CLDeviceOrientationFaceUp] ; 
    // Set a movement threshold for new events.
    [locationManager setDistanceFilter:kCLDistanceFilterNone ] ;
    [locationManager setHeadingFilter:kCLHeadingFilterNone] ;
    
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading] ;
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    userPosition = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
   /* // If it's a relatively recent event, turn off updates to save power
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              newLocation.coordinate.latitude,
              newLocation.coordinate.longitude);
    }
    */
    // else skip the event and process the next one.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    [self setUserHeading:theHeading] ;
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    [uiaiv setHidesWhenStopped:TRUE] ;
    [uiaiv startAnimating] ; 
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [uiaiv stopAnimating] ;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        if (userView == nil) {
            userView=[[[UserLocationView alloc] 
                       initWithAnnotation:annotation reuseIdentifier:@"user"]
                      autorelease];
            [userView setUserLocation: userLocation ] ; 
        }
        
        [self addObserver:userView forKeyPath:@"userHeading" options:NSKeyValueObservingOptionNew context:NULL] ; 
        
        return userView ; 
    }
        
    return nil;
}

@end
