//
//  MEExchangeOperation.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

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
