//
//  MCSoundManager.m
//  Wallet
//
//  Created by Matthew Cheok on 25/10/12.
//  Copyright (c) 2012 Matthew Cheok. All rights reserved.
//

#import "MCSoundManager.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation MCSoundManager {
    SystemSoundID _bipOnSound;
    SystemSoundID _bipOffSound;
    SystemSoundID _clickOnSound;
    SystemSoundID _clickOffSound;    
}

CFURLRef CFURLRefForSoundWithName(NSString *name) {
    return (__bridge CFURLRef) [[NSBundle mainBundle] URLForResource:name withExtension:@"aif"];
}

+ (id)sharedManager
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        AudioServicesCreateSystemSoundID(CFURLRefForSoundWithName(@"bip1"), &_bipOnSound);
        AudioServicesCreateSystemSoundID(CFURLRefForSoundWithName(@"bip2"), &_bipOffSound);
        AudioServicesCreateSystemSoundID(CFURLRefForSoundWithName(@"click1"), &_clickOnSound);
        AudioServicesCreateSystemSoundID(CFURLRefForSoundWithName(@"click2"), &_clickOffSound);
    }
    return self;
}

- (void)playBipOnSound {
    AudioServicesPlaySystemSound(_bipOnSound);
}
- (void)playBipOffSound {
    AudioServicesPlaySystemSound(_bipOffSound);
}

- (void)playClickOnSound {
    AudioServicesPlaySystemSound(_clickOnSound);
}
- (void)playClickOffSound {
    AudioServicesPlaySystemSound(_clickOffSound);
}

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(_clickOnSound);
    AudioServicesDisposeSystemSoundID(_clickOffSound);
}

@end
