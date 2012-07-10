//
//  InventoryObject.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InventoryObject.h"
#import "InventoryObjectGraphicsComponent.h"
#import "InventoryBar.h"
@implementation InventoryObject
@synthesize invenBar;

- (id)initWithSprite:(CCSprite *)sprite tag:(ObjectTags)tag inventoryBar:(InventoryBar *)bar {
    
    if (self = [super init]) {
        
        self.invenBar = bar;

        self.tag = tag;
//        // add graphics component TODO
        [self.components addObject:[InventoryObjectGraphicsComponent inventoryGraphicsComponentWithSprite:sprite inventoryObject:self]];
        
        [bar addChild:self z:0 tag:InventoryBarTag];
        
        // add to inventorybar
        
        
    }
    return self;
}

+ (id)inventoryBarObjectWithSprite:(CCSprite *)sprite tag:(ObjectTags)tag inventoryBar:(InventoryBar *)bar {
    
    return [[[self alloc] initWithSprite:sprite tag:tag inventoryBar:bar] autorelease];
}
@end
