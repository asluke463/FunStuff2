//
//  CloseUpLayer.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CloseUpLayer.h"
#import "RoomScene.h"
#import "RoomObject.h"
#import "BackButton.h"

@implementation CloseUpLayer

@synthesize backButton;

- (id)init {
    
    if ((self = [super init])) {

        self.scale = 1.0;
        self.visible = NO;
        [self addBackButton];
    }   
    return self;
}
// just trying this out, putting same node on two different layers 
- (void)loadRoomObject:(RoomObject *)roomObject {
    self.backButton.backButtonSprite.color = ccWHITE;
    self.visible = YES;
    [self addChild:roomObject z:0 tag:roomObject.tag];
}

- (void)addBackButton {
     self.backButton = [BackButton backButton];
  
    [self addChild:self.backButton z:1 tag:BackButtonTag];
}





@end
