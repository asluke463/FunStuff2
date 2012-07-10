//
//  LockComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
@class GameObject;

@interface LockComponent : NSObject <Component> {
    
    GameObject *gameObject;
}

@property (nonatomic, assign) GameObject *gameObject;

+ (id)lockComponentWithGameObject:(GameObject *)gameObj;
@end
