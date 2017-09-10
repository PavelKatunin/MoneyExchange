#import <Foundation/Foundation.h>

/*
 Exactly one amount must be != nil.
 Both currency code fields must be != nil.
 */

@interface MEExchangeInput : NSObject

@property(copy) NSString *currencyFrom;
@property(assign) NSNumber *amountFrom;

@property(copy) NSString *currencyTo;
@property(assign) NSNumber *amountTo;

@end
