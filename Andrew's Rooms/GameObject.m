 //
//  Object.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "Component.h"
#import "GraphicsComponent.h"
@implementation GameObject

@synthesize components, interactionState, shouldBeDestroyed;

- (id)init {
    
    if ((self = [super init])) {
        self.shouldBeDestroyed = NO;
    }
    return self;
}

- (BOOL)allComponentsAreValid:(NSMutableArray *)comps {
    for (id component in comps) {
        if (![[component class] conformsToProtocol:@protocol(Component)]) {
            [NSException raise:NSInternalInconsistencyException 
                        format:@"Tried to add a Non-Component to Components Array! Class Type Added:%@", NSStringFromClass([component class])];
            return NO;
        }
    }
    
    return YES;
}

- (CGRect)getTrueRectForCurrentState {
    
    for (id comp in self.components) {
        if ([comp isKindOfClass:[GraphicsComponent class]]) {
            GraphicsComponent *gc = (GraphicsComponent *)comp;
            return gc.trueRect;
        }
    }
    
    [NSException raise:NSInternalInconsistencyException 
                format:@"there's no GraphicsComponent in this GameObject! method:%@", NSStringFromSelector(_cmd)];
    
    return CGRectZero;
}


- (void)setTrueRectForCurrentState:(CGRect)rect {
    
    for (id comp in self.components) {
        if ([comp isKindOfClass:[GraphicsComponent class]]) {
            GraphicsComponent *gc = (GraphicsComponent *)comp;
            gc.trueRect = rect;
            [self Send:TouchDetectionRectWasFound];
            return;
        }
    }
    
    [NSException raise:NSInternalInconsistencyException 
                format:@"there's no GraphicsComponent in this GameObject! method:%@", NSStringFromSelector(_cmd)];
}


- (id)initWithComponentArray:(NSArray *)comps {
    
    if (self = [super init]) {
        
        self.components = [[NSMutableArray alloc] initWithArray:comps];
        
        // By default it's a NonInteractive object, but subclasses can change this.
        
        
    }
    return self;
}
//
//+ (id)gameObjectWithComponentArray:(NSArray *)comps {
//    return [[[self alloc] initWithComponentArray:comps] autorelease];
//}

- (void)Send:(SignalID)signal {
    
    for (id component in components) {
        if ([[component class] conformsToProtocol:@protocol(Component)]) {
            [component Receive:signal];            
        }
    }
    
    if (self.shouldBeDestroyed) {
//        [self removeFromParentAndCleanup:YES];
        //CCLOG(@"Retain count now: %d", [self retainCount]);
    }
}

- (void)dealloc
{
    [components release];
    [super dealloc];
}

@end
