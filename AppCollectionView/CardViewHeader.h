//
// Created by CreatureSurvive on 1/29/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import "StackContainer.h"


@interface CardViewHeader : StackContainer

- (CardViewHeader *)initWithSize:(CGSize)size;

- (CardViewHeader *)initWithFrame:(CGRect)frame;

- (void)setText:(NSString *)text;

- (void)setImage:(UIImage *)image;
@end
