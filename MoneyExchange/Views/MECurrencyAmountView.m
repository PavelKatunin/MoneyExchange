#import "MECurrencyAmountView.h"

static const NSInteger kMaxAmountLength = 10;

static NSDictionary *AttributesForAmountField() {
    return @{NSForegroundColorAttributeName : [UIColor whiteColor],
             NSFontAttributeName : [UIFont systemFontOfSize:40.f]};
}

@interface MECurrencyAmountView () <UITextFieldDelegate>

@property(nonatomic, weak) UILabel *currencyLabel;
@property(nonatomic, weak) UITextField *amountTextField;
@property(nonatomic, weak) UILabel *accountLabel;
@property(nonatomic, weak) UILabel *rateLabel;

@end

@implementation MECurrencyAmountView

#pragma mark - Properties

- (void)setDisplayItem:(MECurrencyDisplayItem *)displayItem {
    _displayItem = displayItem;
    if (displayItem.currency) {
        self.currencyLabel.attributedText = [[NSAttributedString alloc] initWithString:displayItem.currency
                                                                            attributes:AttributesForAmountField()];
    }

    self.amountTextField.text = displayItem.amount;

    if (displayItem.account) {
        self.accountLabel.attributedText = [[NSAttributedString alloc] initWithString:displayItem.account
                                                                           attributes:AttributesForAmountField()];
    }
    
    if (displayItem.rate) {
        self.rateLabel.attributedText = [[NSAttributedString alloc] initWithString:displayItem.rate
                                                                        attributes:AttributesForAmountField()];
    }
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createSubviews];
        [self addConstraints:[self createConstraintsForSubviews]];
    }
    
    return self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    NSMutableString *newAmountString = [textField.text mutableCopy];
    [newAmountString replaceCharactersInRange:range withString:string];
    
    [self.delegate currencyAmountView:self
                 didChangeAmountValue:[newAmountString doubleValue]];
    
    return textField.text.length + string.length < kMaxAmountLength;
}

#pragma mark - Private methods

- (BOOL)becomeFirstResponder {
    return [self.amountTextField becomeFirstResponder];
}

- (void)createSubviews {
    UILabel *currencyLabel = [[UILabel alloc] init];
    currencyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:currencyLabel];
    self.currencyLabel = currencyLabel;
    [currencyLabel setContentHuggingPriority:UILayoutPriorityRequired
                                     forAxis:UILayoutConstraintAxisHorizontal];
    
    UITextField *amountTextField = [[UITextField alloc] init];
    amountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    amountTextField.delegate = self;
    amountTextField.defaultTextAttributes = AttributesForAmountField();
    amountTextField.textAlignment = NSTextAlignmentRight;

    [self addSubview:amountTextField];
    self.amountTextField = amountTextField;
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:accountLabel];
    self.accountLabel = accountLabel;
    
    UILabel *rateLabel = [[UILabel alloc] init];
    rateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:rateLabel];
    self.rateLabel = rateLabel;
}

- (NSArray *)createConstraintsForSubviews {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    NSDictionary *topViewsBindings = NSDictionaryOfVariableBindings(_currencyLabel, _amountTextField);
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"|-(20)-[_currencyLabel]-(0)-[_amountTextField]-(20)-|"
                                                options:0
                                                metrics:nil
                                                  views:topViewsBindings];
    [constraints addObjectsFromArray:horizontalConstraints];
    
    NSLayoutConstraint *topYConstraint =
        [NSLayoutConstraint constraintWithItem:_currencyLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:_amountTextField
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
    
    [constraints addObject:topYConstraint];
    
    NSLayoutConstraint *accountLeadingSpace =
        [NSLayoutConstraint constraintWithItem:_currencyLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:_accountLabel
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0];
    
    [constraints addObject:accountLeadingSpace];
    
    NSLayoutConstraint *ratesTrailingSpace =
        [NSLayoutConstraint constraintWithItem:_amountTextField
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:_rateLabel
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0];
    
    [constraints addObject:ratesTrailingSpace];
    
    NSArray *ratesTopOffsetConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_currencyLabel]-(>=10)-[_rateLabel]-(40)-|"
                                                options:0
                                                metrics:nil
                                                  views:NSDictionaryOfVariableBindings(_rateLabel, _currencyLabel)];
    
    [constraints addObjectsFromArray:ratesTopOffsetConstraints];
    
    NSLayoutConstraint *bottomYConstraint =
        [NSLayoutConstraint constraintWithItem:_rateLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:_accountLabel
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
    
    [constraints addObject:bottomYConstraint];

    
    return constraints;
}

@end
