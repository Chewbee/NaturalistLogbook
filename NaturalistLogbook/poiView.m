//
//  poiView.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "poiView.h"


@implementation poiView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation: annotation reuseIdentifier: reuseIdentifier];
    if (self != nil)
    {
        [self setBackgroundColor: [UIColor clearColor]] ;
        [self setFrame: CGRectMake(0, 0, 60, 60)] ;
        [self setOpaque: NO ];
        [self setDraggable:TRUE];
        
        [self setCanShowCallout:YES];
        [self setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
    }
    return self;
}


- (IBAction)menuButtonPressed:(id)sender {
}
@end
