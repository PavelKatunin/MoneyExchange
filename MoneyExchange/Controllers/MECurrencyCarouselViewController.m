#import "MECurrencyCarouselViewController.h"
#import "MECurrencyAmountView.h"
#import "NSLayoutConstraint+Helpers.h"
#import <iCarousel/iCarousel.h>

static NSString *const kCurrencyAmounntCellId = @"CurrencyAmounntCellId";

@interface MECurrencyCarouselViewController () <iCarouselDataSource, iCarouselDelegate, MECurrencyAmountViewDelegate>

@property(nonatomic, weak) iCarousel *carouselView;
@property(nonatomic, strong) NSMutableArray<MECurrencyDisplayItem *> *items;
@property(nonatomic, strong) NSMutableArray<MECurrencyAmountView *> *itemViews;

@property(nonatomic, weak) UIPageControl *pageControl;

@end

@implementation MECurrencyCarouselViewController

#pragma mark - Properties

- (NSString *)currentCurrency {
    return ((MECurrencyAmountView *)self.carouselView.currentItemView).currencyLabel.text;
}

#pragma mark - Initialization

- (instancetype)initWithItems:(NSArray<MECurrencyDisplayItem *> *)items {
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        self.items = [items mutableCopy];
        self.itemViews = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - Public methods

- (void)setItem:(MECurrencyDisplayItem *)item forIndex:(int)index {
    self.items[index] = item;
    [self.carouselView reloadItemAtIndex:index animated:NO];
}

- (void)setAmount:(double)amount forCurrency:(NSString *)currency {
    [self.items enumerateObjectsUsingBlock:^(MECurrencyDisplayItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([item.currency.lowercaseString isEqualToString:currency.lowercaseString]) {
            item.amount = [NSString stringWithFormat:@"%.f", amount];
            [self.carouselView reloadItemAtIndex:idx animated:NO];
        }
    }];
}

#pragma mark - View life cycle

// TODO: move to loadView
- (void)viewDidLoad {
    [super viewDidLoad];
    
    iCarousel *carousel = [self createCarouselView];
    self.carouselView = carousel;
    [self.view addSubview:carousel];
    
    UIPageControl *pageControl = [self createPageControl];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    [self.view addConstraints:[self createConstraints]];
}

- (BOOL)becomeFirstResponder {
    return [self.carouselView.currentItemView becomeFirstResponder];
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel
  viewForItemAtIndex:(NSInteger)index
         reusingView:(nullable UIView *)view {
    
    MECurrencyAmountView *resultView = nil;
    
    if (view) {
        MECurrencyAmountView *curerncyView = (MECurrencyAmountView *)view;
        curerncyView.displayItem = self.items[index];
        resultView = curerncyView;
    }
    else {
        resultView = [self currencyAmountViewFromItem:self.items[index]];
    }
    
    resultView.delegate = self;
    [resultView becomeFirstResponder];
    return resultView;
}

#pragma mark - iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return self.view.frame.size.width;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    [carousel.currentItemView becomeFirstResponder];
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    [carousel.currentItemView becomeFirstResponder];
    self.pageControl.currentPage = carousel.currentItemIndex;
}

#pragma mark - MECurrencyAmountViewDelegate

- (void)currencyAmountView:(MECurrencyAmountView *)view didChangeAmountValue:(double)amount {
    [self.delegate carouselViewController:self
                          didChangeAmount:amount
                              forCurrency:view.currencyLabel.text];
}

#pragma mark - Private methods

- (MECurrencyAmountView *)currencyAmountViewFromItem:(MECurrencyDisplayItem *)item {
    MECurrencyAmountView *view = [[MECurrencyAmountView alloc] initWithFrame:CGRectMake(0,
                                                                                        0,
                                                                                        self.view.frame.size.width,
                                                                                        self.view.frame.size.height)];
    
    view.displayItem = item;
    return view;
}

- (iCarousel *)createCarouselView {
    iCarousel *carousel = [[iCarousel alloc] init];
    carousel.type = iCarouselTypeLinear;
    carousel.translatesAutoresizingMaskIntoConstraints = NO;
    carousel.dataSource = self;
    carousel.delegate = self;
    return carousel;
}

- (UIPageControl *)createPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    pageControl.numberOfPages = [self.items count];
    return pageControl;
}

- (NSArray *)createConstraints {
    NSMutableArray *resultConstraints = [[NSMutableArray alloc] init];
    
    [resultConstraints addObjectsFromArray:[NSLayoutConstraint constraintsForWrappedSubview:self.carouselView
                                                                                 withInsets:UIEdgeInsetsZero]];
    
    [resultConstraints addObjectsFromArray:[NSLayoutConstraint horizontalConstraintsForWrappedSubview:self.pageControl
                                                                                           withInsets:UIEdgeInsetsZero]];
    
    [resultConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl]-|"
                                                                                     views:NSDictionaryOfVariableBindings(_pageControl)]];
    
    return resultConstraints;
}

@end
