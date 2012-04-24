//
//  CloseUpLayer.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

// All sprites of layer go in here

#import <Foundation/Foundation.h>
#import "cocos2d.h"


typedef enum {
    BackButtonTag,
} CloseUpLayerButtonTags;

@class GameObject;
@class BackButton;
@interface CloseUpLayer : CCLayer {
        
    BackButton *backButton;
}

@property (nonatomic, retain) BackButton *backButton;

//- (void)loadCloseUpObject:(NSString *)baseName; 
- (void)addBackButton;
- (void)loadGameObject:(GameObject *)gameObject;
@end
