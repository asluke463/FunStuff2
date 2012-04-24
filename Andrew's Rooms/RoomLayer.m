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
#import "GameObject.h"

//#define CLOSEUP_SCALE 1.0
//#define REGULAR_MAX_SCALE 0.5
//#define REGULAR_MIN_SCALE 0.25
#define REGULAR_MAX_SCALE 1.0
#define REGULAR_MIN_SCALE 0.5
#define MAX_ZOOM_Y_POS 80.0


@implementation RoomLayer

@synthesize roomSprite, gestureRecognizers;

- (id)initRoomLayerForRoomNum:(int)roomNumber {
    
    if ((self = [super init])) {
        self.gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
        roomLayerPosition = self.position;
        self.scale = REGULAR_MIN_SCALE;
        startZoomScale = REGULAR_MIN_SCALE;
//        self.isTouchEnabled = YES;
        
        [[RoomScene sharedRoomScene].roomLoader loadAssetsForRoom:roomNumber roomLayer:self];
    }
    return self;
}


+ (id)roomLayerForRoomNum:(int)roomNumber {
    
    return [[[self alloc] initRoomLayerForRoomNum:roomNumber] autorelease];
}

- (void)loadGameObject:(GameObject *)gameObject {
    
    self.visible = YES;
//    self.isTouchEnabled = YES;
    [self addChild:gameObject z:1 tag:[gameObject objectTag]];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recog {

    if (!self.visible) return;
    
  if (recog.state == UIGestureRecognizerStateChanged || recog.state == UIGestureRecognizerStateEnded) {

      CGRect backgroundBox = [[[self getChildByTag:background] getChildByTag:background_background] boundingBox];
      CGRect bbox = [self boundingBox];
   
      CGSize boxSize = bbox.size;

      
    CGPoint moveTo = [recog translationInView:recog.view];


      // Restrict panning to horizontal axis only
      moveTo.y = 0;

      CGPoint futurePosition = ccpAdd(self.position, moveTo);

      CGFloat futureLeftBorderX = futurePosition.x - (boxSize.width/2);
      CGFloat futureRightBorderX = futurePosition.x + (boxSize.width/2);

leftEdgeRoomIsAtBorder = (futureLeftBorderX > 0);
      rightEdgeRoomIsAtBorder = (futureRightBorderX < [RoomScene screenRect].size.width);

      CGPoint futureRoomSpriteAbsoluteLeftEdge = [self convertToWorldSpace:ccpAdd(backgroundBox.origin, moveTo)];

      CGPoint futureRoomSpriteAbsoluteRightEdge = [self convertToWorldSpace:ccpAdd(CGPointMake((backgroundBox.origin.x + backgroundBox.size.width), backgroundBox.origin.y), moveTo)];  

       if ((futureRoomSpriteAbsoluteLeftEdge.x > 0) || (futureRoomSpriteAbsoluteRightEdge.x <  [RoomScene screenRect].size.width)) {
          moveTo.x = 0;

      }

      self.position = ccpAdd(self.position, moveTo);
      [recog setTranslation:CGPointZero inView:recog.view];
  } 
    
if (recog.state == UIGestureRecognizerStateEnded) {

}
}

//- (void)zoomIn:(CGPoint)touchLocation withVelocity:(CGFloat)pinchVelocity {
//    
//    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
//    
//    gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
//    for (UIGestureRecognizer *gestRect in gestureRecognizers) {
//        if ([gestRect isKindOfClass:[UIPinchGestureRecognizer class]]) {
//            gestRect.enabled = YES;
//        }
//    }
//    CGFloat zoomSpeed = 0.4f;
//    if (pinchVelocity <= 50) 
//        zoomSpeed = 0.4f;
//    else if (pinchVelocity > 50 && pinchVelocity <= 100) {
//        zoomSpeed = 0.3f;
//    } else if (pinchVelocity > 100 && pinchVelocity <= 500) {
//        zoomSpeed = 0.2f;
//    } else if (pinchVelocity > 500) {
//        zoomSpeed = 0.1f;
//    }
//        
//    
//    CCLOG(@"Zoomed in with rate: %f", zoomSpeed);
//    
//    CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(-(touchLocation.x-240), MAX_ZOOM_Y_POS)];
//
//    CCScaleTo *scale  = [CCScaleTo actionWithDuration:1 scale:MAX_SCALE];
//	CCEaseIn* easeMove = [CCEaseIn actionWithAction:move rate:pinchVelocity];
//    CCEaseIn* easeScale = [CCEaseIn actionWithAction:scale rate:pinchVelocity];
//    
//	easeMove.tag = ActionTagRoomLayerZoomInMove;
//    easeScale.tag = ActionTagRoomLayerZoomInScale;
//	[self runAction:easeMove];
//    [self runAction:easeScale];
//
//}

- (void)enableGestureRecognizers {
//    CCLOG(@"ENABLE GESTURES CALLED! ");
    
    gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
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
    
    gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
    for (UIGestureRecognizer *gestRect in gestureRecognizers) {
        if ([gestRect isKindOfClass:[UIPinchGestureRecognizer class]] || 
            [gestRect isKindOfClass:[UITapGestureRecognizer class]]) {
            if (!gestRect.enabled)
                gestRect.enabled = YES;
        } 
    }
   
       
//    CCLOG(@"touch x: %f", -(touchLocation.x-240));
    CGFloat zoomToX = -(touchLocation.x-240);
    if (zoomToX < -240) {
        zoomToX = -240;
    } else if (zoomToX > 240) {
        zoomToX = 240;
    }
    
//    CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(-(touchLocation.x-240), MAX_ZOOM_Y_POS)];
    CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(zoomToX, MAX_ZOOM_Y_POS)];
    
    CCScaleTo *scale  = [CCScaleTo actionWithDuration:1 scale:REGULAR_MAX_SCALE];
	CCEaseIn* easeMove = [CCEaseIn actionWithAction:move rate:0.4f];
    CCEaseIn* easeScale = [CCEaseIn actionWithAction:scale rate:0.4f];
    CCCallFuncN *enableGestRecs = [CCCallFuncN actionWithTarget:self selector:@selector(enableGestureRecognizers)];
    
    CCSequence *seq = [CCSequence actions:easeScale, enableGestRecs, nil];

    
	easeMove.tag = ActionTagRoomLayerZoomInMove;
    easeScale.tag = ActionTagRoomLayerZoomInScale;
	[self runAction:easeMove];
    [self runAction:seq];
    
}



