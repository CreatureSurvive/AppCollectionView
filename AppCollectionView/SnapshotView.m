//
// Created by CreatureSurvive on 1/28/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import "SnapshotView.h"


@interface SnapshotView ()
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *foreground;
@property (nonatomic, strong) UIVisualEffectView *blur;
@end

@implementation SnapshotView

- (SnapshotView *)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setClipsToBounds:YES];

    self.background = [[UIImageView alloc] initWithFrame:frame];
    [self.background setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.background setContentMode:UIViewContentModeScaleAspectFill];
    [self.background setBackgroundColor:[UIColor lightGrayColor]];

    self.foreground = [[UIImageView alloc] initWithFrame:frame];
    [self.foreground setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.foreground setContentMode:UIViewContentModeScaleAspectFit];

    self.blur = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.blur setFrame:self.bounds];
    [self.blur setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

    [self addSubview:self.background];
    [self addSubview:self.blur];
    [self addSubview:self.foreground];

    return self;
}

- (void)setImage:(UIImage *)image {
    [self.background setImage:image];
    [self.foreground setImage:image];
}

@end