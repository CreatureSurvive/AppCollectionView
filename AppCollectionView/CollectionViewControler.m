//
//  ViewController.m
//  AppCollectionView
//
//  Created by CreatureSurvive on 1/25/18.
//  Copyright © 2018 CreatureCoding. All rights reserved.
//

#import "CollectionViewControler.h"
#import "CollectionViewCell.h"
#import "ColorProvider.h"

@interface CollectionViewControler ()
@property (weak, nonatomic) IBOutlet UIView *collectionContainer;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger targetCellIndex;
@property (nonatomic, assign) CGSize cellSize;
@end

@implementation CollectionViewControler

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [ColorProvider backdropColor];

    _dataSource = [@[@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4),@(0),@(1),@(2),@(3),@(4)] mutableCopy];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.collectionContainer.bounds collectionViewLayout:layout];
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [_collectionView setValue:[NSValue valueWithCGSize:CGSizeMake(0.996000f,0.996000f)] forKey:@"_decelerationFactor"];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"itemCell"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    
    [_collectionView setShowsHorizontalScrollIndicator:NO];
    [_collectionView setShowsVerticalScrollIndicator:NO];
    
    [_collectionView setClipsToBounds:NO];
    
    [self.collectionContainer addSubview:_collectionView];
    
    [self updateViewForSize:_collectionContainer.bounds.size];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self settleOnCell];
    [self layoutVisibleCells];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self updateViewForSize:_collectionContainer.bounds.size];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self settleOnCell];
        [self layoutVisibleCells];
    }];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"itemCell";

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [cell.cardHeader setText:[NSString stringWithFormat:@"%ld-%ld", (long)indexPath.row, (long)indexPath.section]];

    [cell setCellImage:[UIImage imageNamed:[NSString stringWithFormat:@"snapshot_%ld.png", (long) indexPath.row]] ? : nil];

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _cellSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self layoutVisibleCells];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_targetCellIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    float target = targetContentOffset->x;
    float remainder = target / _cellSize.width;
    _targetCellIndex = lroundl(remainder);
}

#pragma mark - Custom Methods

- (void)layoutVisibleCells {

    float centerOfView = _collectionView.contentOffset.x + (_collectionView.frame.size.width)/2;
    float closestDistance = FLT_MAX;

    for (CollectionViewCell *cell in _collectionView.visibleCells) {

        float cellOffset = centerOfView - cell.center.x;
        if (cellOffset < 0) { cellOffset *= -1; }

        float offsetPercentage = cellOffset / (self.collectionContainer.bounds.size.width * 5.0f);
        [cell setCellScale:1.0f-offsetPercentage];

        if (cellOffset < closestDistance) {
            closestDistance = cellOffset;
        }
    }
}

- (void)updateViewForSize:(CGSize)size {
    CGFloat height = (CGFloat)size.height, width = (CGFloat)size.width;
    _cellSize = CGSizeMake(height * 0.5f, height * 0.8f);

    CGFloat distance = (CGFloat) (width - _cellSize.width / 2) / 2;
    [(UICollectionViewFlowLayout *) _collectionView.collectionViewLayout setSectionInset:UIEdgeInsetsMake(0, distance, 0, distance)];

    [self layoutVisibleCells];
}

- (void)settleOnCell {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_targetCellIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
