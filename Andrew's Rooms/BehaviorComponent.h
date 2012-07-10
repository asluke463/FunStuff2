//
//  BehaviorComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
// TODO
// Governs all actions that objects take in response to touch and in response to other objects' behavior
@interface BehaviorComponent : NSObject <Component> {
    
    NSDictionary *behaviorMap;
}
@property (nonatomic, retain) NSDictionary *behaviorMap;
// the behavior map lists what actions it should take in each state. it also triggers events and scripts (like a purple key dropping to ground)
+ (id)behaviorComponentWithBehaviorMap:(NSDictionary *)map;
@end
