#import "MEExchangeViewController.h"
#import "MEExchangeInteractor.h"
#import "MECurrencyCarouselViewController.h"
#import "NSLayoutConstraint+Helpers.h"
#import "MECurrencyAmountView.h"
#import "MEFloatingBackgroundView.h"

@interface MEExchangeViewController () <MECurrencyCarouselViewControllerDelegate>

@property(strong) MEExchangeInteractor *exchangeInteractor;

@property(nonatomic, weak) MEFloatingBackgroundView *backgroundView;

@property(nonatomic, weak) MECurrencyCarouselViewController *fromCurrencyCarousel;
@property(nonatomic, weak) MECurrencyCarouselViewController *toCurrencyCarousel;

@property(nonatomic, weak) UIView *carouselsContainer;
@property(nonatomic, weak) NSLayoutConstraint *bottomContainerConstraint;

@end

@implementation MEExchangeViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.exchangeInteractor = [[MEExchangeInteractor alloc] init];
    }
    
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubviews];
    [self.view addConstraints:[self createConstraints]];

    UIBarButtonItem *exchangeItem = [[UIBarButtonItem alloc] initWithTitle:@"Exchange"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(exchangeCurrentItems:)];
    
    // set the nav bar's right button item
    self.navigationItem.rightBarButtonItem = exchangeItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.fromCurrencyCarousel becomeFirstResponder];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait) ;
}

#pragma mark - MECurrencyCarouselViewControllerDelegate

- (void)carouselViewController:(MECurrencyCarouselViewController *)controller
               didChangeAmount:(double)amount
                   forCurrency:(NSString *)currency {
    MEExchangeInput *exchangeInput = [[MEExchangeInput alloc] init];
    
    exchangeInput.currencyFrom = [self.fromCurrencyCarousel currentCurrency];
    exchangeInput.currencyTo = [self.toCurrencyCarousel currentCurrency];
    
    if (controller == self.fromCurrencyCarousel) {
        exchangeInput.amountFrom = @(amount);
    }
    else if (controller == self.toCurrencyCarousel) {
        exchangeInput.amountTo = @(amount);
    }
    
    MEExchangeOperation *previewOperation = [self.exchangeInteractor previewExchange:exchangeInput];
    
    [self.toCurrencyCarousel setAmount:previewOperation.fromAcountOperation.amount
                           forCurrency:previewOperation.fromAcountOperation.currency];
    [self.fromCurrencyCarousel setAmount:previewOperation.toAcountOperation.amount
                             forCurrency:previewOperation.toAcountOperation.currency];
}

#pragma mark - Private methods

- (void)exchangeCurrentItems:(id)sender {
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.bottomContainerConstraint.constant = -1 * kbSize.height;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    self.bottomContainerConstraint.constant = 0;
}

- (MECurrencyCarouselViewController *)setupCarouselViewController {
    MECurrencyCarouselViewController *currencyCarousel =
        [[MECurrencyCarouselViewController alloc] initWithItems:self.exchangeInteractor.initialDisplayItems];
    
    [self addChildViewController:currencyCarousel];
    currencyCarousel.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.carouselsContainer addSubview:currencyCarousel.view];
    [currencyCarousel didMoveToParentViewController:self];
    currencyCarousel.delegate = self;
    
    return currencyCarousel;
}

- (void)createSubviews {
    MEFloatingBackgroundView *backgroundView = [[MEFloatingBackgroundView alloc] initWithBubblesCount:5];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    UIView *carouselsContainer = [[UIView alloc] init];
    carouselsContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:carouselsContainer];
    self.carouselsContainer = carouselsContainer;
    
    self.fromCurrencyCarousel = [self setupCarouselViewController];
    self.fromCurrencyCarousel.view.accessibilityIdentifier = @"FromCurrencyCarousel";
    
    self.toCurrencyCarousel = [self setupCarouselViewController];
    self.toCurrencyCarousel.view.accessibilityIdentifier = @"ToCurrencyCarousel";
}

- (NSArray *)createConstraints {
    
    NSMutableArray *resultConstraints = [[NSMutableArray alloc] init];
    
    [resultConstraints addObjectsFromArray:[NSLayoutConstraint constraintsForWrappedSubview:self.backgroundView
                                                                                 withInsets:UIEdgeInsetsZero]];
    
    [resultConstraints addObjectsFromArray:[NSLayoutConstraint horizontalConstraintsForWrappedSubview:self.carouselsContainer
                                                                                           withInsets:UIEdgeInsetsZero]];
    
    id <UILayoutSupport> topLayout = self.topLayoutGuide;
    [resultConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayout]-[_carouselsContainer]"
                                                                                     views:NSDictionaryOfVariableBindings(_carouselsContainer, topLayout)]];
    
    NSLayoutConstraint *bottomContainerConstraint = [NSLayoutConstraint constraintWithItem:self.carouselsContainer
                                                                                 attribute:NSLayoutAttributeBottom
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self.bottomLayoutGuide
                                                                                 attribute:NSLayoutAttributeTop
                                                                                multiplier:1.0
                                                                                  constant:-244];
    
    self.bottomContainerConstraint = bottomContainerConstraint;
    
    [resultConstraints addObject:bottomContainerConstraint];
    
    NSMutableArray *containerConstraints = [[NSMutableArray alloc] init];
    
    NSArray *fromHorizontalConstraints =
        [NSLayoutConstraint horizontalConstraintsForWrappedSubview:self.fromCurrencyCarousel.view
                                                        withInsets:UIEdgeInsetsZero];
    
    [containerConstraints addObjectsFromArray:fromHorizontalConstraints];
    
    NSArray *toHorizontalConstraints =
        [NSLayoutConstraint horizontalConstraintsForWrappedSubview:self.toCurrencyCarousel.view
                                                        withInsets:UIEdgeInsetsZero];
    
    [containerConstraints addObjectsFromArray:toHorizontalConstraints];
    
    UIView *fromCurrencyCarouselView = self.fromCurrencyCarousel.view;
    UIView *toCurrencyCarouselView = self.toCurrencyCarousel.view;
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[fromCurrencyCarouselView]-0-[toCurrencyCarouselView(==fromCurrencyCarouselView)]-0-|"
                                                  views:NSDictionaryOfVariableBindings(fromCurrencyCarouselView,
                                                                                       toCurrencyCarouselView)];
    
    [containerConstraints addObjectsFromArray:verticalConstraints];
    
    [self.carouselsContainer addConstraints:containerConstraints];
    
    return resultConstraints;
}

@end
