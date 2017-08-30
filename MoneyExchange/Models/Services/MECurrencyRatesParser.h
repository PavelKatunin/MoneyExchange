//
//  MECurrencyRatesParser.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MECurrencyRatesParser <NSObject>

- (NSDictionary *)currencyRatesFromData:(NSData *)data;

@end
