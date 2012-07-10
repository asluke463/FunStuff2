
//
//  RoomSubObjectGraphicsComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomSubObjectGraphicsComponent.h"
#import "States.h"
#import "RoomSubObject.h"
#import "RoomObject.h"
#import "Tags.h"
#import "RoomScene.h"
#import "UILayer.h"
#import "InventoryBar.h"

@implementation RoomSubObjectGraphicsComponent
@synthesize roomSubObject, currentSprite;



- (void)changeToState:(SubObjectState)state {
//    self.roomSubObject.subObjectState = state;
        //set frame
    roomSubObject.subObjectState = state;
    NSDictionary *currentStatePropertyMap = [self.roomSubObject getPropertyMapForState:state];      
    if (!currentStatePropertyMap) {
        if (state == State3 || state == State1) {
            self.currentSprite.visible = NO;
        } 
        return;
    }


    CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[self spriteFrameNameForState:state]];
  
    switch (state) {
        case State0:
        case State1:
            self.currentSprite.position = CGPointMake([(NSNumber *)[currentStatePropertyMap objectForKey:@"posX"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"posY"] floatValue]);
            break;
        case State2:
        case State3:
            if (!self.currentSprite.visible) self.currentSprite.visible = YES;
            self.currentSprite.position = CGPointMake([RoomScene screenRect].size.width/2, [RoomScene screenRect].size.height/2); // TODO
            break;
            
        default:
            break;
    }
    
    [self.currentSprite setDisplayFrame:frame];
    if (!self.currentSprite.visible) self.currentSprite.visible = YES;
    // update trueRect
    
//    NSDictionary *currentStatePropertyMap = [self.roomSubObject getPropertyMapForState:state];
    
    self.trueRect = CGRectMake([(NSNumber *)[currentStatePropertyMap objectForKey:@"realPosX"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"realPosY"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"realWidth"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"realHeight"] floatValue]);
    
    [roomSubObject Send:TouchDetectionRectChanged];
    
    if ([currentStatePropertyMap objectForKey:@"interaction"] && self.roomSubObject.isInteractable == NO) {
        [self.roomSubObject toggleInteractable];
    } else if (![currentStatePropertyMap objectForKey:@"interaction"] && self.roomSubObject.isInteractable == YES) {
        [self.roomSubObject toggleInteractable];
    }
    
    // TODO toggle collectability if it applies
    if ([currentStatePropertyMap objectForKey:@"collectable"] && self.roomSubObject.collectable == NO) {
        [self.roomSubObject toggleCollectable];
    } else if (![currentStatePropertyMap objectForKey:@"collectable"] && self.roomSubObject.collectable == YES) {
        CCLOG(@"%@", [currentStatePropertyMap objectForKey:@"collectable"]);
        [self.roomSubObject toggleCollectable];
    }
    
    // panel must be activated before other objects can be interacted with.
    if ([currentStatePropertyMap objectForKey:@"activator"]) {
        self.roomSubObject.isActivator = YES;
           } else {
//       CCLOG(@"Activator set to NO for %@", [Tags convertToStringFromObjectTag:self.roomSubObject.tag]);
        self.roomSubObject.isActivator = NO;
    }
    
    // TODO
    
   
    /*
     if ([currentStatePropertyMap objectForKey:@"linkedObject"]) {
     NSAssert([[currentStatePropertyMap objectForKey:@"linkedObject"] isKindOfClass:[NSString class] ],@"linkedObjectName is not a string type!!")
     self.linkedObjectTag = [
     }
     */
//    if ([currentStatePropertyMap objectForKey:@"linkedObject"]) {
//        
//        if (self.roomSubObject.delegate == nil) {
//            // set delegate
//            NSAssert([[currentStatePropertyMap objectForKey:@"linkedObject"] isKindOfClass:[NSString class]],@"linkedObjectName is not a string type!!");
//            self.roomSubObject.delegate = [self.roomSubObject findLinkedObjectForTag:[Tags convertToObjectTagFromString:[currentStatePropertyMap objectForKey:@"linkedObject"]]];
//        }
//    } else {
//
//    }
}

