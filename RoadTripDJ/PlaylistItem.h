//
//  PlaylistItem.h
//  RoadTripDJ
//
//  Created by Meet_MacMini on 5/5/16.
//  Copyright © 2016 Meet Vyas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PlaylistItem <NSObject>

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) NSString *title;

@end
