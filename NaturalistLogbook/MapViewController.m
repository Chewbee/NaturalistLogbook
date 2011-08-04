//
//  FirstViewController.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController
@synthesize mapView, mapAnnotations, locateButton, toolbar ,cameraButton ;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:FALSE];
    [toolbar setHidden:FALSE];
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
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

- (IBAction)locateUser:(id)sender
{
    
}
- (IBAction)triggerCamera:(id)sender {
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera]
        && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear ])
    {
        UIImagePickerController *uipc = [[UIImagePickerController alloc ]init];
        [uipc presentModalViewController:self animated:TRUE ] ;
    }
};

@end
