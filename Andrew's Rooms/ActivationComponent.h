//
//  ActivationComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
@class RoomSubObject;
// add this component to a GameObject if it needs to be activated in order to interact with it
@interface ActivationComponent : NSObject <Component> {
    
    RoomSubObject *subObject;
}

@property (nonatomic, assign) RoomSubObject *subObject;

+ (id)activationComponentWithSubObject:(RoomSubObject *)subObj;
@end
