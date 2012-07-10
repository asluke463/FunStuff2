//
//  LockComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LockComponent.h"
#import "GameObject.h"
@implementation LockComponent
@synthesize gameObject;

- (void)Receive:(SignalID)signal {
    switch (signal) {
        case UnlockThisObject:
            [self.gameObject Send:IWasUnlocked];
            break;
            
        case LockThisObject: 
            [self.gameObject Send:IWasLocked];
            
        default:
            break;
    }
}

- (id)initWithGameObject:(GameObject *)gameObj {
    
    if (self = [super init]) {
        self.gameObject = gameObj;
        [self.gameObject Send:IWasLocked];
    }
    
    return self;
}


+ (id)lockComponentWithGameObject:(GameObject *)gameObj {
    return [[[self alloc] initWithGameObject:gameObj] autorelease];
}
         
- (void)dealloc
{
    [self.gameObject release];
    [super dealloc];
}         

@end
