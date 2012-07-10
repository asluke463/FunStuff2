//
//  UILayer.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UILayer.h"
#import "RoomScene.h"
#import "InventoryBar.h"

@implementation UILayer
@synthesize inventoryBar;


- (id)init {
    
    if ((self = [super init])) {
       
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CCSprite *uiSprite = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Home-Button.png"]];
        uiSprite.position = CGPointMake(screenSize.width - 27, screenSize.height - 50);
        uiSprite.anchorPoint = CGPointMake(0.5f, 0.5f);
        [self addChild:uiSprite z:0 tag:UILayerTagFrameSprite];
        
        self.isTouchEnabled = YES;
        
        self.inventoryBar = [InventoryBar inventoryBarWithUILayer:self];
        
    }
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

// Implements logic to check if the touch location was in an area that this layer wants to handle as input.
-(BOOL) isTouchForMe:(CGPoint)touchLocation
{
	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
	return CGRectContainsPoint([node boundingBox], touchLocation);
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
    
  
	CGPoint location = [RoomScene locationFromTouch:touch];
	BOOL isTouchHandled = [self isTouchForMe:location];
	if (isTouchHandled)
	{
          CCLOG(@"Home Was Touched!");
		// Simply highlight the UI layer's sprite to show that it received the touch.
		CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
		NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
		
		((CCSprite*)node).color = ccRED;

	}
    
	return isTouchHandled;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
	CCNode* node = [self getChildByTag:UILayerTagFrameSprite];
	NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCSprite");
	
	((CCSprite*)node).color = ccWHITE;
}

@end
