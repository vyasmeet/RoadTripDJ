//
//  PlaylistDataSource.h
//  RoadTripDJ
//
//  Created by Meet_MacMini on 5/5/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlaylistHeaderView.h"

@interface PlaylistDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger currentTrackIndex;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) PlaylistHeaderView *playlistHeaderView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
