//
//  InputComponent.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Component.h"
#include "cocos2d.h"

@class GameObject;
@interface InputComponent : CCNode <Component, CCTargetedTouchDelegate> {
    
    GameObject *gameObject;
    
    CGRect touchDetectionRect;
    BOOL on;
}

@property (nonatomic, assign) GameObject *gameObject;
@property (nonatomic, assign) CGRect touchDetectionRect;
@property (nonatomic, assign) BOOL on;

+ (id)inputComponentWithParent:(GameObject *)parent detectionRect:(CGRect)rect;
+ (id)inputComponentWithParent:(GameObject *)parent;


@end
