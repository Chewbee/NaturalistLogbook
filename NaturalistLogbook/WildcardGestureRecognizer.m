//
//  WildcardGestureRecognizer.m
//  NaturalistLogbook
//
//  Created by Georges-Henry Portefait on 14/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WildcardGestureRecognizer.h"

@implementation WildcardGestureRecognizer
@synthesize touchesBeganCallback ;
@synthesize touchesEndedCallback ;

-(id) init{
    if ((self = [super init]))
    {
        self.cancelsTouchesInView = NO;
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touchesBeganCallback)
        touchesBeganCallback(touches, event);
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touch Moved %lu", (unsigned long)[[event allTouches] count]);
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touchesEndedCallback)
        touchesEndedCallback(touches, event);
    

    NSLog(@"Touches ended") ;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches cancelled");
}

- (void)reset
{
}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event
{
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return NO;
}

@end