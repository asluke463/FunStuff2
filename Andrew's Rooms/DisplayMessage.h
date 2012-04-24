//
//  DisplayMessage.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DisplayMessage : CCLabelTTF {
    
    CGFloat displayTime;
    NSString *message;
}

@end
