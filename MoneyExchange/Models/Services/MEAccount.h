//
//  MEAccount.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEAccountOperation.h"

@interface MEAccount : NSObject

- (double)accountForCurrency:(NSString *)currency;

- (BOOL)performAccountOperations:(NSArray<MEAccountOperation *> *)operations;

- (BOOL)canPerformOperation:(MEAccountOperation *)operation;

@end
