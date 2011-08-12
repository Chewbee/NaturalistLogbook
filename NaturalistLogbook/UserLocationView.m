//
//  UserLocationView.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 05/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserLocationView.h"

#include <math.h>
static inline double radians (double degrees) {return degrees * M_PI/180; }

@class MapViewController ; 

@implementation UserLocationView

@synthesize userLocation, heading ; 


- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation: annotation reuseIdentifier: reuseIdentifier];
    if (self != nil)
    {
        [self setBackgroundColor: [UIColor clearColor]] ;
        [self setFrame: CGRectMake(0, 0, 60, 60)] ;
        [self setOpaque: NO ];
        [self setDraggable:FALSE];
        //comment the setImage or DrawRect is not called
        //[self setImage:[UIImage imageNamed:@"cursor.png"]];
        [self setCanShowCallout:YES];
        [self setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSAssert(context !=nil, @"Context was nil") ;
    
    CGContextSetRGBStrokeColor (context,1.0f,0.0f,0.0f,1.0f) ;
    //
    CGContextSetLineWidth(context, 2.0f);
    //
    CGContextMoveToPoint(context, 15, 30);
    CGContextAddLineToPoint(context, 45, 30);
    //
    CGContextMoveToPoint(context, 30,15);
    CGContextAddLineToPoint(context, 30, 45);
    //
    CGContextStrokePath(context);
    //
    CGContextSetLineWidth(context, 4.0f);
    //
    CGContextAddArc (context,30,30,15,0,6.28,0);
    
    CGContextStrokePath(context);

    hdg = radians([self heading]) ;
    mhdg = hdg - (M_PI_2 / 2) ;
    phdg = hdg + (M_PI_2 / 2) ; 
    //
    dx = 30;
    dy = 30;
    sx = 15;
    sy = 15;
    //
    x = (sin(hdg) * dx ) + dx ;
    y = abs((cos(hdg) * dy ) - dy) ;
    //
    mx = ((sin(mhdg) * sx ) + dx ) ;
    my = (abs((cos(mhdg) * sy ) - dy)) ;
    px = ((sin(phdg) * sx ) + dx) ;
    py = (abs((cos(phdg) * sy ) - dy)) ;
    //
    CGContextSetRGBStrokeColor (context,1.0f,0.0f,0.0f,1.0f) ;
    //
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, dx,dy);
    CGContextAddLineToPoint(context, x, y);
    //
    CGContextStrokePath(context);
    //
    CGContextSetRGBStrokeColor (context,1.0f,0.0f,0.0f,1.0f) ;
    CGContextSetRGBFillColor (context,1.0f,0.0f,0.0f,1.0f) ;
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, mx, my);
    CGContextAddLineToPoint(context, x, y);
    CGContextAddLineToPoint(context, px, py);
    //
    CGContextFillPath(context);
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setHeading: [[change objectForKey:NSKeyValueChangeNewKey]doubleValue]] ;
    [self setNeedsDisplay] ; 
}

@end
