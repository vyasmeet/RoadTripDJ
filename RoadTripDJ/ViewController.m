//
//  ViewController.m
//  RoadTripDJ
//
//  Created by Meet Vyas on 18/04/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import "ViewController.h"
#import "PlaylistDataSource.h"
#import "SamplePlaylistItem.h"
#import "PlaylistHeaderView.h"

@import MediaPlayer;

@interface ViewController () <MPMediaPickerControllerDelegate, PlayerBarDelegate, UICollectionViewDelegate>

@property (nonatomic, strong) MPMediaItemCollection *playlist;
@property (nonatomic, strong) MPMusicPlayerController *player;
//@property (nonatomic, strong) UIBarButtonItem *playButton;
@property (nonatomic, weak) IBOutlet PlayerBar *playerBar;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIView *headerContainerView;
@property (nonatomic, strong) IBOutlet PlaylistDataSource *playlistDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.player = [[MPMusicPlayerController alloc] init];
    self.collectionView.contentInset = UIEdgeInsetsMake(-64, 0, 44, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(-64, 0, 44, 0);
    UINib *headerNib = [UINib nibWithNibName:@"PlaylistHeaderView" bundle:nil];
    NSArray *objects = [headerNib instantiateWithOwner:self options:nil];
    
    // Setting up the cell width as per the screen's width
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGSize itemSize = flowLayout.itemSize;
    itemSize.width = self.view.frame.size.width;
    flowLayout.itemSize = itemSize;
    
    // Setting headerview for collectionview
    PlaylistHeaderView *header = [objects firstObject];
    header.translatesAutoresizingMaskIntoConstraints = NO;
    [self.headerContainerView addSubview:header];
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[header]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(header)];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[header]|"
                                                                                                     options:0
                                                                                                     metrics:nil
                                                                                                       views:NSDictionaryOfVariableBindings(header)]];
    [NSLayoutConstraint activateConstraints:constraints];

    
#if TARGET_IPHONE_SIMULATOR
    NSArray *items = @[
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inutero.jpg"] artist:@"Nirvana" title:@"Heart-Shaped Box"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inrainbows.jpg"] artist:@"Radiohead" title:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"aenima.jpg"] artist:@"Tool" title:@"Forty-six and Two"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"meddle.jpg"] artist:@"Pink Floyd" title:@"Echoes"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"andjustice.jpg"] artist:@"Metallica" title:@"One"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"bloodsugar.jpg"] artist:@"Red Hot Chili Peppers" title:@"Give it Away"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inrainbows.jpg"] artist:@"Radiohead" title:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"ten.jpg"] artist:@"Pearl Jam" title:@"Ten"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"darkside.jpg"] artist:@"Pink Floyd" title:@"The Great Gig in the Sky"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"dummy.jpg"] artist:@"Portishead" title:@"Strangers"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"suburbs.jpg"] artist:@"Arcade Fire" title:@"Modern Man"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"housesoftheholy.jpg"] artist:@"Led Zeppelin" title:@"No Quarter"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"kindofblue.jpg"] artist:@"Miles Davis" title:@"Freddie Freeloader"]
                       ];
    self.playlistDataSource.items = items;
    self.playerBar.enabled = YES;
#endif
    self.playlistDataSource.playlistHeaderView = header;
}

- (void)togglePlayPause {
    
    if (self.player.playbackState == MPMusicPlaybackStatePlaying) {
        NSLog(@"Pausing");
        [self.player pause];
        [self.playerBar setPlayButtonState:NO];
    } else {
        NSLog(@"Playing");
        [self.player play];
        [self.playerBar setPlayButtonState:YES];
    }
}

- (UIBarButtonItem *)playButtonItemForPlaybackState:(MPMusicPlaybackState) state {
    UIBarButtonSystemItem systemItem;
    if (state == MPMusicPlaybackStatePlaying) {
        systemItem = UIBarButtonSystemItemPause;
    } else {
        systemItem = UIBarButtonSystemItemPlay;
    }
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:@selector(playPaused:)];
    return buttonItem;
}

#pragma mark - Actions

- (IBAction)playPaused:(id)sender {
    [self togglePlayPause];
}

- (IBAction)addMusic:(id)sender {
    
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.prompt = @"Add music to your playlist";
    mediaPicker.showsCloudItems = YES;
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    [self presentViewController:mediaPicker animated:YES completion:nil];
}

#pragma mark - MPMediaPickerControllerDelgate 

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    NSLog(@"%@",NSStringFromSelector(_cmd)); // Printing the current selector
    if (!self.playlist ) {
        self.playlist = mediaItemCollection;
    } else {
        NSMutableArray *items = [NSMutableArray arrayWithCapacity: self.playlist.count + mediaItemCollection.count];
        [items addObjectsFromArray:self.playlist.items];
        [items addObjectsFromArray:mediaItemCollection.items];
        MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:items];
        self.playlist = collection;
    }
    
    self.playerBar.enabled = YES;
    
    int index = 1;
    for (MPMediaItem * item in self.playlist.items) {
        NSLog(@"%d) %@ - %@", index++, item.artist, item.title);
    }
    
    [self.player setQueueWithItemCollection:self.playlist];
    
    self.playlistDataSource.items = self.playlist.items;
    
    if (self.player.playbackState != MPMusicPlaybackStatePlaying) {
//        NSLog(@"self.player.playbackState is not playing... Start playing");
        [self togglePlayPause];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PlayerBar Delegate methods

- (void)playerBarNextTrack:(PlayerBar *)playerBar {
    self.playlistDataSource.currentTrackIndex += 1;
}

- (void)playerBarPreviousTrack:(PlayerBar *)playerBar {
    self.playlistDataSource.currentTrackIndex -= 1;
}

- (void)playerBarPlayPause:(PlayerBar *)playerBar {
    [self togglePlayPause];
}

#pragma mark - UICollectionView delegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // check if this is the current playing track
    if (indexPath.row == self.playlistDataSource.currentTrackIndex) {
        return;
    }
    
#if !TARGET_IPHONE_SIMULATOR
    self.playlistDataSource.currentTrackIndex = indexPath.row;
    
    MPMediaItem *item = self.playlist.items[indexPath.row];
    [self.player setNowPlayingItem:item];
    if (self.player.playbackState == MPMusicPlaybackStateStopped ||
        self.player.playbackState == MPMusicPlaybackStatePaused) {
        [self.player play];
    }
#endif
}

@end
