#import <Foundation/Foundation.h>
#import "MEExchangeOperation.h"
#import "MEExchangeInput.h"

@interface MEExchanger : NSObject

- (NSError *)updateRatesMap:(NSDictionary<NSString *, NSNumber *> *)ratesMap;

- (MEExchangeOperation *)exchange:(MEExchangeInput *)exchangeInput;

- (double)rateForCurrency:(NSString *)currency;

@end
