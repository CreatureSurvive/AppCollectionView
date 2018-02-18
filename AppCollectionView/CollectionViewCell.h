//
//  CollectionViewCell.h
//  AppCollectionView
//
//  Created by CreatureSurvive on 1/25/18.
//  Copyright © 2018 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnapshotView.h"
#import "CardViewHeader.h"

@interface CollectionViewCell : UICollectionViewCell <UIScrollViewDelegate>

@property (strong, nonatomic) CardViewHeader *cardHeader;
@property (strong, nonatomic) SnapshotView *cardSnapshot;
@property (assign, nonatomic) CGFloat cellScale;

- (void)setCellImage:(UIImage *)image;
@end
