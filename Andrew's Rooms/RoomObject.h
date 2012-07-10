//
//  TestGameObject.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ComponentSignalsIDs.h"
#import "Component.h"
#import "GameObject.h"
#import "States.h"
#import "Tags.h"
// What kind of Components should this have? 
// InputComponent, GraphicsComponent (bunch of sprites, with different states, or no states), SoundComponent, possibly Physics Component. Make sure to check that the array of components are indeed components that inherit from a Component protocol

@class RoomLayer;
@interface RoomObject : GameObject {
    
    RoomLayer *roomLayer;
    NSDictionary *roomObjectPropertyMap;
    id delegate;
//    CCArray *subObjects;
}
@property (nonatomic, retain) RoomLayer *roomLayer;
@property (nonatomic, retain) NSDictionary *roomObjectPropertyMap;
@property (readonly) CCArray *subObjects;
@property (nonatomic, retain) id delegate;
//@property (nonatomic, retain) NSDictionary *baseObjectMap;

+ (id)roomObjectWithRoomLayer:(RoomLayer *)layer objectTag:(ObjectTags)objTag;
- (void)toggleInteractable;
- (void)addLockToAllSubObjects;
- (void)unlockAllSubObjects;

@end
