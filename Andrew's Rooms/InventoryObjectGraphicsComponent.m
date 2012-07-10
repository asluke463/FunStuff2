//
//  InventoryObjectGraphicsComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InventoryObjectGraphicsComponent.h"
#import "InventoryObject.h"

@implementation InventoryObjectGraphicsComponent
@synthesize inventoryObject, isSelected, sprite;

- (id)initWithSprite:(CCSprite *)sprit inventoryObject:(InventoryObject *)object {
    
    if ((self = [super init])) {
        self.inventoryObject = object;
        self.isSelected = NO;
        self.sprite = sprit;
        // set position of sprite TODO
        self.sprite.position = CGPointZero; // with respect to inventoryObject and bar?
        [object addChild:self.sprite z:0];
    }
    return self;
}

+ (id)inventoryGraphicsComponentWithSprite:(CCSprite *)sprit inventoryObject:(InventoryObject *)object {
    
    return [[[self alloc] initWithSprite:sprit inventoryObject:object] autorelease];
}

@end
