//
//  ObjectSprite.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectSprite.h"
#import "Tags.h"
#import "GameObject.h"


@implementation ObjectSprite

@synthesize touchDetectionRect, frameDataArray, spriteState, spriteFrameBaseName;

+ (id)spriteWithParent:(GameObject *)parent spriteFrameName:(NSString *)spriteFrameName frameArray:(NSArray *)frameDataArr {
    
   return [[[self alloc] initWithParent:parent spriteFrameName:spriteFrameName frameArray:frameDataArr] autorelease];
}

- (id)initWithParent:(GameObject *)parent spriteFrameName:(NSString *)spriteFrameName frameArray:(NSArray *)frameDataArr {
    
    self.frameDataArray = [[NSArray alloc] initWithArray:frameDataArr];
    
    NSDictionary *propertyMap = [[NSDictionary alloc] initWithDictionary:[self.frameDataArray objectAtIndex:0]];
    self.spriteFrameBaseName = [[NSString alloc] initWithFormat:spriteFrameName];
    NSString *frameName0 = [[NSString alloc] initWithFormat:@"%@_State0.png", spriteFrameName];
    if ((self = [super initWithSpriteFrameName:frameName0])) {

        self.spriteState = State0;
        // Set position (location on parent)
        self.position = CGPointMake([(NSNumber *)[propertyMap objectForKey:@"posX"] floatValue], [(NSNumber *)[propertyMap objectForKey:@"posY"] floatValue]);
        
        [parent addChild:self z:[(NSNumber *)[propertyMap objectForKey:@"zOrder"] intValue] tag:[Tags convertToObjectTagFromString:spriteFrameName]];
        
//        CGFloat midX = [self boundingBox].origin.x + [self boundingBox].size.width/2;
//        CGFloat midY = [self boundingBox].origin.y + [self boundingBox].size.height/2;
//        CGPoint worldLocation = [self convertToWorldSpace:CGPointMake(midX, midY)]; 
        
        //        CGPoint parentWorldPosition = [self convertToWorldSpace:parent.position];
        //        CGFloat midX = parentWorldPosition.x;
        //        CGFloat midY = parentWorldPosition.y;
//        [self convertToWorldSpaceAR:
//        self.touchDetectionRect = CGRectMake(midX-([(NSNumber *)[propertyMap objectForKey:@"realWidth"] floatValue])/2, midY - ([(NSNumber *)[propertyMap objectForKey:@"realHeight"] floatValue])/2, ([(NSNumber *)[propertyMap objectForKey:@"realWidth"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realHeight"] floatValue]));
        self.touchDetectionRect = CGRectMake(([(NSNumber *)[propertyMap objectForKey:@"realPosX"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realPosY"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realWidth"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realHeight"] floatValue]));
        // Set the parent GameObject node's touch detection rect to the largest of its subsprites (terms of area)
        if ((self.touchDetectionRect.size.width*self.touchDetectionRect.size.height) > (parent.touchDetectionRect.size.width * parent.touchDetectionRect.size.height)) {
            [parent updateDetectionRect:self.touchDetectionRect];
        }
    }
    [frameName0 release];
    [propertyMap release];
    return self;
}

- (BOOL)isTouchForMe:(CGPoint)touchLocation {
    
    return CGRectContainsPoint(self.touchDetectionRect, touchLocation);
}

// This method finds the best touchDetectionRect for the parent GameObject
- (void)updateGameObjectDetectionRect {
    
    GameObject *parent = (GameObject *)parent_;
    
    // If we're transitioning from CloseUpState to RegularState, then we must change the touchRect back to the smaller rect. 
    
    CGFloat selfDetectArea = self.touchDetectionRect.size.width * self.touchDetectionRect.size.height;
    CGFloat parentDetectArea = parent.touchDetectionRect.size.width * parent.touchDetectionRect.size.height;
   
    if ([parent interactionState] == CloseUpState) {
        if (selfDetectArea < parentDetectArea && (selfDetectArea > 0)) {
            [parent updateDetectionRect:self.touchDetectionRect];
        }
        
    } else {
        if ((selfDetectArea > parentDetectArea) && (selfDetectArea > 0)) {
            [parent updateDetectionRect:self.touchDetectionRect];
        }
    }
}

- (void)setSpritePropertiesWithDictionary:(NSDictionary *)propertyMap {
    
    self.position = CGPointMake([(NSNumber *)[propertyMap objectForKey:@"posX"] floatValue], [(NSNumber *)[propertyMap objectForKey:@"posY"] floatValue]);

//    CGFloat midX = [self boundingBox].origin.x + [self boundingBox].size.width/2;
//    CGFloat midY = [self boundingBox].origin.y + [self boundingBox].size.height/2;
//    CGPoint worldLocation = [self convertToWorldSpace:CGPointMake(midX, midY)]; 
    
    //        CGPoint parentWorldPosition = [self convertToWorldSpace:parent.position];
    //        CGFloat midX = parentWorldPosition.x;
    //        CGFloat midY = parentWorldPosition.y;
    //        [self convertToWorldSpaceAR:
    self.touchDetectionRect = CGRectMake(([(NSNumber *)[propertyMap objectForKey:@"realPosX"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realPosY"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realWidth"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realHeight"] floatValue]));

    
    [self updateGameObjectDetectionRect];

}

- (void)switchSpriteFrameAndSetProperties {
    CCSpriteFrame* frame;
    SpriteState oldState = self.spriteState;
    
    switch (self.spriteState) {
        case State0:
            self.spriteState = State1;
//            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State1.png", self.spriteFrameBaseName]];
            break;
        case State1:
            self.spriteState = State0;
//            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State0.png", self.spriteFrameBaseName]];
            break;
            
            /** STATE 2 3 ARE CLOSEUP STATES */
        case State2:
            self.spriteState = State3;
//            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State3.png", self.spriteFrameBaseName]];
            break;
        case State3:
            self.spriteState = State2;
//            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State2.png", self.spriteFrameBaseName]];
            break;
            
        default:
            break;
    }
    
    frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State%d.png", self.spriteFrameBaseName, self.spriteState]];
    
    // only switch to different sprite if an alternate state actually exists
    if (![[self.frameDataArray objectAtIndex:self.spriteState] isEqual:@"dummy"]) {
        [self setSpritePropertiesWithDictionary:[NSDictionary dictionaryWithDictionary:[self.frameDataArray objectAtIndex:self.spriteState]]];
        [self setDisplayFrame:frame];
    } else {
        self.spriteState = oldState;
    }
//    [self setSpritePropertiesWithDictionary:[NSDictionary dictionaryWithDictionary:[self.frameDataArray objectAtIndex:self.spriteState]]];
//    [self setDisplayFrame:frame];

}

- (void)toggleBetweenRegularAndCloseUpState {
    CCSpriteFrame* frame;
    
    SpriteState oldState = self.spriteState;
    
    switch (self.spriteState) {
        case State0:
            self.spriteState = State2;
            //            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State1.png", self.spriteFrameBaseName]];
            break;
        case State1:
            self.spriteState = State3;
            //            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State0.png", self.spriteFrameBaseName]];
            break;
            
            /** STATE 2 3 ARE CLOSEUP STATES */
        case State2:
            self.spriteState = State0;
            //            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State3.png", self.spriteFrameBaseName]];
            break;
        case State3:
            self.spriteState = State1;
            //            frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State2.png", self.spriteFrameBaseName]];
            break;
            
        default:
            break;
    }
    
    frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_State%d.png", self.spriteFrameBaseName, self.spriteState]];
    
    // only switch to different sprite if an alternate state actually exists
    if (![[self.frameDataArray objectAtIndex:self.spriteState] isEqual:@"dummy"]) {
        [self setSpritePropertiesWithDictionary:[NSDictionary dictionaryWithDictionary:[self.frameDataArray objectAtIndex:self.spriteState]]];
        [self setDisplayFrame:frame];
    } else {
        self.spriteState = oldState;
    }
    
}


- (void)iWasTouched {

    // switch the displayed spriteFrame if there is more than one state
    if ([self.frameDataArray count] > 1) {
        [self switchSpriteFrameAndSetProperties];
    }
}


- (void)dealloc
{
    [frameDataArray release];
    [spriteFrameBaseName release];
    [super dealloc];
}

@end
