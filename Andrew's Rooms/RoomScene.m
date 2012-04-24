//
//  RoomScene.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomScene.h"
#import "RoomLayer.h"
#import "RoomLoader.h"
#import "UILayer.h"
#import "GameObject.h"
#import "CloseUpLayer.h"

@implementation RoomScene

@synthesize roomLoader, interactionState;

static CGRect screenRect;

static RoomScene *instanceOfRoomScene;

+ (RoomScene *)sharedRoomScene {
    
    NSAssert(instanceOfRoomScene != nil, @"RoomScene instance not yet initialized!");
    return instanceOfRoomScene;
}

// Access to the various layers by wrapping the getChildByTag method
// and checking if the received node is of the correct class.
-(RoomLayer*) roomLayer
{
	CCNode* layer = [self getChildByTag:LayerTagRoomLayer];
	NSAssert([layer isKindOfClass:[RoomLayer class]], @"%@: not a RoomLayer!", NSStringFromSelector(_cmd));
	return (RoomLayer*)layer;
}

- (CloseUpLayer *)closeUpLayer {
    
    CCNode *layer = [self getChildByTag:LayerTagCloseUpLayer];
	NSAssert([layer isKindOfClass:[CloseUpLayer class]], @"%@: not a CloseUpLayer!", NSStringFromSelector(_cmd));    
    return (CloseUpLayer *)layer;
}

-(UILayer*) uiLayer
{
	CCNode* layer = [[RoomScene sharedRoomScene] getChildByTag:LayerTagUILayer];
	NSAssert([layer isKindOfClass:[UILayer class]], @"%@: not a UILayer!", NSStringFromSelector(_cmd));
	return (UILayer*)layer;
}

+ (id)scene {
    
    CCScene *scene = [CCScene node];
    RoomScene *layer = [RoomScene node];
    [scene addChild:layer];
    return scene;
}



//- (void)loadCloseUpObject:(NSString *)baseName {
//    
//    CloseUpLayer *closeUpLayer = [self closeUpLayer];
//    
//    if ([closeUpLayer isKindOfClass:[CloseUpLayer_One class]]) {
//        CloseUpLayer_One *layer = (CloseUpLayer_One *) closeUpLayer;
//        [layer loadCloseUpObject:baseName];
//        [layer addBackButton];
//        layer.isTouchEnabled = YES;
//        [self roomLayer].isTouchEnabled = NO;
//    }
//
//}


- (void)toggleGestureRecognizers {

    NSArray *gestureRecogs = [[[CCDirector sharedDirector] openGLView] gestureRecognizers];
    for (UIGestureRecognizer *recog in gestureRecogs) {
        if (recog.enabled) 
            recog.enabled = NO;
        else
            recog.enabled = YES;
    }
    
}
// This assumes the properties for the gameObject are set and already to go
- (void)moveGameObjectToLayer:(RoomSceneLayerTags)layerTag gameObject:(GameObject *)gameObject {
    
//    [gameObject retain]; // <---- hahahahhahaha
    if (layerTag == LayerTagCloseUpLayer) {
        [self.roomLayer removeChildByTag:[gameObject objectTag] cleanup:YES];
        self.roomLayer.visible = NO;
        self.roomLayer.isTouchEnabled = NO;
        [self.closeUpLayer loadGameObject:gameObject];
        self.interactionState = CloseUpState;
        [self toggleGestureRecognizers];
//        [[CCTouchDispatcher sharedDispatcher] removeDelegate:self.roomLayer];
    } else if (layerTag == LayerTagRoomLayer) {
        [self.closeUpLayer removeChildByTag:[gameObject objectTag] cleanup:YES];
        self.closeUpLayer.visible = NO;
        self.closeUpLayer.isTouchEnabled = NO;
        [self.roomLayer loadGameObject:gameObject];
        self.interactionState = RegularState;
        [self toggleGestureRecognizers];
    }
    
    

//    CCLOG(@"GameObject currentRetainCount: %d !!!", [gameObject retainCount]);
}

- (id)init {
    
    if ((self = [super init])) {
        
        instanceOfRoomScene = self;
        
        self.interactionState = RegularState;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        screenRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
        
        /* LOAD ROOM AND CLOSEUP LAYERS FOR LEVEL 1 - THESE TWO GET SWITCHED OUT WITH EVERY ROOM CHANGE */
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"ui-art.plist"];
        
        
        self.roomLoader = [[RoomLoader alloc] init];
        // Load first room layer
        
        RoomLayer *roomOne = [RoomLayer roomLayerForRoomNum:1];
        [self addChild:roomOne z:1 tag:LayerTagRoomLayer];

        // Load first room's closeup layer
//        CloseUpLayer_One *closeUpLayerOne = [CloseUpLayer_One node];
//        [self addChild:closeUpLayerOne z:2 tag:LayerTagCloseUpLayer];
        CloseUpLayer *closeUpLayer = [CloseUpLayer node];
        [self addChild:closeUpLayer z:2 tag:LayerTagCloseUpLayer];
        
        // The UILayer reamins static and relative to the screen area. This stays alive across levels
        UILayer *uiLayer = [UILayer node];
        [self addChild:uiLayer z:3 tag:LayerTagUILayer];

    }
    return self;
}

- (void)dealloc
{
    instanceOfRoomScene = nil;
    [roomLoader release];
    [super dealloc];
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

+(CGRect)screenRect {
    return screenRect;
}

@end
