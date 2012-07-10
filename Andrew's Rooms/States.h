//
//  States.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Andrew_s_Rooms_States_h
#define Andrew_s_Rooms_States_h

typedef enum {
    
    RegularState,
    CloseUpState,
    NonInteractiveState,
    
} InteractionState;

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
    
    
} SubObjectState;


#endif
