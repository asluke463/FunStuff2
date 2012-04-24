//
//  GameObject.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "RoomScene.h"
#import "ObjectSprite.h"
#import "RoomLoader.h"
#import "InfoButton.h"

@implementation GameObject
@synthesize baseObjectMap, interactionState, touchDetectionRect, infoBubble, objectTag;
@synthesize oneSpriteTouched;

+ (id)objectWithBaseName:(NSString *)baseName roomLayer:(RoomLayer *)layer {
    
    return [[[self alloc] initWithBaseName:baseName roomLayer:layer] autorelease];
}

- (id)initWithBaseName:(NSString *)baseName roomLayer:(RoomLayer *)layer {
    
    if ((self = [super init])) {
        
        self.objectTag = [Tags convertToObjectTagFromString:baseName];
        int zOrder = 1; 
        self.interactionState = RegularState;
        if ([baseName isEqual:@"background"]) {
            self.interactionState = NonInteractiveState;
            zOrder = 0;
        } 
      //Test GIT GIT  
        [layer addChild:self z:zOrder tag:[Tags convertToObjectTagFromString:baseName]];
        
        baseObjectMap = [[NSDictionary alloc] initWithDictionary:[[RoomScene sharedRoomScene].roomLoader.objectPropertyListForCurrentRoom objectForKey:baseName]];
        
        NSArray *objectNameKeys = [[NSArray alloc] initWithArray:[baseObjectMap allKeys]];
        
        for (NSString *objectName in objectNameKeys) {
            [self addSpriteToGameObject:baseName objectName:objectName];
        }
        
        [objectNameKeys release];
        
        // Add Info Button, but most likely won't be right position because touch detection rect isn't set it
        if (self.interactionState == RegularState) {
            self.infoBubble = [InfoButton infoBubbleForObject:baseName position:CGPointMake(self.touchDetectionRect.origin.x + self.touchDetectionRect.size.width/2, self.touchDetectionRect.origin.y + self.touchDetectionRect.size.height + 40)];
            [layer addChild:self.infoBubble z:2];
        }

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
    }
    
    return self;
}

- (void)updateDetectionRect:(CGRect)rect {
    self.touchDetectionRect = rect;
    self.infoBubble.position = ccpAdd(self.position, CGPointMake(0, (self.touchDetectionRect.size.height/2) - 40));
}
// e.g. baseName - "panel" and objectName = "R_plug"
- (void)addSpriteToGameObject:(NSString *)baseName objectName:(NSString *)objectName {
    
    
    if ([[baseObjectMap objectForKey:objectName] isKindOfClass:[NSArray class]]) {
        NSString *spriteFrameName = [[NSString alloc] initWithFormat:@"%@_%@", baseName, objectName];

        NSArray *frameDataArray = [[NSArray alloc] initWithArray:[baseObjectMap objectForKey:objectName]];
        
        [ObjectSprite spriteWithParent:self spriteFrameName:spriteFrameName frameArray:frameDataArray];
        [frameDataArray release];
        [spriteFrameName release];

    }
}

- (void)toggleBetweenRegularAndCloseUpState {
    
    CCArray *children = [self children];
    ObjectSprite *sprite;
    CCARRAY_FOREACH(children, sprite) {
        
        [sprite toggleBetweenRegularAndCloseUpState];
    }
    
}

- (void)transitionGameObjectToState:(InteractionState)newState {

    [self toggleBetweenRegularAndCloseUpState];
    
    self.interactionState = newState;
    switch (newState) {
        case CloseUpState:
            [[RoomScene sharedRoomScene] moveGameObjectToLayer:LayerTagCloseUpLayer gameObject:self];

            break;
        
        case RegularState:
            [[RoomScene sharedRoomScene] moveGameObjectToLayer:LayerTagRoomLayer gameObject:self];
        default:
            break;
    }
    
    self.interactionState = newState;
}

- (void)dealloc
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//    [sprites release];
    [baseObjectMap release];
    [super dealloc];
}

- (BOOL)isTouchForAnyChildSprite:(CGPoint)touchLocation {
    
    BOOL isTouchFor = NO;
    CCArray *children = [self children];
    CCNode *node;
    CCARRAY_FOREACH(children, node) {
        
        if ([node isKindOfClass:[ObjectSprite class]]) {
            ObjectSprite *object = (ObjectSprite *)node;
            if ([object isTouchForMe:touchLocation]) {
                isTouchFor = YES;
            }
        }
    }
    
    return isTouchFor;
}

- (BOOL)isTouchForMe:(CGPoint)touchLocation {
    
    if (self.interactionState == RegularState) {
        return CGRectContainsPoint(self.touchDetectionRect, touchLocation);
    } else if (self.interactionState == CloseUpState) {
        return [self isTouchForAnyChildSprite:touchLocation];
    } else {
        return NO;        
    }

}

- (void)iWasTouched:(CGPoint)touchLocation {
    
    if (self.interactionState == RegularState) {
        
        // Turn off all other info buttons
        CCNode *potentialInfoBubble;
        CCArray *children = [[RoomScene sharedRoomScene].roomLayer children];
        
        // NOTE - THE SPRITES ADDED TO THE CHILD ARRAY ARE ADDED IN ORDER LISTED ON MY PLIST, SO I HAVE TO KEEP THOSE OBJECTS IN ORDER OF PRIORITY FIRST - LIKE KEEP PANEL SHUT AS THE FIRST OBJECT WITH HIGHEST PRIORITY THAT RECEIVES TOUCHES FIRST. OR OR OR IF IT GEST TO COMPLICATED I HAVE TO SUBCLASS OBJECTSPRITE FROM CCNODE INSTEAD AND JUST MAKE IT A TOUCH DELEGATE
        CCARRAY_FOREACH(children, potentialInfoBubble) {
            
            if ([potentialInfoBubble isKindOfClass:[InfoButton class]]) {
                InfoButton *button = (InfoButton *)potentialInfoBubble;
                if (button.infoBubbleSprite.visible) {
                    if (![button isEqual:self.infoBubble]) {
                        button.infoBubbleSprite.visible = NO;
                        [button.infoBubbleSprite stopAllActions];
                        button.infoBubbleSprite.color = ccWHITE;
                        if (!CGPointEqualToPoint(button.infoBubbleSprite.position, button.originalPosition)) 
                            button.infoBubbleSprite.position = button.originalPosition;
                    }
                }
                
            }
        }
        
        [self.infoBubble displaySelf];
    } else if (self.interactionState == CloseUpState) {
        CCArray *children = [self children];
        CCNode *node;
        CCARRAY_FOREACH(children, node) {
            
            if ([node isKindOfClass:[ObjectSprite class]]) {
                ObjectSprite *object = (ObjectSprite *)node;
                if ([object isTouchForMe:touchLocation] && (self.oneSpriteTouched == NO)) {
                    [object iWasTouched];
                    self.oneSpriteTouched = YES;
                }
            }
        }
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    self.oneSpriteTouched = NO;
    if (self.interactionState != [RoomScene sharedRoomScene].interactionState) return NO;
    
    CGPoint touchLocation = [RoomScene locationFromTouch:touch];
    touchLocation = [self convertToNodeSpace:touchLocation];
    if (self.interactionState != NonInteractiveState) {
        if ([self isTouchForMe:touchLocation]) {
            [self iWasTouched:touchLocation];
            return YES;
        }
    } 
    
    return NO;
}
@end
