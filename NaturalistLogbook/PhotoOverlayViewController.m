//
//  PhotoOverlayViewController.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 02/08/13.
//
//

#import "PhotoOverlayViewController.h"

@interface PhotoOverlayViewController ()

@end

@implementation PhotoOverlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self imagePickerController] setShowsCameraControls:FALSE] ;
        [self.imagePickerController.cameraOverlayView addSubview:self.view];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
}
-(void) viewDidAppear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animalsAction:(id)sender {
}

- (IBAction)trailsAction:(id)sender {
}

- (IBAction)marksAction:(id)sender {
}
@end
