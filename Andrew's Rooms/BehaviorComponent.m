//
//  BehaviorComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BehaviorComponent.h"

@implementation BehaviorComponent
@synthesize behaviorMap;

- (id)initWithBehaviorMap:(NSDictionary *)map {
    
    if ((self = [super init])) {
        self.behaviorMap = map;
    }
    return self;
}

+ (id)behaviorComponentWithBehaviorMap:(NSDictionary *)map {
    
    return [[[self alloc] initWithBehaviorMap:map] autorelease];
}

- (void)Receive:(SignalID)signal {
    
    switch (signal) {
        case GameObjectWasTouched:
            // do behavior things
            break;
            
        default:
            break;
    }
}

- (void)dealloc
{
    
    [super dealloc];
}

@end
