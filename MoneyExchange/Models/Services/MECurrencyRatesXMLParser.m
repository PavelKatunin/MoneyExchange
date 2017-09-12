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
        formatter.numberStyle = NSNumberFormatterCurrencyStyle;
        
        NSString *numberString = currencyRate[@"_rate"];
        
        NSNumber *number = [formatter numberFromString:numberString];
        
        if (!number) {
            number = @([numberString doubleValue]);
        }
        
        NSString *currentCurrency = currencyRate[@"_currency"];
        resultDict[currentCurrency] = number;
    }];
    
    // TODO: choose place for edding eur rate
    // set eur
    resultDict[@"eur"] = @(1);
    
    return resultDict;
}

@end
