#import "MEExchangeInteractor.h"
#import "MEExchanger.h"
#import "MEAccount.h"
#import "MECurrencyRatesLoader.h"
#import "MECurrencyRatesXMLParser.h"
#import <UIKit/UIKit.h>

static NSString *const kEuropeanCentralBankRatesUrl =
    @"https://http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

static NSArray *CurrencyCodesForDisplay() {
    return @[@"usd", @"eur", @"gbp"];
}

static NSDictionary *AttributesForNormalText() {
    return @{NSForegroundColorAttributeName : [UIColor whiteColor],
             NSFontAttributeName : [UIFont systemFontOfSize:40.f]};
}

static NSDictionary *AttributesForErrorText() {
    return @{NSForegroundColorAttributeName : [UIColor redColor],
             NSFontAttributeName : [UIFont systemFontOfSize:40.f]};
}

@interface MEExchangeInteractor ()

@property(nonatomic, strong) MEExchanger *exchanger;
@property(nonatomic, strong) MEAccount *account;
@property(nonatomic, strong) MECurrencyRatesLoader *ratesLoader;

@property(nonatomic, strong) NSTimer *updateRatesTimer;

@end

@implementation MEExchangeInteractor

#pragma mark - Properties

- (NSArray<MECurrencyDisplayItem *> *)initialDisplayItems {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [CurrencyCodesForDisplay() enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *currency = (NSString *)obj;
        MECurrencyDisplayItem *item = [[MECurrencyDisplayItem alloc] init];
        item.currency = [[NSAttributedString alloc] initWithString:currency attributes:AttributesForNormalText()];
        NSString *account = [NSString stringWithFormat:@"%.0f", [self.account accountForCurrency:currency]];
        item.account = [[NSAttributedString alloc] initWithString:account
                                                       attributes:AttributesForNormalText()];
        [items addObject:item];
    }];
    
    return items;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.exchanger = [[MEExchanger alloc] init];

        MECurrencyRatesXMLParser *ratesParser = [[MECurrencyRatesXMLParser alloc] init];
        self.ratesLoader = [[MECurrencyRatesLoader alloc] initWithURLString:kEuropeanCentralBankRatesUrl
                                                                     parser:ratesParser];
        
        self.account = [[MEAccount alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (BOOL)exchange:(MEExchangeInput *)exchangeInput {
    MEExchangeOperation *exchangeOperation = [self.exchanger exchange:exchangeInput];
    return [self.account performAccountOperations:exchangeOperation.accountOperations];
}

- (BOOL)canExchange:(MEExchangeInput *)exchangeInput {
    return NO;
}

@end
