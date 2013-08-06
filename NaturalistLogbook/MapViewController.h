//
//  FirstViewController.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UserLocationView.h"
#import "poiAnnotation.h"
#import "poiView.h"
#import "MapDetailsViewController.h"
#import "PhotoOverlayViewController.h"


@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate ,PhotoOverlayViewControllerDelegate >
{

    IBOutlet MKMapView  *mapView;
    NSMutableArray      *mapAnnotations ;
    
    IBOutlet UIActivityIndicatorView    *uiaiv;
    IBOutlet UIButton                   *infoButton;
   
    IBOutlet UIToolbar                  *toolbar ;
    IBOutlet UIBarButtonItem            *locateButton ;
    IBOutlet UIBarButtonItem            *cameraButton ;
    
    CLLocationManager                   *locationManager ;
    CLLocationCoordinate2D              userPosition ;
    CLLocation                          *userLocation ;
    double                              userHeading ;
    
    UserLocationView                    *userView ;
    poiView                             *pv ;
    
    poiAnnotation                       *poi ;
    PhotoOverlayViewController          *povc ; 
}

@property (nonatomic,strong) poiView *pv;
@property (nonatomic,strong) poiAnnotation *poi ; 
@property (nonatomic) NSTimeInterval whenHit ;
@property (nonatomic, strong) UserLocationView *userView ;
@property (nonatomic, strong) CLLocation *userLocation ; 
@property (nonatomic) double userHeading ; 
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *locateButton ;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cameraButton ;
@property (nonatomic, strong) IBOutlet UIToolbar *toolbar ; 
@property (nonatomic, strong ) IBOutlet UIActivityIndicatorView *uiaiv ;
@property (nonatomic, strong) IBOutlet UIButton *infoButton ;

- (IBAction)locateUser:(id)sender;
- (void)startLocationStandardUpdates ; 

@end
