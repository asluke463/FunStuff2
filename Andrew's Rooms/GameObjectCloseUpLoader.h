//
//  GameObjectCloseUpLoader.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Takes a GameObject and loads it's closeup state on the screen (closeupLayer) 

@class GameObject;
@interface GameObjectCloseUpLoader : NSObject {
    
    GameObject *gameObject;
}

@end
