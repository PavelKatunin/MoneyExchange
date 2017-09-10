#import <Foundation/Foundation.h>

@protocol MECurrencyRatesParser <NSObject>

- (NSDictionary *)currencyRatesFromData:(NSData *)data;

@end
