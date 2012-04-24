//
//  InfoButton.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoButton.h"
#import "RoomLayer.h"
#import "RoomScene.h"
#import "CloseUpLayer.h"
#import "GameObject.h"


#define MAX_ZOOM_Y_POS 80.0

@implementation InfoButton

@synthesize objectTag, infoBubbleSprite, originalPosition;

- (id)initInfoBubbleForObject:(NSString *)baseName position:(CGPoint)pos {
    

    if ((self = [super init])) {
        self.infoBubbleSprite = [CCSprite spriteWithSpriteFrameName:@"info_bubble_big.png"];
        self.infoBubbleSprite.position = pos;
        self.originalPosition = pos;
        [self addChild:self.infoBubbleSprite];
        self.infoBubbleSprite.visible = NO;
        self.objectTag = [Tags convertToObjectTagFromString:baseName];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
    }
    
    return self;
}

+ (InfoButton *)infoBubbleForObject:(NSString *)baseName position:(CGPoint)pos {
    
    return [[[self alloc] initInfoBubbleForObject:baseName position:pos] autorelease];
}

- (void)displaySelf {

    if (self.infoBubbleSprite.visible) return;
    
    self.infoBubbleSprite.visible = YES;
    
    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.25];

    CCJumpBy *jump = [CCJumpBy actionWithDuration:0.5 position:CGPointMake(0, 0) height:15 jumps:1];
    
    CCDelayTime *delay = [CCDelayTime actionWithDuration:3];
    
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:1];
    
//    CCCallFuncN *remove = [CCCallFuncN actionWithTarget:self selector:@selector(removeSelf)];
    CCCallFuncN *makeInvisible = [CCCallFuncN actionWithTarget:self selector:@selector(makeInvisible)];
    
    CCSequence *seq = [CCSequence actions:fadeIn, jump, delay, fadeOut, makeInvisible, nil];
    
    [self.infoBubbleSprite runAction:seq];
}
                               
- (void)removeSelf {
//    CCLOG(@"Info Button Removed");
    [self removeFromParentAndCleanup:YES];
//    self.visible = NO;
}

- (void)makeInvisible {
    
    self.infoBubbleSprite.visible = NO;
    self.infoBubbleSprite.color = ccWHITE;
    
    if (!CGPointEqualToPoint(self.infoBubbleSprite.position, self.originalPosition)) 
        self.infoBubbleSprite.position = self.originalPosition;
}

//- (void)loadCloseUpObject {
//    
//    [[RoomScene sharedRoomScene] loadCloseUpObject:self.objectBaseName];
//
//}
//



- (void)iWasTouched {
    CCLOG(@"INFO BUTTON TOUCHED!!!!!!");
    self.infoBubbleSprite.color = ccORANGE;
    // Do closeup stuff
    CCNode *gameObjectNode = [parent_ getChildByTag:self.objectTag];
    NSAssert([gameObjectNode isKindOfClass:[GameObject class]], @"Not a GameObject!");
    GameObject *gameObject = (GameObject *)gameObjectNode;
    [gameObject transitionGameObjectToState:CloseUpState];
    self.infoBubbleSprite.visible = NO;
    [self.infoBubbleSprite stopAllActions];
     self.infoBubbleSprite.color = ccWHITE;
}


-(BOOL) isTouchForMe:(CGPoint)touchLocation
{
    
    return CGRectContainsPoint([self.infoBubbleSprite boundingBox], touchLocation);
    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if (self.infoBubbleSprite.visible) {
        CGPoint touchLocation = [RoomScene locationFromTouch:touch];
        touchLocation = [self convertToNodeSpace:touchLocation];
        if ([self isTouchForMe:touchLocation]) {
            [self iWasTouched];
            return YES;
        }
    }
    
    
    return NO;
}

- (void)dealloc
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super dealloc];
}

@end
