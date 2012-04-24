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
        self.visible = NO;
        [self addBackButton];
    }   
    return self;
}
// just trying this out, putting same node on two different layers 
- (void)loadGameObject:(GameObject *)gameObject {
    self.backButton.backButtonSprite.color = ccWHITE;
    self.visible = YES;
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



@end
