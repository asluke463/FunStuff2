//
//  RoomLayer.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomLayer.h"
#import "RoomScene.h"
#import "RoomLoader.h"
#import "RoomObject.h"
#import "RoomSubObject.h"
#import "ObjectMediator.h"
//#define CLOSEUP_SCALE 1.0
//#define REGULAR_MAX_SCALE 0.5
//#define REGULAR_MIN_SCALE 0.25
#define REGULAR_MAX_SCALE 1.0
#define REGULAR_MIN_SCALE 0.5
#define MAX_ZOOM_Y_POS 80.0


@implementation RoomLayer

@synthesize roomObjectProperties, objectMediators;

-(CCArray*) roomObjects
{
	CCArray *children = [self children];
    
    NSMutableArray *temp = [NSMutableArray array];
    CCNode *node;
    CCARRAY_FOREACH(children, node) {
        
        if ([node isKindOfClass:[RoomObject class]]) {
            [temp addObject:((RoomObject *)node)];
        }
    }
	return [CCArray arrayWithNSArray:temp];
}

- (void)addObjectMediator:(ObjectMediator *)mediator {
    
    [self.objectMediators addObject:mediator];
}

- (id)initRoomLayerForRoomNum:(int)roomNumber {
    
    if ((self = [super init])) {
        self.scale = REGULAR_MIN_SCALE;        
        [[RoomScene sharedRoomScene].roomLoader loadAssetsForRoom:roomNumber roomLayer:self];
        self.objectMediators = [[NSMutableArray alloc] init];
            
    }
    return self;
}


+ (id)roomLayerForRoomNum:(int)roomNumber {
    
    return [[[self alloc] initRoomLayerForRoomNum:roomNumber] autorelease];
}

