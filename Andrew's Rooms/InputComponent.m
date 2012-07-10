//
//  InputComponent.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InputComponent.h"
#import "GameObject.h"
#import "ComponentSignalsIDs.h"
#import "RoomScene.h"
#import "RoomObject.h"
#import "RoomSubObject.h"
#import "InfoBubbleComponent.h"
@implementation InputComponent
@synthesize touchDetectionRect, on, gameObject;

- (id)initWithParent:(GameObject *)parent detectionRect:(CGRect)rect {
    
    if (self = [super init]) {
        self.touchDetectionRect = rect;
        [parent addChild:self];

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
    }
    
    return self;
}

+ (id)inputComponentWithParent:(GameObject *)parent detectionRect:(CGRect)rect {
    
    return [[[self alloc] initWithParent:parent detectionRect:rect] autorelease];
}

- (id)initWithParent:(GameObject *)parent {
    
    if (self = [super init]) {
        self.gameObject = parent;
        
        // Set input off by default for info bubbles
        if ([self.gameObject isKindOfClass:[InfoBubbleComponent class]]) {
            self.on = NO;
        } else {
            self.on = YES;
        }
        [parent addChild:self];
        int priority = 0;
        if ([parent isKindOfClass:[RoomSubObject class]] && ((RoomSubObject *)parent).isActivator) {
            priority = -1;
        }
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:priority swallowsTouches:YES];
    }
    
    return self;
}

+ (id)inputComponentWithParent:(GameObject *)parent  {
    
    return [[[self alloc] initWithParent:parent] autorelease];
}

//- (id)initWithParent:(GameObject *)parent priority:(int)priority {
//    
//    if (self = [super init]) {
//        self.gameObject = parent;
//        
//        // Set input off by default for info bubbles
//        if ([self.gameObject isKindOfClass:[InfoBubbleComponent class]]) {
//            self.on = NO;
//        } else {
//            self.on = YES;
//        }
//        [parent addChild:self];
//        
//        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
//    }
//    
//    return self;
//}
//
//+ (id)inputComponentWithParent:(GameObject *)parent  {
//    
//    return [[[self alloc] initWithParent:parent] autorelease];
//}

- (void)Receive:(SignalID)signal {
    
    switch (signal) {
//        case GameObjectWasTouched:
//            // do stuff for game object
//            break;
//            
//        case GameObjectSubspriteWasTouched:
//            // do stuff for game subsprite
//            break;
        case AllComponentsInitialized:
            if ([self.gameObject isKindOfClass:[RoomSubObject class]]) {
                if (((RoomSubObject*)self.gameObject).isInteractable) {
                    self.on = YES;
                } else {
                    self.on = NO;
                }
            }
            break;
                
        case TouchDetectionRectWasFound: 
            // set touch detection rect to gc's rect
        case TouchDetectionRectChanged:
            self.touchDetectionRect = [self.gameObject getTrueRectForCurrentState];
            break;
        case TransitionToCloseUpStateSignal:
            if ([self.gameObject isKindOfClass:[RoomObject class]]) {
                self.on = NO;
            } else {
                self.on = YES;
            }
            break;
        case TransitionToRegularStateSignal:
            if ([self.gameObject isKindOfClass:[RoomObject class]]) {
                self.on = YES;
            } else {
                self.on = NO;
            }
            break;
            // set touch detection rect
            
//        case AddLockToMe:
//            [self addLock];
        case IWasLocked:
            self.on = NO;
            break;
        case IWasUnlocked:
            self.on = YES;
            break;
        case InfoBubbleWasDisplayed: 
            // enable touch
            self.on = YES;
            break;
        case InfoBubbleWentInvisible: 
            self.on = NO;
            // disable touch
            break;
        case NeedToSetDetectionRect: 
            self.touchDetectionRect = [self.gameObject getTrueRectForCurrentState];
            break;
        case ObjectWasCollected: // TODO THIS OBJECT MUST BE REMOVED RATHER THAN JUST INPUT TURNED OFF
            self.on = NO;
            break;
        default:
            break;
    }
}

- (BOOL)gameObjectWasTouched:(CGPoint)touchLocation {
    
    return CGRectContainsPoint(touchDetectionRect, touchLocation);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if (!self.on || self.gameObject.shouldBeDestroyed) return NO;
    
//    CCLOG(@"GameObject class: %@", [gameObject class]);


    CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];

    if ([RoomScene sharedRoomScene].interactionState == RegularState) {
        touchLocation = [self convertToNodeSpace:touchLocation];
    } else {
        touchLocation = [self convertToWorldSpace:touchLocation];
    }
    if (gameObject.tag == spiral_P) {
        CCLOG(@"touch x: %f y:%f ", touchLocation.x, touchLocation.y);
    } 
    
    
    // if I was touched
    if ([self gameObjectWasTouched:touchLocation]) {
        if (![self.gameObject isKindOfClass:[InfoBubbleComponent class]]) {
            
            
            if ([self.gameObject isKindOfClass:[RoomSubObject class]]) {
                if (((RoomSubObject *)self.gameObject).isActivator) {
                    [self.gameObject Send:ActivatorSubObjectWasTouched];
            
                }
                
                if (((RoomSubObject *)self.gameObject).collectable) {
                    [self.gameObject Send:ObjectWasCollected];
                }
            }

                [self.gameObject Send:RoomObjectWasTouched];
            
        } else {
            [((InfoBubbleComponent*)self.gameObject).roomObject Send:InfoBubbleWasTouched];
        }

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
