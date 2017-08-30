//
//  MECurrencyCarouselViewController.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/30/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import "MECurrencyCarouselViewController.h"

@interface MECurrencyCarouselViewController ()

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation MECurrencyCarouselViewController

#pragma mark - Initialization

- (instancetype)initWithItems:(NSArray<MECurrencyCarouselItem *> *)items {
    self = [super initWithNibName:nil bundle:nil];
    
    return self;
}

#pragma mark - Public methods

- (void)setItem:(MECurrencyCarouselItem *)item forIndex:(int)index {
    
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
