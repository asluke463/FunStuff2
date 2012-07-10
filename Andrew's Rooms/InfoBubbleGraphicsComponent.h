//
//  InfoBubbleGraphicsComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GraphicsComponent.h"

@class InfoBubbleComponent;
@interface InfoBubbleGraphicsComponent : GraphicsComponent {

    CCSprite *sprite;
    CGPoint originalPosition; 
}

@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, assign) CGPoint originalPosition;

+ (id)infoBubbleGraphicsComponentForInfoBubbleComponent:(InfoBubbleComponent *)bubbleComp;

@end
