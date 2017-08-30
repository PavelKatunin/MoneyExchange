//
//  MEExchangeInteractor.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/29/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import "MEExchangeInteractor.h"
#import "MEExchanger.h"
#import "MEAccount.h"
#import "MECurrencyRatesLoader.h"
#import "MECurrencyRatesXMLParser.h"

static NSString *const kEuropeanCentralBankRatesUrl =
    @"https://http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

@interface MEExchangeInteractor ()

@property(nonatomic, strong) MEExchanger *exchanger;
@property(nonatomic, strong) MEAccount *account;
@property(nonatomic, strong) MECurrencyRatesLoader *ratesLoader;

@property(nonatomic, strong) NSTimer *updateRatesTimer;

@end

@implementation MEExchangeInteractor

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.exchanger = [[MEExchanger alloc] init];

        MECurrencyRatesXMLParser *ratesParser = [[MECurrencyRatesXMLParser alloc] init];
        self.ratesLoader = [[MECurrencyRatesLoader alloc] initWithURLString:kEuropeanCentralBankRatesUrl
                                                                     parser:ratesParser];
        
        self.account = [[MEAccount alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (BOOL)exchange:(MEExchangeInput *)exchangeInput {
    MEExchangeOperation *exchangeOperation = [self.exchanger exchange:exchangeInput];
    return [self.account performAccountOperations:exchangeOperation.accountOperations];
}

- (BOOL)canExchange:(MEExchangeInput *)exchangeInput {
    return NO;
}

@end
