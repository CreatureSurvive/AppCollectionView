//
// Created by CreatureSurvive on 1/27/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ColorStyleWhite = 0,
    ColorStyleRed = 1,
    ColorStyleYellow = 2,
    ColorStyleGreen = 3
};
typedef NSInteger ColorStyle;

@interface CardViewButton : UIButton

+ (CardViewButton *)initWithTitle:(NSString *)title colorStyle:(ColorStyle)style;
@end