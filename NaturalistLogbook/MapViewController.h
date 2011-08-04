//
//  FirstViewController.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController <MKMapViewDelegate>{

    MKMapView *mapView;
    NSMutableArray *mapAnnotations ;
    
    UIToolbar *toolbar ; 
    UIBarButtonItem *locateButton ;
    UIBarButtonItem *cameraButton ;


}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *locateButton ;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *cameraButton ;
@property (nonatomic,retain) IBOutlet UIToolbar *toolbar ; 

- (IBAction)locateUser:(id)sender;
- (IBAction)triggerCamera:(id)sender;


@end
