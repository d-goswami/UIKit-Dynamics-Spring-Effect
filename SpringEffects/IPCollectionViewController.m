//
//  IPCollectionViewController.m
//  SpringEffects
//
//  Created by Dheeraj Goswami on 6/22/13.
//  Copyright (c) 2013 iOSPages. All rights reserved.
//

#import "IPCollectionViewController.h"

@interface IPCollectionViewController ()

@end

@implementation IPCollectionViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CID" forIndexPath:indexPath];
    
    CGFloat r = (CGFloat)(arc4random()/RAND_MAX);
    CGFloat g = (CGFloat)(arc4random()/RAND_MAX);
    CGFloat b = (CGFloat)(arc4random()/RAND_MAX);
    cell.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    return cell;
}


@end
