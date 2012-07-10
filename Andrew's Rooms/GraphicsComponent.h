//
//  GraphicsComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Component.h"

@class GameObject;
@interface GraphicsComponent : NSObject <Component> {

    GameObject *gameObject;
    
    CGRect trueRect; // doesn't count transparency space
    
    CGPoint position;
    
    CGFloat scale;
    
    int zOrder;
}
@property (nonatomic, assign) GameObject *gameObject;
@property (nonatomic, assign)  CGFloat scale;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int zOrder;
@property (nonatomic, assign) CGRect trueRect;

//- (id)initWithGameObject:(GameObject *)gameObj;
//+ (id)graphicsComponentWithGameObject:(GameObject *)gameObj;
//
//- (id)initWithGameObjectBaseName:(NSString *)baseName;
//+ (id)graphicsComponentWithGameObjectBaseName:(NSString *)baseName;

//-(CGRect)getCurrentDetectionRect; 
@end
