//
// Created by CreatureSurvive on 1/26/18.
// Copyright (c) 2018 CreatureCoding. All rights reserved.
//

#import "ColorProvider.h"

@interface ColorProvider ()

@property (nonatomic, strong) UIColor *_cardColor;
@property (nonatomic, strong) UIColor *_backdropColor;
@property (nonatomic, strong) UIColor *_shadowColor;
@property (nonatomic, strong) UIColor *_textColor;

@property (nonatomic, strong) UIColor *_darkCardColor;
@property (nonatomic, strong) UIColor *_darkBackdropColor;
@property (nonatomic, strong) UIColor *_darkShadowColor;
@property (nonatomic, strong) UIColor *_darkTextColor;
@property (nonatomic, strong) NSArray *_currentPallet;
@property (nonatomic, strong) NSCache *_imageCache;

@end


@implementation ColorProvider {
}

+ (ColorProvider *)pallet {
    static dispatch_once_t onceToken;
    static ColorProvider *pallet;
    dispatch_once(&onceToken, ^{
        pallet = [[self alloc] init];
        [pallet setColors];
        pallet.dark = YES;
    });

    return pallet;
}

+ (NSArray *)currentPallet {
    if (!self.pallet._currentPallet) {
        NSMutableArray *pallet = [NSMutableArray new];
        for (int i = 0; i < 5; i++) {
            [pallet addObject:[self randomFlatColor]];
        }
        self.pallet._currentPallet = pallet;
    }
    return self.pallet._currentPallet;
}

+ (UIColor *)cardColor {
    ColorProvider *pallet = [ColorProvider pallet];

    return pallet.dark ? pallet._darkCardColor : pallet._cardColor;
}

+ (UIColor *)backdropColor {
    ColorProvider *pallet = [ColorProvider pallet];

    return pallet.dark ? pallet._darkBackdropColor : pallet._backdropColor;
}

+ (UIColor *)shadowColor {
    ColorProvider *pallet = [ColorProvider pallet];

    return pallet.dark ? pallet._darkShadowColor : pallet._shadowColor;
}

+ (UIColor *)textColor {
    ColorProvider *pallet = [ColorProvider pallet];

    return pallet.dark ? pallet._darkTextColor : pallet._textColor;
}

- (void)setColors {
    self._cardColor = [UIColor whiteColor];
    self._backdropColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self._shadowColor = [UIColor colorWithWhite:0.35 alpha:0.70];
    self._textColor = [UIColor darkGrayColor];

    self._darkCardColor = [UIColor darkGrayColor];
    self._darkBackdropColor = [UIColor colorWithWhite:0.25 alpha:1.0];
    self._darkShadowColor = [UIColor colorWithWhite:0.2 alpha:0.90];
    self._darkTextColor = [UIColor lightTextColor];
}

+ (UIColor *)randomFlatColor {
    CGFloat hue = (CGFloat)arc4random_uniform(256);
    CGFloat saturation = (CGFloat)arc4random_uniform(256);
    CGFloat brightness = (CGFloat)arc4random_uniform(100);
    return [UIColor colorWithHue:hue/255.f saturation:saturation/255.f brightness:brightness*0.01f alpha:1];
}

+ (UIImage*)cardImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.pallet._imageCache = [[NSCache alloc] init];
    });

    UIColor *color = [self currentPallet][arc4random_uniform((uint32_t)self.pallet._currentPallet.count)];
    UIImage *image = [self.pallet._imageCache objectForKey:color];

    if (!image) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(828, 1472), NO, 0);

        UIColor* logo = [UIColor colorWithRed: 0.285 green: 0.275 blue: 0.275 alpha: 1];

        UIBezierPath* backgroundPath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 828, 1472)];
        [color setFill];
        [backgroundPath fill];

        UIBezierPath* left_cardPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(580, 547, 248, 364) cornerRadius: 80];
        [logo setFill];
        [left_cardPath fill];

        UIBezierPath* center_cardPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(283, 525, 272, 409) cornerRadius: 80];
        [logo setFill];
        [center_cardPath fill];

        UIBezierPath* right_cardPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 547, 248, 364) cornerRadius: 80];
        [logo setFill];
        [right_cardPath fill];

        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.pallet._imageCache setObject:image forKey:color];
    }

    return image;
}

@end
