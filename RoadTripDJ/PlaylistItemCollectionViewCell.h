//
//  PlaylistItemCollectionViewCell.h
//  RoadTripDJ
//
//  Created by Meet_MacMini on 5/5/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaylistItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *songLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;

@end
