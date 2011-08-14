//
//  MapViewController.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "WildcardGestureRecognizer.h"
#import "poiAnnotation.h"

@implementation MapViewController
@synthesize mapView, mapAnnotations, locateButton, toolbar ,cameraButton, uiaiv ,userLocation, userHeading, userView , whenHit, poi;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [mapView setMapType:MKMapTypeHybrid ] ;
    [self startLocationStandardUpdates ] ; 
    
    [self setWhenHit:0.0f ];
    
   
    WildcardGestureRecognizer * tapInterceptor = [[[WildcardGestureRecognizer alloc] init] autorelease] ;
    tapInterceptor.touchesBeganCallback = ^(NSSet * touches, UIEvent * event) {
        [self handleTouchBegan:touches ];
    };
    tapInterceptor.touchesEndedCallback = ^(NSSet * touches, UIEvent * event) {
        [self handleTouchEnded:touches ];
    };
    [mapView addGestureRecognizer:tapInterceptor];
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
    
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [userView release];
}


- (void)dealloc
{
    [uiaiv release];
    [locationManager release ] ; 
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
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera ] ) {
        
        NSArray *availableMedia ; 
        availableMedia = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera ] ; 
        
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
            
            
            UIImagePickerController *uipc = [[UIImagePickerController alloc ]init] ;
            if (uipc!=nil) {
                [uipc setCameraCaptureMode: UIImagePickerControllerCameraCaptureModePhoto] ;
                
                [self presentModalViewController:uipc animated:TRUE ] ;
            }
        }
    } 
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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:TRUE] ;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"didFinishPickingMediaWithInfo") ;
}

- (void) handleTouchBegan: (NSSet *) touches {
    
    if ([touches count] == 1 ) 
    {
         NSLog(@"handleTouchBegan");
        [self setWhenHit:[(UITouch*)[touches anyObject] timestamp ]];
        CGPoint where = [[touches anyObject] locationInView:mapView] ;
        CLLocationCoordinate2D coord2D = [mapView convertPoint:where toCoordinateFromView:mapView] ;
        [self setPoi:[[poiAnnotation alloc] init] ];
        [poi setCoordinate:coord2D] ;

        UIAlertView *av = [[UIAlertView alloc ]initWithTitle:@"pin creation" message:@"Do you want to drop a pin" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil ];
        [av show];
    }
}
-(void) handleTouchEnded:(NSSet *) touches {
    
//    NSTimeInterval now = [(UITouch*)[touches anyObject] timestamp ];
//    
//    if ([touches count] == 1 && now - whenHit > 3.0f ) 
//    {
//        NSLog(@"handleTouchEnded");
//        [self setWhenHit:0.0f];
//        
//        CGPoint where = [[touches anyObject] locationInView:mapView] ;
//        CLLocationCoordinate2D coord2D = [mapView convertPoint:where toCoordinateFromView:mapView] ;
//        [self setPoi:[[poiAnnotation alloc] init]];
//        [poi setCoordinate:coord2D] ;
//        
//        [mapView addAnnotation: poi];
//    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 0) {
                
        [mapView addAnnotation: [self poi]];
        [[self poi]release];
        poi = nil;
    }
}

@end
