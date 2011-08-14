//
//  poiAnnotation.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 14/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@interface poiAnnotation : NSObject <MKAnnotation >{
    CLLocationCoordinate2D coordinate ;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate ; 

@end
