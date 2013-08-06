//
//  MapDetailsViewController.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 31/07/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapDetailsViewController : UIViewController
{

}

@property (strong, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmented;
@property (nonatomic, strong) MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISwitch *autoOrientSwitch;
//
- (IBAction)autoOrientSwitchAction:(id)sender;
- (IBAction)mapTypeSegmentedAction:(id)sender;
@end
