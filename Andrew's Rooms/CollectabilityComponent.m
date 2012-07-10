//
//  CollectabilityComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CollectabilityComponent.h"
#import "GameObject.h"
//#import "RoomScene.h"

@implementation CollectabilityComponent
@synthesize canCollectNow, gameObj;
//@synthesize uiLayer;

- (id)initWithGameObject:(GameObject *)object {
    
    if (self = [super init]) {
        self.canCollectNow = YES;
        self.gameObj = object;
    }
    
    return self;
}



+ (id)collectabilityComponentWithObject:(GameObject *)object {
    return [[[self alloc] initWithGameObject:object] autorelease];
}

- (void)moveObjectToInventory {
//    self.gameObj.shouldBeDestroyed = YES;
//    [s
    
}


- (void)Receive:(SignalID)signal {
    
    switch (signal) {
        case ObjectWasCollected:
            self.canCollectNow = NO;
            self.gameObj.shouldBeDestroyed = YES;
//            [self.gameObj Send:
//            if (self.canCollectNow){
//                [self moveObjectToInventory];
//            }
            break;
            
        case CollectabilityWasTriggered:
            self.canCollectNow = YES;
        default:
            break;
    }
}

@end
