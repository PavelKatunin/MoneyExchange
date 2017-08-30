//
//  Exchanger.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEExchangeOperation.h"
#import "MEExchangeInput.h"

@interface MEExchanger : NSObject

- (NSError *)updateRatesMap:(NSDictionary<NSString *, NSNumber *> *)ratesMap;

- (MEExchangeOperation *)exchange:(MEExchangeInput *)exchangeInput;

- (double)rateForCurrency:(NSString *)currency;

@end
