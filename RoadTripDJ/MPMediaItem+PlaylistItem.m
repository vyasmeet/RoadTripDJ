//
//  MPMediaItem+PlaylistItem.m
//  RoadTripDJ
//
//  Created by Meet Vyas on 07/05/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import "MPMediaItem+PlaylistItem.h"

@implementation MPMediaItem (PlaylistItem)

- (UIImage *)image {
    // TODO: Change this later
    return [self.artwork imageWithSize:CGSizeMake(600, 600)];
}

@end
