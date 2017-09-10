#import "MEAccountOperation.h"

@interface MEAccountOperation ()

@property(copy) NSString *currency;
@property(assign) double amount;

@end

@implementation MEAccountOperation

#pragma mark - Initialization

- (instancetype)initWithCurrency:(NSString *)currency
                          amount:(double)amount {
    self = [super init];
    if (self) {
        self.currency = [currency lowercaseString];
        self.amount = amount;
    }
    return self;
}

@end
