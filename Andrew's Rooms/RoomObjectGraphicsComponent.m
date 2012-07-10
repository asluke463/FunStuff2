//
//  RoomObjectGraphicsComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomObjectGraphicsComponent.h"
#import "RoomObject.h"
#import "RoomLayer.h"
#import "RoomScene.h"
#import "RoomSubObject.h"
#import "ComponentSignalsIDs.h"

@implementation RoomObjectGraphicsComponent

@synthesize roomObject;

- (void)changeToState:(InteractionState)state {

    if (self.gameObject.shouldBeDestroyed) return;
    [self.roomObject toggleInteractable];
    // Remove Self from parent layer and put on CloseLayer
    RoomSceneLayerTags layerToSwitchTo;
    switch (state) {
        case CloseUpState:
            layerToSwitchTo = LayerTagCloseUpLayer;
            break;
        case RegularState:
            layerToSwitchTo = LayerTagRoomLayer;
        default:
            break;
    }
    [[RoomScene sharedRoomScene] moveRoomObjectToLayer:layerToSwitchTo roomObject:self.roomObject];
    
    // update frames for each child
    CCArray *subObjects = [self.roomObject children];
    CCNode *child;
    
    if (state == CloseUpState) {
        CCARRAY_FOREACH(subObjects, child) {
            if ([child isKindOfClass:[RoomSubObject class]]) {
                RoomSubObject *subObj = (RoomSubObject *)child;
                [subObj Send:TransitionToCloseUpStateSignal];
                if (subObj.isParentTouchDetector) {
                    self.trueRect = [subObj getTrueRectForCurrentState];
                }
            }

        }
    } else if (state == RegularState) {
        CCARRAY_FOREACH(subObjects, child) {
            if ([child isKindOfClass:[RoomSubObject class]]) {            
                RoomSubObject *subObj = (RoomSubObject *)child;
                [subObj Send:TransitionToRegularStateSignal];
                if (subObj.isParentTouchDetector) {
                    self.trueRect = [subObj getTrueRectForCurrentState];
                }
            }
        }
        
    }
}


- (id)initWithRoomObject:(RoomObject *)roomObj {
    
    if (self = [super init]) {
        
        self.roomObject = roomObj;

        self.zOrder = 1; 
        if (self.roomObject.tag == background)
              self.zOrder = 0;
        
        // Add the roomObject to the roomLayer
        [self.roomObject.roomLayer addChild:self.roomObject z:self.zOrder tag:self.roomObject.tag];
        
    }
    
    return self;
}



+ (id)roomObjectGraphicsComponentWithRoomObject:(RoomObject *)roomObj {
    
    return [[[self alloc] initWithRoomObject:roomObj] autorelease];
}

- (void)Receive:(SignalID)signal {
    
    switch (signal) {
        case RoomObjectWasTouched:
            CCLOG(@"Info Bubble for tag %d should be displayed", roomObject.tag);
            // Display an info button
            break;
            
        case InfoBubbleWasTouched:
            [self changeToState:CloseUpState];
            
            // change the state
            break;
            
        case BackButtonWasTouched:
            [self changeToState:RegularState];
        default:
            break;
    }
}

@end
