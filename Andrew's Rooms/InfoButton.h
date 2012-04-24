//
//  InfoButton.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tags.h"

@interface InfoButton : CCNode <CCTargetedTouchDelegate> {
    
    ObjectTags objectTag;
    
    CCSprite *infoBubbleSprite;
    
    CGPoint originalPosition;
}

@property (nonatomic, assign) ObjectTags objectTag;
@property (nonatomic, retain) CCSprite *infoBubbleSprite;
@property (nonatomic, assign) CGPoint originalPosition;
           

+ (InfoButton *)infoBubbleForObject:(NSString *)baseName position:(CGPoint)pos;

//-(void) registerWithTouchDispatcher;
//- (void)loadCloseUpObject;
- (void)makeInvisible;
- (void)displaySelf;
//- (void)animateToEndState;
@end