//- (void)closeUpZoomIn:(CGPoint)touchLocation {
//    
//    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
//    
//    gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
//    for (UIGestureRecognizer *gestRect in gestureRecognizers) {
//        if ([gestRect isKindOfClass:[UIPinchGestureRecognizer class]] || 
//            [gestRect isKindOfClass:[UITapGestureRecognizer class]]) {
//            if (!gestRect.enabled)
//                gestRect.enabled = YES;
//        } 
//    }
//    
//    
//    CCLOG(@"touch x: %f", -(touchLocation.x-240));
//    CGFloat zoomToX = -(touchLocation.x-240);
//    if (zoomToX < -240) {
//        zoomToX = -240;
//    } else if (zoomToX > 240) {
//        zoomToX = 240;
//    }
//    
//    //    CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(-(touchLocation.x-240), MAX_ZOOM_Y_POS)];
//    CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:CGPointMake(zoomToX, MAX_ZOOM_Y_POS)];
//    
//    CCScaleTo *scale  = [CCScaleTo actionWithDuration:1 scale:REGULAR_MAX_SCALE];
//	CCEaseIn* easeMove = [CCEaseIn actionWithAction:move rate:0.4f];
//    CCEaseIn* easeScale = [CCEaseIn actionWithAction:scale rate:0.4f];
//    
//	easeMove.tag = ActionTagRoomLayerZoomInMove;
//    easeScale.tag = ActionTagRoomLayerZoomInScale;
//	[self runAction:easeMove];
//    [self runAction:easeScale];
//    
//}




- (void)zoomOut {


    gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
    for (UIGestureRecognizer *gestRect in gestureRecognizers) {
        if ([gestRect isKindOfClass:[UIPinchGestureRecognizer class]] || 
            [gestRect isKindOfClass:[UITapGestureRecognizer class]]) {
            if (!gestRect.enabled)
                gestRect.enabled = YES;
        }
    }
    CCMoveTo* move = [CCMoveTo actionWithDuration:0.75 position:CGPointMake(0, 0)];
    CCScaleTo *scale  = [CCScaleTo actionWithDuration:0.75 scale:REGULAR_MIN_SCALE];
	CCEaseIn* easeMove = [CCEaseIn actionWithAction:move rate:0.3f];
    CCEaseIn* easeScale = [CCEaseIn actionWithAction:scale rate:0.3f];
    CCCallFuncN *enableGestRecs = [CCCallFuncN actionWithTarget:self selector:@selector(enableGestureRecognizers)];
    
    CCSequence *seq = [CCSequence actions:easeScale, enableGestRecs, nil];
	easeMove.tag = ActionTagGameLayerMovesToOrigin;
    easeScale.tag = ActionTagGameLayerScales;
	[self runAction:easeMove];
    [self runAction:seq];
    
}

