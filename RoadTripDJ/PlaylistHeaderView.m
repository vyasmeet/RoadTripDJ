//
//  PlaylistHeaderView.m
//  RoadTripDJ
//
//  Created by Meet_MacMini on 5/6/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import "PlaylistHeaderView.h"

@implementation PlaylistHeaderView

- (void)setPlaylistItem:(id<PlaylistItem>)playlistItem animated:(BOOL)animated {
    
//    var block = { () -> Void in
//        print("Sample block in swift")
//    }
    
    void (^updateBlock)() = ^ {
        self.artistLabel.text = playlistItem.artist;
        self.songLabel.text = playlistItem.title;
        self.blurredImageView.image = playlistItem.image;
        self.imageView.image = playlistItem.image;
    };
    
    if (animated) {
        UIView *previousState = [self snapshotViewAfterScreenUpdates:NO];
        [self addSubview:previousState];
        updateBlock();
        // Check the animation speed with Simulator Debug menu -> Slow Animation (Command+T)
        [UIView animateWithDuration:0.3 animations:^{
            previousState.alpha = 0;
        } completion:^(BOOL finished) {
            [previousState removeFromSuperview];
        }];
    } else {
        updateBlock();
    }
}

@end
