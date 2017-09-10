#import <Foundation/Foundation.h>
#import "MEAccountOperation.h"

@interface MEAccount : NSObject

- (double)accountForCurrency:(NSString *)currency;

- (BOOL)performAccountOperations:(NSArray<MEAccountOperation *> *)operations;

- (BOOL)canPerformOperation:(MEAccountOperation *)operation;

@end
