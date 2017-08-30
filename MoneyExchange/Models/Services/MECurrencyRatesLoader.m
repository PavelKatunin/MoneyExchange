//
//  MECurrencyRatesLoader.m
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/25/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

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
                    fail:(void (^)(NSError *error))fail {

    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url
                                          completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error) {
                                              if (error) {
                                                  fail(error);
                                              }
                                              else {
                                                  success([self.parser currencyRatesFromData:data]);
                                              }
                                              
                                          }];
    [downloadTask resume];
}

@end
