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

@synthesize infoButton ;
@synthesize pv ;
@synthesize mapView, mapAnnotations, locateButton, toolbar ,cameraButton, uiaiv ,userLocation, userHeading, userView , whenHit, poi;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    [mapView setMapType:MKMapTypeHybrid ] ;
    
    [self startLocationStandardUpdates ] ; 
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] 
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
    //
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self action:@selector(handleTap:)];
    [self.mapView addGestureRecognizer:tgr];
    
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
    uiaiv = nil;
    
    infoButton = nil;
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



//
- (IBAction)locateUser:(id)sender
{
    [mapView setUserTrackingMode:MKUserTrackingModeFollow animated:TRUE ];
    [mapView setCenterCoordinate: userPosition animated:TRUE] ;
    [mapView showsUserLocation] ; 
    MKCoordinateRegion region =  MKCoordinateRegionMakeWithDistance(userPosition , 100.0f, 100.0f);
    [mapView setRegion:region animated:TRUE];
}
//
- (void)startLocationStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy: kCLLocationAccuracyBest];
    //
    [locationManager setHeadingOrientation:CLDeviceOrientationFaceUp] ; 
    // Set a movement threshold for new events.
    [locationManager setDistanceFilter:2.0f ] ;
    [locationManager setHeadingFilter:2.0f] ;
    //
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
-(void) mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                         message:[error localizedFailureReason]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];
    [uiaiv stopAnimating] ;
}
//
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
    
}
//
- (MKAnnotationView *) dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier
{
    if (userView != nil && [identifier isEqualToString: @"user"] ) {
        return userView ;
    }
    return nil ;
}
//
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        if (userView == nil) {
            userView=[[UserLocationView alloc] 
                       initWithAnnotation:annotation reuseIdentifier:@"user"];
            [userView setUserLocation: userLocation ] ; 
        }
        
        [self addObserver:userView forKeyPath:@"userHeading" options:NSKeyValueObservingOptionNew context:NULL] ; 
        
        return userView ; 
    } else 
        if ([annotation isKindOfClass:[poiAnnotation class]])
        {
            if (pv == nil) {
                pv = [[poiView alloc ] initWithAnnotation:annotation reuseIdentifier:@"poi"];
            }
            return pv ; 
        }
    
    return nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage    *im = [info valueForKey: UIImagePickerControllerOriginalImage ]  ;
    CGImageRef cim = [im CGImage] ;
    

    ALAssetsLibraryWriteImageCompletionBlock completionBlock = ^(NSURL *assetURL, NSError *error)
    {
        if (error)
        {
            NSLog(@"Error %@ : %@ ", error.localizedDescription, error.localizedFailureReason) ;
        }
        else NSLog(@" %@ ",assetURL.absoluteString);
    };

    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cim orientation:[im imageOrientation] completionBlock:completionBlock ]  ;
    // next line added or it stays
    [picker dismissViewControllerAnimated:TRUE completion:nil] ;
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        return;

    CGPoint where = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D coord2D = [mapView convertPoint:where toCoordinateFromView:mapView] ;
    [self setPoi:[[poiAnnotation alloc] init]];
    [poi setCoordinate:coord2D] ;
    [self.mapView addAnnotation:poi];
}

- (void)handleTap:(UITapGestureRecognizer *)sender 
{     
    if (sender.state == UIGestureRecognizerStateEnded)
    {             
    } 
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
}
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"photo"]) {
        UIImagePickerController *uiipc = (UIImagePickerController*) segue.destinationViewController ;

        [uiipc setDelegate: (id)self ];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
            [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            [uiipc setSourceType:UIImagePickerControllerSourceTypeCamera] ;
            [uiipc setCameraDevice:UIImagePickerControllerCameraDeviceRear];
            [uiipc setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff] ;
            [uiipc setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto] ;
        }
    }
}
@end
