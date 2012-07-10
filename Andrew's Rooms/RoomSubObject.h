//
//  RoomSubObject.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

@class RoomObject;
@interface RoomSubObject : GameObject {
    
    SubObjectState subObjectState;
    NSDictionary *objectPropertiesMap;
    RoomObject *roomObject;
    BOOL isInteractable;
    BOOL isActivator; // means that this object must be interacted with before other subobjects can be interacted with
    BOOL isParentTouchDetector;
    id delegate;
    BOOL hasLinkedObject;
    BOOL collectable;
    ObjectTags linkedObjectTag;
    
}

@property (nonatomic, assign) SubObjectState subObjectState;
@property (nonatomic, retain) NSDictionary *objectPropertiesMap;
@property (nonatomic, assign) RoomObject *roomObject;
@property (nonatomic, assign) BOOL isParentTouchDetector;
@property (nonatomic, assign) BOOL isInteractable;
@property (nonatomic, assign) BOOL isActivator;
@property (nonatomic, assign) BOOL hasLinkedObject;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) ObjectTags linkedObjectTag;

@property (nonatomic, assign)  BOOL collectable;
+ (id)subObjectWithRoomObject:(RoomObject *)roomObj subObjectTag:(ObjectTags)subTag;
- (NSDictionary *)getPropertyMapForState:(SubObjectState)state;
- (CGRect)getBoundingBoxForCurrentState;
- (void)toggleInteractable;
- (void)addLockComponent;
- (void)addActivationComponent;
- (BOOL)hasActivationComponent;
- (BOOL)hasLockComponent;
- (BOOL)findLinkedObject;
- (void)toggleCollectable;

@end
