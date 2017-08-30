//
//  CurrencyAmountView.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/26/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MECurrencyAmountView : UIView

@property(nonatomic, weak, readonly) UILabel *currencyLabel;
@property(nonatomic, weak, readonly) UITextField *amountTextField;
@property(nonatomic, weak, readonly) UILabel *accountLabel;
@property(nonatomic, weak, readonly) UILabel *rateLabel;

@end
