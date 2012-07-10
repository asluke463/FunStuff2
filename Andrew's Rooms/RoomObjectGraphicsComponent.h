//
//  RoomObjectGraphicsComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GraphicsComponent.h"

@class RoomObject;
@interface RoomObjectGraphicsComponent : GraphicsComponent {
    
    RoomObject *roomObject;
    
}

@property (nonatomic, assign) RoomObject *roomObject;

+ (id)roomObjectGraphicsComponentWithRoomObject:(RoomObject *)roomObj;

@end
