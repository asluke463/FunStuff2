//
//  InventoryBar.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tags.h"
// Holds the collected collectable objects
@class GameObject, UILayer;
@interface InventoryBar : CCNode {
    
    CCArray *collectedObjects; 
    CGFloat objectSpacing;
}

@property (nonatomic, assign) CGFloat objectSpacing;
@property (nonatomic, retain) CCArray *collectedObjects; 
+ (id)inventoryBarWithUILayer:(UILayer *)layer;
- (void)addObjectWithSprite:(CCSprite *)sprite objectTag:(ObjectTags)tag;
- (void)selectObjectForUse;
- (void)deselectObject;
- (void)useObject;

@end
