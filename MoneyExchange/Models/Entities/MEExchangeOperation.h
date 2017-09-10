#import <Foundation/Foundation.h>
#import "MEAccountOperation.h"

@interface MEExchangeOperation : NSObject

@property(strong, readonly) MEAccountOperation *fromAcountOperation;
@property(strong, readonly) MEAccountOperation *toAcountOperation;

@property(readonly) NSArray<MEAccountOperation *> *accountOperations;

- (instancetype)initWithAccountOperationFrom:(MEAccountOperation *)from
                                          to:(MEAccountOperation *)to;

@end
