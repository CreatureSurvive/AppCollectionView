//
// Created by CreatureSurvive on 1/29/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import "CardViewHeader.h"
#import "ColorProvider.h"

@interface CardViewHeader ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *icon;
@end

@implementation CardViewHeader {

}

- (CardViewHeader *)initWithSize:(CGSize)size {
    return [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
}

- (CardViewHeader *)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

        // header label
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.label setFont:[UIFont systemFontOfSize:25 weight:UIFontWeightSemibold]];
        [self.label setTextColor:[ColorProvider textColor]];

        // header icon
        self.icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.icon setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.icon setContentMode:UIViewContentModeScaleAspectFill];
        [self.icon setBackgroundColor:[UIColor lightGrayColor]];
        [self.icon setClipsToBounds:YES];
        [self.icon.layer setCornerRadius:10];

        [self addSubview:self.label];
        [self addSubview:self.icon];

        [self updateConstraints];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.icon.layer setCornerRadius:(CGRectGetHeight(self.bounds) * 0.6f) / 4];
    [self.label setFont:[UIFont systemFontOfSize:CGRectGetHeight(self.bounds) / 3 weight:UIFontWeightSemibold]];
}

- (void)updateConstraints {
    [super updateConstraints];

    [self addConstraints:@[
            [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:20.0f],
            [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:70.0f],
            [NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.4f constant:0.0f],

            [NSLayoutConstraint constraintWithItem:_icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.6f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:_icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.6f constant:0.0f],
            [NSLayoutConstraint constraintWithItem:_icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:5.0f],
            [NSLayoutConstraint constraintWithItem:_icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-20.0f],
    ]];
}

- (void)setText:(NSString *)text {
    [self.label setText:text];
}

- (void)setImage:(UIImage *)image {
    [self.icon setImage:image];
}
@end