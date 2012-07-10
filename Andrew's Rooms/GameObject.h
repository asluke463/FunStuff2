//
//  Object.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ComponentSignalsIDs.h"
#import "Tags.h"
#import "States.h"
@interface GameObject : CCNode {
    
    NSMutableArray *components;
    InteractionState interactionState;
    BOOL shouldBeDestroyed;
}
@property (nonatomic, retain) NSMutableArray *components;
@property (nonatomic, assign) InteractionState interactionState;
@property (nonatomic, assign)    BOOL shouldBeDestroyed;

- (void)Send:(SignalID)signal;
- (CGRect)getTrueRectForCurrentState;
- (void)setTrueRectForCurrentState:(CGRect)rect;
- (BOOL)allComponentsAreValid:(NSMutableArray *)comps;
//+ (id)gameObjectWithComponentArray:(NSArray *)comps;
@end
