//
//  FirstViewController.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UserLocationView.h"
#import "poiAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate >{

    IBOutlet MKMapView *mapView;
      NSMutableArray *mapAnnotations ;
    
    IBOutlet UIActivityIndicatorView *uiaiv;
   
    IBOutlet UIToolbar *toolbar ; 
    IBOutlet UIBarButtonItem *locateButton ;
    IBOutlet UIBarButtonItem *cameraButton ;
    CLLocationManager *locationManager ; 
    
    CLLocationCoordinate2D userPosition ; 
    CLLocation *userLocation ; 
    double  userHeading ; 
    
    UserLocationView *userView ; 
    
    NSTimeInterval whenHit ; 
    poiAnnotation *poi ; 

}
@property (nonatomic,retain) poiAnnotation *poi ; 
@property (nonatomic) NSTimeInterval whenHit ;
@property (nonatomic,retain) UserLocationView *userView ;
@property (nonatomic,retain) CLLocation *userLocation ; 
@property (nonatomic) double userHeading ; 
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *locateButton ;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *cameraButton ;
@property (nonatomic,retain) IBOutlet UIToolbar *toolbar ; 
@property (nonatomic, retain ) IBOutlet UIActivityIndicatorView *uiaiv;

- (IBAction)locateUser:(id)sender;
- (IBAction)triggerCamera:(id)sender;

- (void)startLocationStandardUpdates ; 

- (void) handleTouchBegan: (NSSet *) touches  ; 
- (void) handleTouchEnded: (NSSet *) touches  ; 

@end
