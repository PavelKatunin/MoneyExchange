//
//  MEExchangeInteractor.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/29/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEExchangeOperation.h"
#import "MEExchangeInput.h"

@interface MEExchangeInteractor : NSObject

- (BOOL)exchange:(MEExchangeInput *)exchangeInput;
- (BOOL)canExchange:(MEExchangeInput *)exchangeInput;

@end
