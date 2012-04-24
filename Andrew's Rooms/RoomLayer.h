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

@class GameObject;
@interface RoomLayer : CCLayer {
    
    CGPoint roomLayerPosition;
    CGPoint lastTouchLocation;
    CGFloat startZoomScale;
    CGFloat currentPinchScale;
    CGFloat lastPinchScale;
    CGFloat lastScaleDifference;
    CGFloat currentScaleDifference;
    CGFloat currentRoomScale;
    CGFloat remainingDistanceToMaxZoom;
    CGFloat remainingDistanceToMinZoom;
    CGFloat lastRoomScale;
    CGPoint startZoomPosition;
    CGPoint lastZoomPosition;
    NSArray *gestureRecognizers;
    BOOL leftEdgeRoomWillCrossBorder;
    BOOL rightEdgeRoomWillCrossBorder;
    BOOL topEdgeRoomWillCrossBorder;
    BOOL bottomEdgeRoomWillCrossBorder;
    
    BOOL leftEdgeRoomIsAtBorder;
    BOOL rightEdgeRoomIsAtBorder;
    BOOL topEdgeRoomIsAtBorder;
    BOOL bottomEdgeRoomIsAtBorder;


    
    
    CGFloat lastScale;
    CCSprite *roomSprite;
//    CGRect backgroundRect;
}

@property (nonatomic, assign) CCSprite *roomSprite;
@property (nonatomic, retain) NSArray *gestureRecognizers; 
+ (id)roomLayerForRoomNum:(int)roomNumber;
- (void)loadGameObject:(GameObject *)gameObject;
//- (void)addRoomLayerObjectGroup:(NSString *)objBaseName groupTag:(ObjectTags)groupTag;
//- (void)addRoomLayerObjectFromDictionary:(NSString *)objectName dictionary:(NSDictionary *)objMap objectTag:(ObjectTags)objTag;

@end
