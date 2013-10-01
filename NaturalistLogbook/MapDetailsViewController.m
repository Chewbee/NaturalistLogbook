//
//  MapDetailsViewController.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 31/07/13.
//
//

#import "MapDetailsViewController.h"

@interface MapDetailsViewController ()

@end

@implementation MapDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initcontrols];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}
-(void) viewWillAppear:(BOOL)animated {
    [self initcontrols];
}

- (void)initcontrols
{
	// Do any additional setup after loading the view.
    switch ([[self mapView] mapType]) {
        case MKMapTypeStandard:
            [[self mapTypeSegmented]setSelectedSegmentIndex:0];
            break;
        case MKMapTypeSatellite:
            [[self mapTypeSegmented]setSelectedSegmentIndex:1];
            break;
        case MKMapTypeHybrid:
            [[self mapTypeSegmented]setSelectedSegmentIndex:2];
            break;
        default:
            break;
    }
    BOOL toSet = [[self mapView] userTrackingMode] == MKUserTrackingModeFollowWithHeading ;
    [[self autoOrientSwitch] setOn: toSet ];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autoOrientSwitchAction:(id)sender {
    if ([[self autoOrientSwitch] isOn] ) {
        [[self mapView] setUserTrackingMode:MKUserTrackingModeFollowWithHeading] ;
    } else  {
        [[self mapView] setUserTrackingMode:MKUserTrackingModeFollow] ;
    }
}
//
- (IBAction)mapTypeSegmentedAction:(id)sender {
    NSInteger  selected = [[self mapTypeSegmented ] selectedSegmentIndex] ;
    switch (selected) {
        case 0:
            [[self mapView]setMapType:MKMapTypeStandard] ;
            break;
        case 1:
            [[self mapView]setMapType:MKMapTypeSatellite] ;
            break;
        case 2:
            [[self mapView]setMapType:MKMapTypeHybrid] ;
            break;
        default:
            break;
    }
}
/*
- (IBAction)DoneButtonPressed:(id)sender {
    self.mapView = nil ;
    [self dismissViewControllerAnimated:TRUE completion:nil] ;
}

- (IBAction)CancelButtonPressed:(id)sender {
    self.mapView = nil ;
    [self dismissViewControllerAnimated:TRUE completion:nil] ;
}
*/
@end
