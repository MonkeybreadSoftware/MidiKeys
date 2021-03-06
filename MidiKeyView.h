//
//  MidiKeyView.h
//  MidiKeys
//
//  Created by Chris Reed on Tue Oct 15 2002.
//  Copyright (c) 2002 Chris Reed. All rights reserved.
//

#import <AppKit/AppKit.h>

//! Maximum number of keys to show.
#define KEY_COUNT 120

/*!
 * @brief Information about a key on a musical keyboard.
 */
typedef struct _key_info {
	int theOctave;
	int octaveFirstNote;
	int noteInOctave;
	int isWhiteKey;
	int isBlackKey;
	int numWhiteKeys;
	int numBlackKeys;
	BOOL rightIsInset;
	BOOL leftIsInset;
} key_info_t;

/*!
 * @brief View class that displays a musical keyboard.
 */
@interface MidiKeyView : NSView
{
	id mDelegate;
	NSImage *octaveImage;
	char midiKeyStates[KEY_COUNT];
	BOOL inited;
	int numOctaves;
	int leftOctaves;
	int firstMidiNote;
	int lastMidiNote;
	NSColor *mHighlightColour;
	int mClickedNote;
	NSImage *mOctaveDownImage;
	NSImage *mOctaveUpImage;
	int mOctaveOffset;
	BOOL _showKeycaps;
}

- (void)setDelegate:(id)delegate;
- delegate;

- (void)turnMidiNoteOn:(int)note;
- (void)turnMidiNoteOff:(int)note;

- (NSColor *)highlightColour;
- (void)setHighlightColour:(NSColor *)theColour;

- (int)octaveOffset;
- (void)setOctaveOffset:(int)offset;

- (BOOL)showKeycaps;
- (void)setShowKeycaps:(BOOL)show;

@end

@interface NSObject (MidiKeyViewControllerMethods)

- (void)processMidiKeyWithCode:(int)keycode turningOn:(BOOL)isTurningOn;
- (void)processMidiKeyClickWithNote:(int)note turningOn:(BOOL)isTurningOn;

- (NSString *)characterForMidiNote:(int)note;

@end


