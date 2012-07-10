//
//  ActivationComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivationComponent.h"
#import "RoomObject.h"
#import "RoomSubObject.h"
@implementation ActivationComponent
@synthesize subObject;

- (void)Receive:(SignalID)signal {
    
    switch (signal) {
        case ActivatorSubObjectWasTouched:
            [self.subObject.roomObject unlockAllSubObjects];
            CCLOG(@"OBJECT WAS ACTIVATED!");
            break;
            
        default:
            break;
    }
}

- (id)initWithSubObject:(RoomSubObject *)subObj {
    if (self = [super init]) {
        self.subObject = subObj;
        [self.subObject.roomObject addLockToAllSubObjects];
        
    }
    
    return self;
}

+ (id)activationComponentWithSubObject:(RoomSubObject *)subObj {
    return [[[self alloc] initWithSubObject:subObj] autorelease];
}

- (void)dealloc
{
    [self.subObject release];
    [super dealloc];
}
@end
