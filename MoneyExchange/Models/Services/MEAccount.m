//
//  MEAccount.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import "MEAccount.h"

@interface MEAccount ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *accounts;

@end

@implementation MEAccount

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *accountInitialValuesPath = [[NSBundle mainBundle] pathForResource:@"InitialAccounts" ofType:@"plist"];
        self.accounts = [[NSDictionary dictionaryWithContentsOfFile:accountInitialValuesPath] mutableCopy];
    }
    return self;
}

#pragma mark - Public methods

- (double)accountForCurrency:(NSString *)currencyCode {
    return self.accounts[[currencyCode lowercaseString]].doubleValue;
}

- (BOOL)performAccountOperations:(NSArray<MEAccountOperation *> *)operations {
    __block BOOL canPerform = YES;
    
    [operations enumerateObjectsUsingBlock:^(MEAccountOperation * _Nonnull operation,
                                             NSUInteger idx,
                                             BOOL * _Nonnull stop) {
        canPerform = canPerform && [self canPerformOperation:operation];
        *stop = !canPerform;
    }];
    
    if (canPerform) {
        [operations enumerateObjectsUsingBlock:^(MEAccountOperation * _Nonnull operation,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop) {
            self.accounts[operation.currency] = @(self.accounts[operation.currency].doubleValue + operation.amount);
        }];
    }
    
    return canPerform;
}

- (BOOL)canPerformOperation:(MEAccountOperation *)operation {
    double currentAmount = self.accounts[operation.currency].doubleValue;
    
    return (currentAmount + operation.amount) >= 0 &&
           (currentAmount + operation.amount) <= [NSDecimalNumber maximumDecimalNumber].doubleValue;
}

@end
