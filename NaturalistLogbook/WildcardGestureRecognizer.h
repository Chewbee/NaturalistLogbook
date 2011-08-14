//
//  WildcardGestureRecognizer.h
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 14/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TouchesEventBlock)(NSSet * touches, UIEvent * event);

@interface WildcardGestureRecognizer : UIGestureRecognizer {
    TouchesEventBlock touchesBeganCallback;
    TouchesEventBlock touchesEndedCallback;
}
@property(copy) TouchesEventBlock touchesBeganCallback;
@property(copy) TouchesEventBlock touchesEndedCallback;


@end