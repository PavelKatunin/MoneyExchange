#import <Foundation/Foundation.h>

@interface MEAccountOperation : NSObject

@property(readonly) NSString *currency;
@property(assign, readonly) double amount;

- (instancetype)initWithCurrency:(NSString *)currency
                          amount:(double)amount;

@end
