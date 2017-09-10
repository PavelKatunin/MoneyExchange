#import "MECurrencyCarouselViewController.h"
#import "MECurrencyAmountView.h"
#import "NSLayoutConstraint+Helpers.h"
#import <iCarousel/iCarousel.h>

static NSString *const kCurrencyAmounntCellId = @"CurrencyAmounntCellId";

@interface MECurrencyCarouselViewController () <iCarouselDataSource, iCarouselDelegate>

@property(nonatomic, weak) iCarousel *carouselView;
@property(nonatomic, strong) NSMutableArray<MECurrencyDisplayItem *> *items;
@property(nonatomic, strong) NSMutableArray<MECurrencyAmountView *> *itemViews;

@end

@implementation MECurrencyCarouselViewController

#pragma mark - Initialization

- (instancetype)initWithItems:(NSArray<MECurrencyDisplayItem *> *)items {
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        self.items = [items mutableCopy];
        self.itemViews = [[NSMutableArray alloc] init];
        [self setupInitialViews];
    }
    
    return self;
}

#pragma mark - Public methods

- (void)setItem:(MECurrencyDisplayItem *)item forIndex:(int)index {
    // TODO: implement
}

#pragma mark - View life cycle

// TODO: move to loadView
- (void)viewDidLoad {
    [super viewDidLoad];
    
    iCarousel *carousel = [self createCarouselView];
    self.carouselView = carousel;
    [self.view addSubview:carousel];
    
    [self.view addConstraints:[self createConstraints]];
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
        [self setItem:self.items[index] toCurrencyView:view];
        resultView = view;
    }
    else {
        resultView = [self currencyAmountViewFromItem:self.items[index]];
    }
    
    [resultView becomeFirstResponder];
    return resultView;
}

#pragma mark - iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return self.view.frame.size.width;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    [self.itemViews[index] becomeFirstResponder];
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    [carousel.currentItemView becomeFirstResponder];
}

#pragma mark - Private methods

- (void)setupInitialViews {
    [self.items enumerateObjectsUsingBlock:^(MECurrencyDisplayItem * _Nonnull obj,
                                             NSUInteger idx,
                                             BOOL * _Nonnull stop) {
        MECurrencyAmountView *view = [self currencyAmountViewFromItem:obj];
        [self.itemViews addObject:view];
    }];
}

- (MECurrencyAmountView *)currencyAmountViewFromItem:(MECurrencyDisplayItem *)item {
    MECurrencyAmountView *view = [[MECurrencyAmountView alloc] initWithFrame:CGRectMake(0,
                                                                                        0,
                                                                                        self.view.frame.size.width,
                                                                                        self.view.frame.size.height)];
    [self setItem:item toCurrencyView:view];
    return view;
}

- (void)setItem:(MECurrencyDisplayItem *)item toCurrencyView:(MECurrencyAmountView *)currencyView {
    currencyView.currencyLabel.attributedText = item.currency;
    currencyView.amountTextField.attributedText = item.amount;
    currencyView.accountLabel.attributedText = item.account;
    currencyView.rateLabel.attributedText = item.rate;
}

- (iCarousel *)createCarouselView {
    iCarousel *carousel = [[iCarousel alloc] init];
    carousel.type = iCarouselTypeLinear;
    carousel.translatesAutoresizingMaskIntoConstraints = NO;
    carousel.dataSource = self;
    carousel.delegate = self;
    return carousel;
}

- (NSArray *)createConstraints {
    return [NSLayoutConstraint constraintsForWrappedSubview:self.carouselView
                                                 withInsets:UIEdgeInsetsZero];
}

@end
