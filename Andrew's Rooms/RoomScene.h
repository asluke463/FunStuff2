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
@class GameObject;

@interface RoomScene : CCLayer {
    BOOL isTouchForMe;
    
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
//- (void)loadGameObject:(GameObject *)gameObject;
- (void)moveGameObjectToLayer:(RoomSceneLayerTags)layerTag gameObject:(GameObject *)gameObject;
//- (void)loadCloseUpObject:(NSString *)baseName;

@end
