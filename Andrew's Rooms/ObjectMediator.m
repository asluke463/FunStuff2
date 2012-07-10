//
//  ObjectMediator.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectMediator.h"
#import "GameObject.h"

@implementation ObjectMediator
@synthesize linkedObjectMap;
- (id)initWithActive:(GameObject *)activeObject passive:(GameObject *)passiveObject {
    
    if ((self = [super init])) {
        self.linkedObjectMap = [[NSDictionary alloc] initWithObjectsAndKeys:activeObject, [NSNumber numberWithInt:ActiveObject], passiveObject, [NSNumber numberWithInt:PassiveObject], nil];
    }
    return self;
}

+ (id)objectMediatorWithActive:(GameObject *)activeObject passive:(GameObject *)passiveObject {
    
    return [[[self alloc] init] autorelease];;
}

- (void)notifyObjectsOfStateChange {

    [(GameObject *)[self.linkedObjectMap objectForKey:[NSNumber numberWithInt:PassiveObject]] Send:LinkStateChangeHappened];
//    for (id obj in self.linkedObjects) {
//        if ([obj isKindOfClass:[GameObject class]]) {
//            // notifies all objects of state change - specifically a LINKED state change
//            // objects that are acted upon (such as the spiral) by the actor (the panel) respond to this message
//            [obj Send:LinkStateChangeHappened];
//        }
//    }
}

- (void)notifyObjectsOfChangeToState:(SubObjectState)state {
    
}

- (void)addObjectToMediator:(GameObject *)object {
    
//    [self.linkedObjects addObject:object]; // retains it
}

- (void)dealloc
{
    [self.linkedObjectMap release];
    [super dealloc];
}
@end
