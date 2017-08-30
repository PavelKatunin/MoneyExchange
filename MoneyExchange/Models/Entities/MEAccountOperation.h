//
//  MEAccountOperation.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/29/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEAccountOperation : NSObject

@property(readonly) NSString *currency;
@property(assign, readonly) double amount;

- (instancetype)initWithCurrency:(NSString *)currency
                          amount:(double)amount;

@end
