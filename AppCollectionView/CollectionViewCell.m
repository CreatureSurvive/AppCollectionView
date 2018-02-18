//
//  CollectionViewCell.m
//  AppCollectionView
//
//  Created by CreatureSurvive on 1/25/18.
//  Copyright © 2018 CreatureCoding. All rights reserved.
//

#import "CollectionViewCell.h"
#import "ColorProvider.h"
#import "CardViewButton.h"

@interface CollectionViewCell ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIStackView *stack;
@property (strong, nonatomic) StackContainer *footer;
@end

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {

        // scrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self.scrollView setDelegate:self];
        [self.scrollView setDecelerationRate:UIScrollViewDecelerationRateFast];
        [self.scrollView setAlwaysBounceVertical:YES];
        [self.scrollView setScrollEnabled:YES];
        [self.scrollView setContentSize:frame.size];
        [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setShowsVerticalScrollIndicator:NO];

        // stack
        self.stack = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height + 140)];
        [self.stack setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.stack setAlignment:UIStackViewAlignmentFill];
        [self.stack setDistribution:UIStackViewDistributionFillProportionally];
        [self.stack setAxis:UILayoutConstraintAxisVertical];
        [self.stack setSpacing:8];

        // header
        self.cardHeader = [[CardViewHeader alloc] initWithSize:CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame) * 0.15f)];

        // snapshot
        self.cardSnapshot = [[SnapshotView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) *0.8f)];
        [self.cardSnapshot setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

        self.footer = [[StackContainer alloc] initWithSize:CGSizeMake(100, CGRectGetHeight(frame) * 0.05f)];
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(self.footer.bounds.size.width * 0.4f / 2, self.footer.bounds.size.height / 3, self.footer.bounds.size.width * 0.6f, 2)];
        [separator setBackgroundColor:[UIColor lightGrayColor]];
        [separator setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin];
        [self.footer addSubview:separator];

        CardViewButton *button = [CardViewButton initWithTitle:@"Open" colorStyle:ColorStyleGreen];
        CardViewButton *button1 = [CardViewButton initWithTitle:@"Kill" colorStyle:ColorStyleRed];
        CardViewButton *button2 = [CardViewButton initWithTitle:@"Relaunch" colorStyle:ColorStyleWhite];
        CardViewButton *button3 = [CardViewButton initWithTitle:@"Lock" colorStyle:ColorStyleYellow];

        // add views
        [self.scrollView addSubview:self.stack];
        [self.contentView addSubview:self.scrollView];

        [self.stack addArrangedSubview:self.cardHeader];
        [self.stack addArrangedSubview:self.cardSnapshot];
        [self.stack addArrangedSubview:self.footer];
        [self.stack addArrangedSubview:button];
        [self.stack addArrangedSubview:button1];
        [self.stack addArrangedSubview:button2];
        [self.stack addArrangedSubview:button3];

//        colors
        [self setBackgroundColor:[ColorProvider cardColor]];
        [self.layer setShadowColor:[[ColorProvider shadowColor] CGColor]];

//        layer
        [self.layer setCornerRadius:23.0];
        [self.layer setShadowRadius:18.0];
        [self.layer setShadowOpacity:0.8];
        [self.layer setMasksToBounds:NO];
        [self setClipsToBounds:YES];

        [self updateContentSize];
    }
    return self;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (fabs(targetContentOffset->y) < 50) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:scrollView.decelerationRate initialSpringVelocity:velocity.y options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState  animations:^{
            [self scrollToOffset:0];
        } completion:nil];
    } else {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:scrollView.decelerationRate initialSpringVelocity:velocity.y options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState  animations:^{
            [self scrollToOffset:(self.stack.frame.size.height - self.scrollView.frame.size.height)];
        } completion:nil];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!scrollView.decelerating) {
        if (scrollView.contentOffset.y < 50) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self scrollToOffset:0];
            } completion:nil];
        } else {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self scrollToOffset:(self.stack.frame.size.height - self.scrollView.frame.size.height)];
            } completion:nil];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateContentSize];
}

- (void)setCellScale:(CGFloat)cellScale {
    _cellScale = cellScale;

    self.transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformMakeScale(cellScale, cellScale);

}

- (void)setCellImage:(UIImage *)image {
    if (!image) image = [ColorProvider cardImage];
    [self.cardSnapshot setImage:image];
}

- (void)updateContentSize {
    [self.cardSnapshot setHeight:CGRectGetHeight(self.frame) * 0.8f];
    [self.cardHeader setHeight:CGRectGetHeight(self.frame) * 0.15f];
    [self.footer setHeight:CGRectGetHeight(self.frame) * 0.05f];
    [self.cardSnapshot invalidateIntrinsicContentSize];
    [self.cardHeader invalidateIntrinsicContentSize];
    [self.footer invalidateIntrinsicContentSize];

    [self.scrollView setContentSize:CGSizeMake(self.stack.bounds.size.width, self.stack.bounds.size.height + 40)];

}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.scrollView setContentOffset:CGPointZero];
}

- (void)scrollToOffset:(CGFloat)offset {
    [self.scrollView setContentOffset:CGPointMake(0, offset)];
}

@end
