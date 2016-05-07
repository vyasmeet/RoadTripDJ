//
//  SamplePlaylistItem.m
//  RoadTripDJ
//
//  Created by Meet_MacMini on 5/5/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import "SamplePlaylistItem.h"

@implementation SamplePlaylistItem

- (instancetype)initWithImage:(UIImage *)image artist:(NSString *)artist title:(NSString *)title {
    self = [super init];
    
    if (self) {
        _image = image;
        _artist = artist;
        _title = title;
    }
    return self;
}

@end
