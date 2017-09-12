#import <Foundation/Foundation.h>
#import "MEExchangeOperation.h"
#import "MEExchangeInput.h"
#import "MECurrencyDisplayItem.h"

typedef enum : NSUInteger {
    ExchangeAccountType_From,
    ExchangeAccountType_To,
} ExchangeAccountType;

@class MEExchangeInteractor;

@protocol MEExchangeInteractorDelegate <NSObject>

- (void)exchangeInteractorPrepared:(MEExchangeInteractor *)exchangeInteractor;

@end

@interface MEExchangeInteractor : NSObject

@property(nonatomic, weak) id <MEExchangeInteractorDelegate> delegate;

- (BOOL)exchange:(MEExchangeInput *)exchangeInput;
- (BOOL)canExchange:(MEExchangeInput *)exchangeInput;
- (MEExchangeOperation *)previewExchange:(MEExchangeInput *)exchangeInput;

@property(nonatomic, readonly) NSArray<MECurrencyDisplayItem *> *initialDisplayItems;

@end
