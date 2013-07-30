//
//  poiAnnotation.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 14/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "poiAnnotation.h"


@implementation poiAnnotation

@synthesize coordinate,title ; 

- (void) setCoordinate:(CLLocationCoordinate2D)coord {
    coordinate = coord ; 
}
@end
