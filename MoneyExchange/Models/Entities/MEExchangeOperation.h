//
//  MEExchangeOperation.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEAccountOperation.h"

@interface MEExchangeOperation : NSObject

@property(strong, readonly) MEAccountOperation *fromAcountOperation;
@property(strong, readonly) MEAccountOperation *toAcountOperation;

@property(readonly) NSArray<MEAccountOperation *> *accountOperations;

- (instancetype)initWithAccountOperationFrom:(MEAccountOperation *)from
                                          to:(MEAccountOperation *)to;

@end
