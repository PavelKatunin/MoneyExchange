//
//  MECurrencyRatesXMLParser.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import "MECurrencyRatesXMLParser.h"
#import "XMLDictionary.h"

@implementation MECurrencyRatesXMLParser

#pragma mark - Public methods

- (NSDictionary *)currencyRatesFromData:(NSData *)data {
    NSDictionary *rawDict = [NSDictionary dictionaryWithXMLData:data];
    NSArray *currencyArray = [rawDict valueForKeyPath:@"Cube.Cube.Cube"];
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    [currencyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *currencyRate = (NSDictionary *)obj;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *number = [formatter numberFromString:currencyRate[@"_rate"]];
        
        resultDict[currencyRate[@"_currency"]] = number;
    }];
    
    // TODO: choose place for edding eur rate
    // set eur
    resultDict[@"eur"] = @(1);
    
    return resultDict;
}

@end
