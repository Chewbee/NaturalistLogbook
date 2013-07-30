//
//  UserLocationView.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 05/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <MapKit/MapKit.h>

@interface UserLocationView : MKAnnotationView 
{
    CLLocation *userLocation ; 
    double heading;
    
    double hdg, mhdg, phdg ;
    double x, mx, px  ;
    double y, my, py  ;
    
    double dx,sx ;
    double dy,sy ;

}

@property (nonatomic)           double heading ; 
@property (nonatomic,strong)    CLLocation *userLocation ;

-(void)drawRect:(CGRect)rect ; 

@end
