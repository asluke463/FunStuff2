//
//  RoomSubObjectGraphicsComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GraphicsComponent.h"

@class RoomSubObject;
@interface RoomSubObjectGraphicsComponent : GraphicsComponent {
    
    RoomSubObject *roomSubObject;
    CCSprite *currentSprite;
    
    
}

@property (nonatomic, assign) RoomSubObject *roomSubObject;
@property (nonatomic, retain) CCSprite *currentSprite;


+ (id)roomSubObjectGraphicsComponentWithRoomObject:(RoomSubObject *)roomSubObj;

@end
