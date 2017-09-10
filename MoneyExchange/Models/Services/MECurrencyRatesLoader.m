#import "MECurrencyRatesLoader.h"

@interface MECurrencyRatesLoader ()

@property(nonatomic, strong) id <MECurrencyRatesParser> parser;
@property(nonatomic, copy) NSString *urlString;

@end

@implementation MECurrencyRatesLoader

#pragma mark - Initialization

- (instancetype)initWithURLString:(NSString *)urlString
                           parser:(id <MECurrencyRatesParser>)parser {
    self = [super init];
    if (self) {
        self.urlString = urlString;
        self.parser = parser;
    }
    return self;
}

- (instancetype)init {
    NSAssert(NO, @"Incorrect initializer used");
    return nil;
}

#pragma mark - Public methods

- (void)loadRatesSuccess:(void (^)(NSDictionary *rates))success
                    fail:(void (^)(NSError *error))fail
             targetQueue:(dispatch_queue_t)queue {

    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url
                                          completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error) {
                                              if (error) {
                                                  dispatch_async(queue, ^{
                                                      fail(error);
                                                  });
                                              }
                                              else {
                                                  dispatch_async(queue, ^{
                                                      success([self.parser currencyRatesFromData:data]);
                                                  });
                                              }
                                              
                                          }];
    [downloadTask resume];
}

@end
