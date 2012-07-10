//
//  RoomLayer.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tags.h"



typedef enum
{
	ActionTagGameLayerMovesBack,
    ActionTagRoomLayerZoomInMove,
    ActionTagRoomLayerZoomInScale,
	ActionTagGameLayerScales,
    ActionTagGameLayerMovesToOrigin,
} SceneActionTags;

typedef enum
{
	RoomLayerBackgroundSpriteTag,
    RoomLayerObjectInfoButtonTag,
	RoomLayerObjectTag,
    RoomLayerCloseUpTag,
} RoomLayerSpriteTags;

@class RoomObject;
@class ObjectMediator; // TEST CLASS TODO
@interface RoomLayer : CCLayer {
    
    NSDictionary *roomObjectProperties;
    NSMutableArray *objectMediators;
    
}

@property (nonatomic, retain) NSDictionary *roomObjectProperties;
@property (readonly) CCArray *roomObjects;
@property (nonatomic, retain) NSMutableArray *objectMediators;
+ (id)roomLayerForRoomNum:(int)roomNumber;
- (void)loadRoomObject:(RoomObject *)roomObject;
- (void)addObjectMediator:(ObjectMediator *)mediator;

@end
