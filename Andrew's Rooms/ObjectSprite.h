//
//  ObjectSprite.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    // RegularZoom
    State0, 
    State1,
    
    // CloseZoom
    State2,
    State3,
    
    // Other
    State4,
    State5,

} SpriteState;

@class GameObject;
@interface ObjectSprite : CCSprite {
        
    CGRect touchDetectionRect;

    //array of dictionaries representing different states of object and the frameName
    NSArray *frameDataArray;
    
    SpriteState spriteState;
    
    NSString *spriteFrameBaseName;
}

// These are set from the spriteMap from room plist
@property (nonatomic, assign) CGRect touchDetectionRect;
@property (nonatomic, retain) NSArray *frameDataArray;
@property (nonatomic, assign) SpriteState spriteState;
@property (nonatomic, retain) NSString *spriteFrameBaseName;


+ (id)spriteWithParent:(GameObject *)parent spriteFrameName:(NSString *)spriteFrameName frameArray:(NSArray *)frameDataArr;
- (id)initWithParent:(GameObject *)parent spriteFrameName:(NSString *)spriteFrameName frameArray:(NSArray *)frameDataArr;
- (BOOL)isTouchForMe:(CGPoint)touchLocation;
- (void)iWasTouched;
- (void)toggleBetweenRegularAndCloseUpState;


@end
