//
//  MEExchangerTests.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MEExchanger.h"

@interface MEExchangerTests : XCTestCase

@property (nonatomic, strong) MEExchanger *exchanger;

@end

@implementation MEExchangerTests

- (void)setUp {
    [super setUp];
    self.exchanger = [[MEExchanger alloc] init];
}

- (void)testCurrencyRatesUpdate {
    NSDictionary *ratesMap = @{@"usd" : @(1.1111),
                               @"eur" : @(1.2222)};
    [self.exchanger updateRatesMap:ratesMap];
    XCTAssertEqualObjects(@([self.exchanger rateForCurrency:@"usd"]),
                          @(1.1111),
                          @"Incorrect currency rate");
}

- (void)testCurrencyRatesUpdateOneRate {
    NSDictionary *ratesMap1 = @{@"usd" : @(1.1111),
                                @"eur" : @(1.2222)};
    [self.exchanger updateRatesMap:ratesMap1];

    
    NSDictionary *ratesMap2 = @{@"usd" : @(1.3000)};
    [self.exchanger updateRatesMap:ratesMap2];
    XCTAssertEqualObjects(@([self.exchanger rateForCurrency:@"usd"]),
                          @(1.3000),
                          @"Incorrect currency rate");
}

- (void)testCurrencyRatesUpdateWithIncorrectRates {
    NSDictionary *ratesMap = @{@"usd" : @(-1.3000)};
    NSError *error = [self.exchanger updateRatesMap:ratesMap];
    XCTAssertNotNil(error);
}

- (void)testExchangeSum {
    NSDictionary *ratesMap = @{@"usd" : @(1.22),
                               @"eur" : @(1)};
    [self.exchanger updateRatesMap:ratesMap];
    
    MEExchangeInput *exchangeInput = [[MEExchangeInput alloc] init];
    exchangeInput.amountFrom = @(100);
    exchangeInput.currencyFrom = @"eur";
    exchangeInput.currencyTo = @"usd";
    
    MEExchangeOperation *operation = [self.exchanger exchange:exchangeInput];
    XCTAssertEqual(operation.toAcountOperation.amount,
                   122,
                   @"Incorrect sum of usd");
}

@end
