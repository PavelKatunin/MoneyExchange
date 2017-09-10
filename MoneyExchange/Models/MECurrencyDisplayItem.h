#import <Foundation/Foundation.h>

@interface MECurrencyDisplayItem : NSObject

@property(nonatomic, copy) NSAttributedString *currency;
@property(nonatomic, copy) NSAttributedString *amount;
@property(nonatomic, copy) NSAttributedString *account;
@property(nonatomic, copy) NSAttributedString *rate;

@end
