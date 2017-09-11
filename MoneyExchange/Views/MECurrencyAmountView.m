#import "MECurrencyAmountView.h"

static NSDictionary *AttributesForNormalText() {
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
    
    [self.delegate currencyAmountView:self
                 didChangeAmountValue:[textField.text doubleValue]];
    return YES;
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
    amountTextField.textAlignment = NSTextAlignmentRight;
    amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    amountTextField.delegate = self;

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
