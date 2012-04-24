//
//  CloseUpLayer.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CloseUpLayer.h"
#import "RoomScene.h"
#import "GameObject.h"
#import "BackButton.h"

@implementation CloseUpLayer

@synthesize backButton;

- (id)init {
    
    if ((self = [super init])) {
//        gestureRecognizers = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
//        roomLayerPosition = self.position;
        self.scale = 1.0;
//        startZoomScale = MIN_SCALE;
        self.isTouchEnabled = NO;
        self.visible = NO;
        [self addBackButton];
    }   
    return self;
}
// just trying this out, putting same node on two different layers 
- (void)loadGameObject:(GameObject *)gameObject {
    self.backButton.backButtonSprite.color = ccWHITE;
    self.visible = YES;
    self.isTouchEnabled = YES;
    [self addChild:gameObject z:0 tag:[gameObject objectTag]];
    
    
//    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.5];
//    
//    CCArray *childSprites = [[self getChildByTag:[gameObject tag]] children];
//    CCNode *node;
//    CCARRAY_FOREACH(childSprites, node) {
//        
//        if ([node isKindOfClass:[CCSprite class]]) {
//            CCSprite *sprite = (CCSprite *)node;
//            [sprite runAction:fadeIn];
//        }
//    }
}

- (void)addBackButton {
     self.backButton = [BackButton backButton];
  
    [self addChild:self.backButton z:1 tag:BackButtonTag];
//    CCLOG(@"ADDING BACK BUTTON");
}

//- (void)loadCloseUpObject:(NSString *)baseName {
//    
//    [NSException raise:NSInternalInconsistencyException 
//                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
//    
//
//}

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
    CCLOG(@"CloseLayerTouched");
    
//	CGPoint location = [RoomScene locationFromTouch:touch];
    
    
//    CCArray *children = [self children];
//    CCNode *node;
//    CCARRAY_FOREACH(children, node) {
        
//        if ([node isKindOfClass:[CloseUpObject class]]) {
//            location = [self convertToNodeSpace:location];
//            CloseUpObject *obj = (CloseUpObject *)node;
//            CCLOG(@"touchLocation x: %f y: %f", location.x, location.y);
//            CCLOG(@"obj origin x: %f y: %f", [obj boundingBox].origin.x, [obj boundingBox].origin.y);
//            CCLOG(@"obj width: %f height: %f", [obj boundingBox].size.width, [obj boundingBox].size.height);
//            if ([obj isTouchForMe:location]) {
//                CCLOG(@"MESSAGE DISPLAYED!");
//                [obj objectWasClicked];
//            }
//            
//        } 
//        else if ([node isKindOfClass:[InfoButton class]]) {
//            //           location = [self convertToWorldSpace:location];    
//            CCLOG(@"MESSAGE DISPLAYED for INFO BUTTON!");
//            InfoButton *bubble = (InfoButton *)node;
//            if ([bubble isTouchForMe:location]) {
//                [bubble objectWasClicked];
//                if (self.scale == MIN_SCALE) {
//                    [self zoomIn:location];
//                    [bubble loadCloseUpObject];
//                } else {
//                    [bubble loadCloseUpObject];
//                }
//            }
//        }
//    }
 
    
	return YES;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
    //	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
    //	NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
    //	
    //	((CCSprite*)node).color = ccWHITE;
}


@end
