//
//  MidiKeysApplication.m
//  MidiKeys
//
//  Created by Chris Reed on Sun Oct 27 2002.
//  Copyright (c) 2002 Chris Reed. All rights reserved.
//

#import "MidiKeysApplication.h"


enum {
	// NSEvent subtypes for hotkey events (undocumented).
	kEventHotKeyPressedSubtype = 6,
	kEventHotKeyReleasedSubtype = 9
};

static struct {
	BOOL valid;
	BOOL pressed;
	BOOL released;
} cachedDelegateHandles = { NO, NO, NO };

@implementation MidiKeysApplication

- (void)sendEvent:(NSEvent *)theEvent
{
	if ([theEvent type] == NSSystemDefined)
	{
		// cache the results of these -respondsToSelector: messages so
		// we handle hot keys as fast as possible (even though it's only
		// a few method calls, it does affect the note on latency)
		if (!cachedDelegateHandles.valid)
		{
			if ([self delegate])
			{
				cachedDelegateHandles.pressed = [[self delegate] respondsToSelector:@selector(hotKeyPressed:)];
				cachedDelegateHandles.released = [[self delegate] respondsToSelector:@selector(hotKeyReleased:)];
			}
			else
			{
				cachedDelegateHandles.pressed = NO;
				cachedDelegateHandles.released = NO;
			}
			cachedDelegateHandles.valid = YES;
		}
		// pass the hot key event on to the delegate.
		switch ([theEvent subtype])
		{
			case kEventHotKeyPressedSubtype:
				if (cachedDelegateHandles.pressed)
				{
					[[self delegate] hotKeyPressed:[theEvent data1]];
				}
				break;
			case kEventHotKeyReleasedSubtype:
				if (cachedDelegateHandles.released)
				{
					[[self delegate] hotKeyReleased:[theEvent data1]];
				}
				break;
		}
	}
	
	[super sendEvent:theEvent];
}

// invalidate the cache
- (void)setDelegate:(id)delegate
{
	cachedDelegateHandles.valid = NO;
	[super setDelegate:delegate];
}

@end

