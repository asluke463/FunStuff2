//
//  InventoryBar.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InventoryBar.h"
#import "UILayer.h"
#import "Tags.h"
#import "GameObject.h"
#import "InventoryObject.h"

#define OBJECT_SPACING 10.0

@implementation InventoryBar
@synthesize objectSpacing, collectedObjects;
- (id)initWithUILayer:(UILayer *)layer {
    
    if (self = [super init]) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        self.position = CGPointMake(30, screenSize.height - 50);
        [layer addChild:self z:0 tag:InventoryBarTag];
        self.collectedObjects = [CCArray array];
        
    }
    return self;
}

+ (id)inventoryBarWithUILayer:(UILayer *)layer {
    
    return [[[self alloc] initWithUILayer:layer] autorelease];
}
- (void)addObjectWithSprite:(CCSprite *)sprite objectTag:(ObjectTags)tag {
    [self.collectedObjects addObject:[InventoryObject inventoryBarObjectWithSprite:sprite tag:tag inventoryBar:self]];
    // Tells objec'ts graphics component to add to inventory bar TODO
//    [object Send:AddObjectToInventoryBar];
}
- (void)selectObjectForUse {
    
}
- (void)deselectObject {
    
}
- (void)useObject {
    
}

@end
