//
//  MCSoundManager.h
//  Wallet
//
//  Created by Matthew Cheok on 25/10/12.
//  Copyright (c) 2012 Matthew Cheok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCSoundManager : NSObject

+ (id)sharedManager;
- (void)playBipOnSound;
- (void)playBipOffSound;
- (void)playClickOnSound;
- (void)playClickOffSound;

@end
