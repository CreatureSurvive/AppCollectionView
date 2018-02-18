//
// Created by CreatureSurvive on 1/26/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ColorProvider : NSObject
@property (nonatomic, assign) BOOL dark;

+ (ColorProvider *)pallet;

+ (UIColor *)cardColor;

+ (UIColor *)backdropColor;

+ (UIColor *)shadowColor;

+ (UIColor *)textColor;

+ (UIColor *)randomFlatColor;

+ (UIImage *)cardImage;
@end
