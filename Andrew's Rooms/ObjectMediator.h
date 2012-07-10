//
//  ObjectMediator.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "States.h"

// Adding objects to the object mediator allows them to change eachother's sprite states, by communicating through the mediator
// basically when one object goes through a state change, it notifies the other objects of the state change too
// Each level has an objectMediator, or should every object have an object mediator?

typedef enum {
    ActiveObject,
    PassiveObject,
} LinkedObjectTags;

@class GameObject;
@interface ObjectMediator : NSObject {
    
    NSDictionary *linkedObjectMap;
}

@property (nonatomic, retain) NSDictionary *linkedObjectMap; // maybe I should make this copy?? TODO

+ (id)objectMediatorWithActive:(GameObject *)activeObject passive:(GameObject *)passiveObject;

- (void)notifyObjectsOfStateChange;
- (void)notifyObjectsOfChangeToState:(SubObjectState)state;

- (void)addObjectToMediator:(GameObject *)object;
// 

@end
