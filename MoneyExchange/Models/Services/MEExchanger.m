#import "MEExchanger.h"

@interface MEExchanger ()

@property(nonatomic, strong) NSDictionary<NSString *, NSNumber *> *ratesMap;

@end

@implementation MEExchanger

# pragma mark - Public methods

- (NSError *)updateRatesMap:(NSDictionary<NSString *, NSNumber *> *)ratesMap {
    NSError *error = [self validateRatesMap:ratesMap];
    
    if (!error) {
        self.ratesMap = ratesMap;
    }
    
    return error;
}

- (MEExchangeOperation *)exchange:(MEExchangeInput *)exchangeInput {
    
    NSString *currencyFrom = exchangeInput.currencyFrom;
    NSString *currencyTo = exchangeInput.currencyTo;
    NSNumber *currencySumFrom = exchangeInput.amountFrom;
    NSNumber *currencySumTo = exchangeInput.amountTo;
    
    if ((exchangeInput.amountFrom && exchangeInput.amountTo) ||
        (!exchangeInput.amountFrom && !exchangeInput.amountTo)) {
        return nil;
    }
    
    MEExchangeOperation *resultOperation = nil;
    
    double rateCurrencyFrom = self.ratesMap[exchangeInput.currencyFrom].doubleValue;
    double rateCurrencyTo = self.ratesMap[exchangeInput.currencyTo].doubleValue;
    
    MEAccountOperation *fromAccountOperation = nil;
    MEAccountOperation *toAccountOperation = nil;
    
    if (exchangeInput.amountFrom) {
        double resultCurrencySumTo = (currencySumFrom.doubleValue / rateCurrencyFrom) * rateCurrencyTo;
        fromAccountOperation =
            [[MEAccountOperation alloc] initWithCurrency:currencyFrom
                                                  amount: -1 * currencySumFrom.doubleValue];
        toAccountOperation =
            [[MEAccountOperation alloc] initWithCurrency:currencyTo
                                                  amount:resultCurrencySumTo];
    }
    else {
        double resultCurrencySumFrom = (currencySumFrom.doubleValue / rateCurrencyTo) * rateCurrencyFrom;
        fromAccountOperation =
        [[MEAccountOperation alloc] initWithCurrency:currencyFrom
                                              amount: -1 * resultCurrencySumFrom];
        toAccountOperation =
        [[MEAccountOperation alloc] initWithCurrency:currencyTo
                                              amount:currencySumTo.doubleValue];
    }
    
    resultOperation = [[MEExchangeOperation alloc] initWithAccountOperationFrom:fromAccountOperation
                                                                             to:toAccountOperation];
    return resultOperation;
}

- (double)rateForCurrency:(NSString *)currency {
    return ((NSNumber *)self.ratesMap[currency]).doubleValue;
}

#pragma mark - Private methods

- (NSError *)validateRatesMap:(NSDictionary *)ratesMap {
    return nil;
}

@end