- (void)loadRoomObject:(RoomObject *)roomObject {
    
    self.visible = YES;
    [self addChild:roomObject z:1 tag:roomObject.tag];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recog {

    if (!self.visible) return;
    
  if (recog.state == UIGestureRecognizerStateChanged || recog.state == UIGestureRecognizerStateEnded) {

      CGRect backgroundBox = [[[self getChildByTag:background] getChildByTag:background_background] boundingBox];
   
      CGPoint moveTo = [recog translationInView:recog.view];

      // Restrict panning to horizontal axis only
      moveTo.y = 0;

      CGPoint futureRoomSpriteAbsoluteLeftEdge = [self convertToWorldSpace:ccpAdd(backgroundBox.origin, moveTo)];

      CGPoint futureRoomSpriteAbsoluteRightEdge = [self convertToWorldSpace:ccpAdd(CGPointMake((backgroundBox.origin.x + backgroundBox.size.width), backgroundBox.origin.y), moveTo)];  

       if ((futureRoomSpriteAbsoluteLeftEdge.x > 0) || (futureRoomSpriteAbsoluteRightEdge.x <  [RoomScene screenRect].size.width)) {
          moveTo.x = 0;

      }
      self.position = ccpAdd(self.position, moveTo);
      [recog setTranslation:CGPointZero inView:recog.view];
  } 

}



- (void)enableGestureRecognizers {
    
    NSArray *gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
    for (UIGestureRecognizer *gestRect in gestureRecognizers) {
        if ([gestRect isKindOfClass:[UIPinchGestureRecognizer class]] || 
            [gestRect isKindOfClass:[UITapGestureRecognizer class]]) {
            if (!gestRect.enabled)
                gestRect.enabled = YES;
        } 
    }
    
}

- (void)regularZoomIn:(CGPoint)touchLocation {
    
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    NSArray *gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
    for (UIGestureRecognizer *gestRect in gestureRecognizers) {
        if ([gestRect isKindOfClass:[UIPinchGestureRecognizer class]] || 
            [gestRect isKindOfClass:[UITapGestureRecognizer class]]) {
            if (!gestRect.enabled)
                gestRect.enabled = YES;
        } 
    }
   
    CGFloat zoomToX = -(touchLocation.x-240);
    if (zoomToX < -240) {
        zoomToX = -240;
    } else if (zoomToX > 240) {
        zoomToX = 240;
    }
    
    // Must move the room up to make objects appear centered
    CCMoveTo* move = [CCMoveTo actionWithDuration:0.70 position:CGPointMake(zoomToX, MAX_ZOOM_Y_POS)];
    CCEaseIn* easeMove = [CCEaseIn actionWithAction:move rate:0.4f];
	easeMove.tag = ActionTagRoomLayerZoomInMove;    
    
    CCScaleTo *scale  = [CCScaleTo actionWithDuration:0.70 scale:REGULAR_MAX_SCALE];
    CCEaseIn* easeScale = [CCEaseIn actionWithAction:scale rate:0.4f];
    easeScale.tag = ActionTagRoomLayerZoomInScale;
    CCCallFuncN *enableGestRecs = [CCCallFuncN actionWithTarget:self selector:@selector(enableGestureRecognizers)];
    CCSequence *seq = [CCSequence actions:easeScale, enableGestRecs, nil];

	[self runAction:easeMove];
    [self runAction:seq];
    
}

- (void)zoomOut {


    NSArray *gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
    for (UIGestureRecognizer *gestRect in gestureRecognizers) {
        if ([gestRect isKindOfClass:[UIPinchGestureRecognizer class]] || 
            [gestRect isKindOfClass:[UITapGestureRecognizer class]]) {
            if (!gestRect.enabled)
                gestRect.enabled = YES;
        }
    }
    CCMoveTo* move = [CCMoveTo actionWithDuration:0.60 position:CGPointMake(0, 0)];
    CCEaseIn* easeMove = [CCEaseIn actionWithAction:move rate:0.3f];
    easeMove.tag = ActionTagGameLayerMovesToOrigin;

    CCScaleTo *scale  = [CCScaleTo actionWithDuration:0.60 scale:REGULAR_MIN_SCALE];
    CCEaseIn* easeScale = [CCEaseIn actionWithAction:scale rate:0.3f];
    easeScale.tag = ActionTagGameLayerScales;
    CCCallFuncN *enableGestRecs = [CCCallFuncN actionWithTarget:self selector:@selector(enableGestureRecognizers)];
    CCSequence *seq = [CCSequence actions:easeScale, enableGestRecs, nil];

	[self runAction:easeMove];
    [self runAction:seq];
    
}

- (void)handleDoubleTapFrom:(UITapGestureRecognizer *)recog {
    if (!self.visible) return;
    
    if (recog.state == UIGestureRecognizerStateRecognized) {

        CGPoint touchLocation = [recog locationInView:recog.view];
        recog.enabled = NO;
        if (self.scale == REGULAR_MIN_SCALE) {
            [self regularZoomIn:touchLocation];
        } else if (self.scale == REGULAR_MAX_SCALE) {
            [self zoomOut];
        }
    }
}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recog {

    if (!self.visible) return;
    
    if (recog.state == UIGestureRecognizerStateChanged || recog.state == UIGestureRecognizerStateEnded) {

        if (recog.velocity > 0) {
            // Glide zoom in
            CGPoint touchLocation = [recog locationInView:recog.view];
            recog.enabled = NO;
            if (self.scale == REGULAR_MIN_SCALE) {
                [self regularZoomIn:touchLocation];
            } else {
                recog.enabled = YES;
            }
            

        } else if (recog.velocity < 0) {
            // Glide zoom out
            recog.enabled = NO;
            if (self.scale == REGULAR_MAX_SCALE) {
                [self zoomOut];
            } else {
                recog.enabled = YES;
            }

        }
    }
}

- (void)dealloc
{
    [self.objectMediators release];
    [roomObjectProperties release];
    [super dealloc];
}

@end
