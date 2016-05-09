//
//  PlayerBar.h
//  RoadTripDJ
//
//  Created by Meet Vyas on 28/04/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+BackgroundColorForState.h"

@protocol PlayerBarDelegate;


IB_DESIGNABLE
@interface PlayerBar : UIToolbar

@property (nonatomic, weak) IBOutlet id<PlayerBarDelegate> playerBarDelegate;
@property (nonatomic, assign) IBInspectable CGFloat spacing;
@property (nonatomic, assign) BOOL enabled;
- (void)setPlayButtonState:(BOOL)isPlaying;
@end

@protocol PlayerBarDelegate <NSObject>

- (void)playerBarPreviousTrack:(PlayerBar *)playerBar;
- (void)playerBarNextTrack:(PlayerBar *)playerBar;
- (void)playerBarPlayPause:(PlayerBar *)playerBar;

@end
