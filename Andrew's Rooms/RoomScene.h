//
//  RoomScene.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tags.h"
#import "States.h"

typedef enum {
    
    LayerTagRoomLayer,
    LayerTagCloseUpLayer,
    LayerTagUILayer,
} RoomSceneLayerTags;

typedef enum
{
    ActionTagRoomLayerZoomsIn,
    ActionTagCloseUpLayerLoads,
} RoomSceneActionTags;


@class RoomLayer;
@class CloseUpLayer;
@class UILayer;
@class RoomLoader;
@class RoomObject;

@interface RoomScene : CCLayer {
    
    RoomLoader *roomLoader;
    InteractionState interactionState;
}


@property (readonly) RoomLayer *roomLayer;
@property (readonly) CloseUpLayer *closeUpLayer;
@property (readonly) UILayer *uiLayer;
@property (nonatomic, retain) RoomLoader *roomLoader;
@property (nonatomic, assign) InteractionState interactionState;


+ (RoomScene *)sharedRoomScene;
+ (id)scene;

+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet *)touches;

+ (CGRect)screenRect;
- (void)moveRoomObjectToLayer:(RoomSceneLayerTags)layerTag roomObject:(RoomObject *)roomObject;

@end
