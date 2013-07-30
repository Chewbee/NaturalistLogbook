//
//  poiView.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <MapKit/MapKit.h>


@interface poiView : MKAnnotationView {
    
    IBOutlet UIButton *menuButton;
}
- (IBAction)menuButtonPressed:(id)sender;

@end
