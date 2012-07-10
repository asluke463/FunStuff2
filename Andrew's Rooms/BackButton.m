//
//  BackButton.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BackButton.h"
#import "GameObject.h"
#import "RoomScene.h"


@implementation BackButton

@synthesize objectTag, backButtonSprite;

- (id)initBackButton {
    
    if ((self = [super init])) {
        self.tag = BackButtonTag;
        self.backButtonSprite = [CCSprite spriteWithSpriteFrameName:@"back_button.png"];
        self.backButtonSprite.tag = BackButtonTag;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.backButtonSprite.position = CGPointMake(27, screenSize.height-50);
        self.backButtonSprite.anchorPoint = CGPointMake(0.5f, 0.5f);
        [self addChild:self.backButtonSprite];

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-2 swallowsTouches:YES];
    }
    
    return self;
}

+ (BackButton *)backButton {

    return [[[self alloc] initBackButton] autorelease];
}

- (void)iWasTouched {
    if ([RoomScene sharedRoomScene].interactionState == RegularState) return;
    CCLOG(@"Back Button touched!");
    self.backButtonSprite.color = ccBLUE;
    // Do closeup stuff
    CCNode *gameObjectNode = [[[RoomScene sharedRoomScene].closeUpLayer children] objectAtIndex:0];
    NSAssert([gameObjectNode isKindOfClass:[GameObject class]], @"Not a GameObject!");
    GameObject *gameObject = (GameObject *)gameObjectNode;
    [gameObject Send:BackButtonWasTouched];
    
}


-(BOOL) isTouchForMe:(CGPoint)touchLocation
{
    
    return CGRectContainsPoint([self.backButtonSprite boundingBox], touchLocation);
    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    

        CGPoint touchLocation = [RoomScene locationFromTouch:touch];
        touchLocation = [self convertToNodeSpace:touchLocation];
        if ([self isTouchForMe:touchLocation]) {
            [self iWasTouched];
            return YES;
        }

    return NO;
}

- (void)dealloc
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super dealloc];
}



@end
