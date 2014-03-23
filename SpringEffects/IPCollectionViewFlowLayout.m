//
//  IPCollectionViewFlowLayout.m
//  SpringEffects
//
//  Created by Dheeraj Goswami on 6/22/13.
//  Copyright (c) 2013 iOSPages. All rights reserved.
//

#import "IPCollectionViewFlowLayout.h"

@interface IPCollectionViewFlowLayout()

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@end

@implementation IPCollectionViewFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    if (!self.dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
            spring.length = 0;
            spring.damping = 0.5;
            spring.frequency = 0.8;
            [self.dynamicAnimator addBehavior:spring];
        }
    }
}

- (void)refreshAnimator
{
    _dynamicAnimator = nil;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.dynamicAnimator itemsInRect:rect];
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrolleView = self.collectionView;
    CGFloat delta = newBounds.origin.x - scrolleView.bounds.origin.x;
    
    CGPoint touchLocation = [scrolleView.panGestureRecognizer locationInView:scrolleView];
    
    for (UIAttachmentBehavior *spring in self.dynamicAnimator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabsf(touchLocation.x - anchorPoint.x);
        
        CGFloat scrollResistance = distanceFromTouch / 500;
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.x += (delta < 0) ? MAX(delta, delta * scrollResistance) : MIN(delta, delta * scrollResistance);
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }
    
    return YES;
}

@end