// autoreleased object
- (NSString *)spriteFrameNameForState:(SubObjectState)state {
    return [NSString stringWithFormat:@"%@_State%d.png", [Tags convertToStringFromObjectTag:self.roomSubObject.tag], state];
}



- (id)initWithRoomSubObject:(RoomSubObject *)roomSubObj {
    
    if (self = [super init]) {
        
        self.roomSubObject = roomSubObj;
        // Init the sprite on screen
        NSDictionary *currentStatePropertyMap = [roomSubObj getPropertyMapForState:State0];
        
        self.currentSprite = [CCSprite spriteWithSpriteFrameName:[self spriteFrameNameForState:State0]];
    
        self.currentSprite.position = CGPointMake([(NSNumber *)[currentStatePropertyMap objectForKey:@"posX"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"posY"] floatValue]);
        
        self.trueRect = CGRectMake([(NSNumber *)[currentStatePropertyMap objectForKey:@"realPosX"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"realPosY"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"realWidth"] floatValue], [(NSNumber *)[currentStatePropertyMap objectForKey:@"realHeight"] floatValue]);
        
        if (roomSubObj.isParentTouchDetector) {
            [roomSubObj.roomObject setTrueRectForCurrentState:self.trueRect];
        }
        
   
        
        self.zOrder = [(NSNumber *)[currentStatePropertyMap objectForKey:@"zOrder"] intValue];
        // add the sprite to the parent roomObject
        [self.roomSubObject.roomObject addChild:self.currentSprite z:self.zOrder tag:roomSubObj.tag];
    }
    
    return self;
}

+ (id)roomSubObjectGraphicsComponentWithRoomObject:(RoomSubObject *)roomSubObj {
    
    return [[[self alloc] initWithRoomSubObject:roomSubObj] autorelease];
}

- (void)toggleTouchedState {
    switch (self.roomSubObject.subObjectState) {
        case State2:
            [self changeToState:State3];
            break;
            
        case State3:
            [self changeToState:State2];
            break;
            
        default:
            break;
    }
}

- (void)changeStateToLinkChange {
    switch (self.roomSubObject.subObjectState) {
        case State0:
            [self changeToState:State1];
            break;
            
        case State1:
            [self changeToState:State0];
            break;
        
        case State2:
            [self changeToState:State3];
            break;
            
        case State3:
            [self changeToState:State2];
            break;
            
        default:
            break;
    }
    
}

- (void)toggleZoomState {
   
    if (roomSubObject.tag == spiral_P) {
        CCLOG(@"");
    } 
    switch (self.roomSubObject.subObjectState) {
        case State0:
            [self changeToState:State2];
            break;
            
        case State1: 
            [self changeToState:State3];
            break;
        case State2:
            [self changeToState:State0];
            break;
            
        case State3:
            [self changeToState:State1];
            break;
            
        default:
            break;
    }
}

- (void)objectCollected {
    CCSprite *temp = self.currentSprite;
    [temp retain];
    [self.currentSprite removeFromParentAndCleanup:YES];
    self.currentSprite = nil;
    CCLOG(@"Retain count of sprite now: %d", [temp retainCount]);
    [[RoomScene sharedRoomScene].uiLayer.inventoryBar addObjectWithSprite:temp objectTag:self.roomSubObject.tag];

//    [self.roomSubObject removeFromParentAndCleanup:YES];
}
- (void)Receive:(SignalID)signal {
    
    switch (signal) {
        case RoomObjectWasTouched:
            if (self.roomSubObject.isInteractable) {
                
            
                [self toggleTouchedState];
                if ([self.roomSubObject findLinkedObject]) {
                    [self.roomSubObject.delegate Send:LinkStateChangeHappened];
                }
            }
            break;
        case LinkStateChangeHappened:
            [self changeStateToLinkChange];
            break;
                     
         case TransitionToCloseUpStateSignal:
         case TransitionToRegularStateSignal:
            [self toggleZoomState];
            break;
            
            
        case ObjectWasCollected: 
            // add self (graphics component) to inventoryBarObject
            
            [self objectCollected];
            break;
            // remove sprite from roomobject
            // delete self from parent TODO
            // delete parent from scene

        default:
            break;
    }
}

- (void)dealloc
{
    [roomSubObject release];
    [currentSprite release];
    [super dealloc];
}

@end
