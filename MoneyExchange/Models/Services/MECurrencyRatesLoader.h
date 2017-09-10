#import <Foundation/Foundation.h>
#import "MECurrencyRatesParser.h"

@interface MECurrencyRatesLoader : NSObject

- (instancetype)initWithURLString:(NSString *)urlString
                           parser:(id <MECurrencyRatesParser>)parser;

- (void)loadRatesSuccess:(void (^)(NSDictionary *rates))success
                    fail:(void (^)(NSError *error))fail
             targetQueue:(dispatch_queue_t)queue;

@end
