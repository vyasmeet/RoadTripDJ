//
//  PlaylistHeaderView.h
//  RoadTripDJ
//
//  Created by Meet_MacMini on 5/6/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaylistItem.h"

@interface PlaylistHeaderView : UICollectionReusableView

@property (nonatomic, weak) IBOutlet UIImageView *blurredImageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *songLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;

- (void)setPlaylistItem:(id<PlaylistItem>)playlistItem animated:(BOOL)animated;

@end
