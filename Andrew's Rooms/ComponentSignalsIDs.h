//
//  ComponentSignalsIDs.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Andrew_s_Rooms_ComponentSignalsIDs_h
#define Andrew_s_Rooms_ComponentSignalsIDs_h

typedef enum {
    AllComponentsInitialized,
    NeedToSetDetectionRect,
    GameObjectWasTouched,
    GameObjectSubspriteWasTouched,
    RoomObjectWasTouched,
    TouchDetectionRectWasFound,
    TouchDetectionRectChanged,
    InfoBubbleWasTouched,
    InfoBubbleWasDisplayed,
    OtherInfoBubbleWasDisplayed,
    InfoBubbleWentInvisible,
    BackButtonWasTouched,
    BackButtonWasDisplayed,
    TransitionToCloseUpStateSignal,
    TransitionToRegularStateSignal,
    TransitionSpriteStateSignal,
    LinkStateChangeHappened,
    ActivationComponentAdded,
    ActivatorSubObjectWasTouched,
    UnlockAllLockedSubObjects,
    LockAllNonActivatorSubObjects,
    AddLockToMe,
    UnlockThisObject,
    LockThisObject,
    IWasUnlocked,
    IWasLocked,
    ChangeLinkedObjectState,
    CollectabilityWasTriggered,
    ObjectWasCollected,
    AddObjectToInventoryBar,
}SignalID;


#endif
