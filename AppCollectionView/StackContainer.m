//
// Created by CreatureSurvive on 1/28/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import "StackContainer.h"


@implementation StackContainer {
    CGFloat _height;
}

- (StackContainer *)initWithSize:(CGSize)size {
    return [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
}

- (StackContainer *)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _height = frame.size.height;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width, _height);
}

- (void)setHeight:(CGFloat)height {
    _height = height;
}
@end
