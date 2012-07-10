//
//  InfoBubbleGraphicsComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoBubbleGraphicsComponent.h"
#import "InfoBubbleComponent.h"
#import "RoomObject.h"
#import "RoomLayer.h"


@implementation InfoBubbleGraphicsComponent
@synthesize sprite, originalPosition;

- (id)initForInfoBubbleComponent:(InfoBubbleComponent *)bubbleComp {
    
    if (self = [super init]) {
        self.gameObject = bubbleComp;
        self.sprite = [CCSprite spriteWithSpriteFrameName:@"info_bubble_big.png"];
        
        self.sprite.visible = NO;
        [bubbleComp addChild:self.sprite];
        [bubbleComp.roomObject.roomLayer addChild:bubbleComp z:2 tag:InfoBubbleComponentTag];
//        [bubbleComp Send:TouchDetectionRectWasFound];
    }
    
    return self;
}

- (void)setSpritePosition {
    CGRect roomObjectRect = [(InfoBubbleComponent *) self.gameObject getTrueRectForRoomObject];
    self.sprite.position = CGPointMake(roomObjectRect.origin.x + roomObjectRect.size.width/2, roomObjectRect.origin.y + roomObjectRect.size.height + 40);
    self.originalPosition = self.sprite.position;
    CGRect bbox = [self.sprite boundingBox];
    self.trueRect = CGRectMake(self.sprite.position.x-(bbox.size.width/2), self.sprite.position.y-(bbox.size.height/2), bbox.size.width , bbox.size.height);

}

+ (id)infoBubbleGraphicsComponentForInfoBubbleComponent:(InfoBubbleComponent *)bubbleComp {
    
    return [[[self alloc] initForInfoBubbleComponent:bubbleComp] autorelease];
}

- (void)Receive:(SignalID)signal {
    
    switch (signal) {
        case RoomObjectWasTouched:
            [self displaySelf];
            break;
            
        case OtherInfoBubbleWasDisplayed:
            if (self.sprite.visible) {
                [self makeInvisible];
                [self.sprite stopAllActions];
            }                
            break;
                
        case InfoBubbleWasTouched:
            [self makeInvisible];
            [self.sprite stopAllActions];
            break;
        case AllComponentsInitialized:
            [self setSpritePosition];
            [self.gameObject Send:TouchDetectionRectWasFound];

            
        default:
            break;
    }
}

- (void)displaySelf {
    
    [self.gameObject Send:InfoBubbleWasDisplayed]; // infobubble sends this message to all its components
    CCArray *roomObjects = ((InfoBubbleComponent *)self.gameObject).roomObject.roomLayer.roomObjects;
    RoomObject *roomObject;
    CCARRAY_FOREACH(roomObjects, roomObject) {
        if (![((InfoBubbleComponent *)self.gameObject).roomObject isEqual:roomObject])
            [roomObject Send:OtherInfoBubbleWasDisplayed];
    }
    
    if (self.sprite.visible) return;
    
    self.sprite.visible = YES;
    
    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:0.25];
    
    CCJumpBy *jump = [CCJumpBy actionWithDuration:0.5 position:CGPointMake(0, 0) height:15 jumps:1];
    
    CCDelayTime *delay = [CCDelayTime actionWithDuration:3];
    
    CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:1];
    
    //    CCCallFuncN *remove = [CCCallFuncN actionWithTarget:self selector:@selector(removeSelf)];
    CCCallFuncN *makeInvisible = [CCCallFuncN actionWithTarget:self selector:@selector(makeInvisible)];
    
    CCSequence *seq = [CCSequence actions:fadeIn, jump, delay, fadeOut, makeInvisible, nil];
    
    [self.sprite runAction:seq];
}

- (void)makeInvisible {
    
    self.sprite.visible = NO;
    self.sprite.color = ccWHITE;
    
    if (!CGPointEqualToPoint(self.sprite.position, self.originalPosition)) 
        self.sprite.position = self.originalPosition;
    
    [self.gameObject Send:InfoBubbleWentInvisible];
}

@end
