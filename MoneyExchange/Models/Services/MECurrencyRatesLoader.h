//
//  MECurrencyRatesLoader.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MECurrencyRatesParser.h"

@interface MECurrencyRatesLoader : NSObject

- (instancetype)initWithURLString:(NSString *)urlString
                           parser:(id <MECurrencyRatesParser>)parser;

- (void)loadRatesSuccess:(void (^)(NSDictionary *rates))success
                    fail:(void (^)(NSError *error))fail;

@end
