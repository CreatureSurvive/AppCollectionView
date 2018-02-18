//
// Created by CreatureSurvive on 1/27/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import "CardViewButton.h"


@implementation CardViewButton {
}

+ (CardViewButton *)initWithTitle:(NSString *)title colorStyle:(ColorStyle)style {
    CardViewButton *button = (CardViewButton *) [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];

    switch (style) {
        case ColorStyleWhite: {
            [button setBackgroundColor:[UIColor colorWithWhite:0.65 alpha:0.5]];
        } break;

        case ColorStyleRed: {
            [button setBackgroundColor:[UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.5]];
        } break;

        case ColorStyleYellow: {
            [button setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.1 alpha:0.5]];
        } break;

        case ColorStyleGreen: {
            [button setBackgroundColor:[UIColor colorWithRed:0.1 green:0.9 blue:0.1 alpha:0.5]];
        } break;

        default: {
            [button setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.5]];
        } break;
    }

    [button.layer setCornerRadius:10];
    [button setClipsToBounds:YES];
    return button;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width, 44);
}

@end