- (void)handleDoubleTapFrom:(UITapGestureRecognizer *)recog {
//        CCLOG(@"Double Tapped");    
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

//- (void)handleSingleTapFrom:(UITapGestureRecognizer *)recog {
//    
//    if (recog.state == UIGestureRecognizerStateRecognized) {
//        CCLOG(@"Single Tap Happened");
//        
//        gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
//        for (UIGestureRecognizer *gestRect in gestureRecognizers) {
//            if ([gestRect isKindOfClass:[UITapGestureRecognizer class]]) {
//                UITapGestureRecognizer *tapper = (UITapGestureRecognizer *)gestRect;
//                if (gestRect.enabled && tapper.numberOfTapsRequired == 2)
//        CCLOG(@"Double Tap Disabled");
//                    gestRect.enabled = NO;
//            }
//        }
//        CGPoint touchLocation = [recog locationInView:recog.view];
//        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
//        recog.enabled = NO;
//        CCArray *allChildren = [self children];
//        CCNode *node; 
//        CCARRAY_FOREACH(allChildren, node) {
//            
//            if ([node isKindOfClass:[InteractiveObject class]]) {
//                InteractiveObject *obj = (InteractiveObject *)node;
//                if ([obj isTouchForMe:touchLocation]) {
//                    [obj displayRandomClickMessage];
//                }
//            }
//        }
//    }
//}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recog {

    if (!self.visible) return;
    
    if (recog.state == UIGestureRecognizerStateChanged || recog.state == UIGestureRecognizerStateEnded) {
        
//        CCLOG(@"Velocity: %f", recog.velocity); Note the velocity can range from +-10000 

        if (recog.velocity > 0) {
            // Glide zoom in
            CGPoint touchLocation = [recog locationInView:recog.view];
//            CGFloat velocity = recog.velocity;
            recog.enabled = NO;
//            [self zoomIn:touchLocation withVelocity:velocity];
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

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

//// Implements logic to check if the touch location was in an area that this layer wants to handle as input.
//-(BOOL) isTouchForObject:(CGPoint)touchLocation boundingBox:(CGRect)box
//{
////	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
//	return CGRectContainsPoint(box, touchLocation);
//}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
        CCLOG(@"RoomLayer was touched");
    
//	CGPoint location = [RoomScene locationFromTouch:touch];
//    
//    
//    CCArray *children = [self children];
//    CCNode *node;
//    CCARRAY_FOREACH(children, node) {
//        
//        if ([node isKindOfClass:[InfoButton class]]) {
////           location = [self convertToWorldSpace:location];    
//            CCLOG(@"MESSAGE DISPLAYED for INFO BUTTON!");
//            InfoButton *bubble = (InfoButton *)node;
//            if ([bubble isTouchForMe:location]) {
//                [bubble objectWasClicked];
//                if (self.scale == REGULAR_MIN_SCALE) {
//                    [self regularZoomIn:location];
//                    [bubble loadCloseUpObject];
//                } else {
//                    [bubble loadCloseUpObject];
//                }
//            }
//        }
//    }
    
//	BOOL isTouchHandled = [self isTouchForMe:location];
//	if (isTouchHandled)
//	{
//        CCLOG(@"Home Was Touched!");
//		// Simply highlight the UI layer's sprite to show that it received the touch.
//		CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
//		NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
//		
//		((CCSprite*)node).color = ccRED;
//        //		
//        //		// Rotate & Zoom the game layer, just for fun.
//        //		CCRotateBy* rotate = [CCRotateBy actionWithDuration:4 angle:360];
//        //		CCScaleTo* scaleDown = [CCScaleTo actionWithDuration:2 scale:0];
//        //		CCScaleTo* scaleUp = [CCScaleTo actionWithDuration:2 scale:1];
//        //		CCSequence* sequence = [CCSequence actions:scaleDown, scaleUp, nil];
//        //		sequence.tag = ActionTagGameLayerRotates;
//		
//        //		RoomLayer* roomLayer = [RoomScene sharedRoomScene].roomLayer;
//		
//        //		// Reset GameLayer properties modified by action so that the end result is always the same.
//        //		[gameLayer stopActionByTag:ActionTagGameLayerRotates];
//        //		[gameLayer setRotation:0];
//        //		[gameLayer setScale:1];
//        //		
//        //		// Run the actions on the game layer.
//        //		[gameLayer runAction:rotate];
//        //		[gameLayer runAction:sequence];
//	}
    
	return YES;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
//	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
//	NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
//	
//	((CCSprite*)node).color = ccWHITE;
}



- (void)dealloc
{
    [super dealloc];
}

@end
