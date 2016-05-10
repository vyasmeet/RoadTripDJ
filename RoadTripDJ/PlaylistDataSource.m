//
//  PlaylistDataSource.m
//  RoadTripDJ
//
//  Created by Meet_MacMini on 5/5/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import "PlaylistDataSource.h"
#import "PlaylistItemCollectionViewCell.h"
#import "PlaylistItem.h"


@implementation PlaylistDataSource

- (void)setPlaylistHeaderView:(PlaylistHeaderView *)playlistHeaderView {
    _playlistHeaderView = playlistHeaderView;
    if (self.items.count > 0) {
        id<PlaylistItem> item = self.items[_currentTrackIndex];
        [self.playlistHeaderView setPlaylistItem:item animated:YES];
    }
}

- (void)setCurrentTrackIndex:(NSInteger)currentTrackIndex {
    
    if (currentTrackIndex >= (NSInteger)self.items.count) {
        currentTrackIndex = 0;
    } else if (_currentTrackIndex < 0) {
        currentTrackIndex = self.items.count - 1;
    }
    
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForItem:_currentTrackIndex inSection:0];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:currentTrackIndex inSection:0];
    
    _currentTrackIndex = currentTrackIndex;
    
    id<PlaylistItem> item = self.items[_currentTrackIndex];
    [self.playlistHeaderView setPlaylistItem:item animated:YES];
    
    if (self.items.count > _currentTrackIndex + 1) {
        NSIndexPath *nextTrackIndexPath = [NSIndexPath indexPathForItem:_currentTrackIndex+1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextTrackIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    } else if (self.items.count-1 == _currentTrackIndex) {
        NSIndexPath *firstTrackIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:firstTrackIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
    
    [self.collectionView reloadItemsAtIndexPaths:@[oldIndexPath,newIndexPath]];
}

- (void)setItems:(NSArray *)items {
    _items = items;
    if (self.items.count > 0) {
        id<PlaylistItem> item = self.items[_currentTrackIndex];
        [self.playlistHeaderView setPlaylistItem:item animated:YES];
    }
    [self.collectionView reloadData];
    if (self.items.count > 1) {
        NSIndexPath *nextItemIndexPath = [NSIndexPath indexPathForItem:_currentTrackIndex+1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextItemIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaylistItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                           forIndexPath:indexPath];
    id<PlaylistItem> playlistItem = self.items[indexPath.row];
    cell.imageView.image = playlistItem.image;
    cell.songLabel.text = playlistItem.title;
    cell.artistLabel.text = playlistItem.artist;
    
    if (indexPath.row == self.currentTrackIndex) {
        cell.backgroundColor = [UIColor darkGrayColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0.33/255.0 green:0.33/255.0 blue:0.33/255.0 alpha:1.0];
    }
    
    return cell;
}

@end