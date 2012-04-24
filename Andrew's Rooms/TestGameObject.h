//
//  TestGameObject.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// What kind of Components should this have? 
// InputComponent, GraphicsComponent (bunch of sprites, with different states, or no states), SoundComponent, possibly Physics Component. Make sure to check that the array of components are indeed components that inherit from a Component protocol

@interface TestGameObject : CCNode <UIGestureRecognizerDelegate> {
    
}

@end
