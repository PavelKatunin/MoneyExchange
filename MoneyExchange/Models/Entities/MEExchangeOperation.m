#import "MEExchangeOperation.h"

@interface MEExchangeOperation ()

@property(strong) MEAccountOperation *fromAcountOperation;
@property(strong) MEAccountOperation *toAcountOperation;

@end

@implementation MEExchangeOperation

#pragma mark - Initialization

- (instancetype)initWithAccountOperationFrom:(MEAccountOperation *)from
                                          to:(MEAccountOperation *)to {
    self = [super init];
    if (self) {
        self.fromAcountOperation = from;
        self.toAcountOperation = to;
    }
    return self;
}


@end
