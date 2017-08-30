//
//  CurrencyAmountView.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/26/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import "MECurrencyAmountView.h"

@interface MECurrencyAmountView ()

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
        
    }
    
    return self;
}

#pragma mark - Private methods

- (void)createSubviews {
    UILabel *currencyLabel = [[UILabel alloc] init];
    currencyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:currencyLabel];
    self.currencyLabel = currencyLabel;
    
    UITextField *amountTextField = [[UITextField alloc] init];
    amountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:amountTextField];
    self.amountTextField = amountTextField;
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:accountLabel];
    self.accountLabel = accountLabel;
    
    UILabel *rateLabel = [[UILabel alloc] init];
    rateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:rateLabel];
    self.accountLabel = rateLabel;
}

- (NSArray *)createConstraintsForSubviews {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    NSDictionary *topViewsBindings = NSDictionaryOfVariableBindings(_currencyLabel, _amountTextField);
    
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"|-(20)-[_currencyLabel]-(>0)-[_amountTextField]-(20)-|"
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
    
    NSArray *topOffsetConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_currencyLabel]"
                                                options:0
                                                metrics:nil
                                                  views:topViewsBindings];
    
    [constraints addObjectsFromArray:topOffsetConstraints];
    
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
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_currencyLabel]-(10)-[_rateLabel]"
                                                options:0
                                                metrics:nil
                                                  views:NSDictionaryOfVariableBindings(_rateLabel, _currencyLabel)];
    
    [constraints addObjectsFromArray:ratesTopOffsetConstraints];
    
    return constraints;
}

@end
