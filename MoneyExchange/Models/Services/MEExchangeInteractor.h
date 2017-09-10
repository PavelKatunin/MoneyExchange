#import <Foundation/Foundation.h>
#import "MEExchangeOperation.h"
#import "MEExchangeInput.h"
#import "MECurrencyDisplayItem.h"

@class MEExchangeInteractor;

@protocol MEExchangeInteractorObserver <NSObject>

- (void)exchangeInteractorPrepared:(MEExchangeInteractor *)exchangeInteractor;

@end

@interface MEExchangeInteractor : NSObject

- (BOOL)exchange:(MEExchangeInput *)exchangeInput;
- (BOOL)canExchange:(MEExchangeInput *)exchangeInput;

@property(nonatomic, readonly) NSArray<MECurrencyDisplayItem *> *initialDisplayItems;

@end
