//
//  MEExchanegeInput.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Exactly one amount must be != nil.
 Both currency code fields must be != nil.
 */

@interface MEExchangeInput : NSObject

@property(copy) NSString *currencyFrom;
@property(assign) NSNumber *amountFrom;

@property(copy) NSString *currencyTo;
@property(assign) NSNumber *amountTo;

@end
