//
// Created by CreatureSurvive on 1/28/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackContainer.h"


@interface SnapshotView : StackContainer

- (SnapshotView *)initWithFrame:(CGRect)frame;

- (void)setImage:(UIImage *)image;
@end