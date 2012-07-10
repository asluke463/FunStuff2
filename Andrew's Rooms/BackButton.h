//
//  BackButton.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tags.h"

@interface BackButton : CCNode <CCTargetedTouchDelegate> {
    
    CCSprite *backButtonSprite;
}

@property (nonatomic, assign) ObjectTags objectTag;
@property (nonatomic, retain) CCSprite *backButtonSprite;


+ (BackButton *)backButton;

@end
