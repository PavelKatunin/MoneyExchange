#import <XCTest/XCTest.h>

#import "MEAccount.h"

@interface MEAccountTests : XCTestCase

@end

@implementation MEAccountTests

- (void)testUpdateAccount {
    MEAccount *account = [[MEAccount alloc] init];
    
    MEAccountOperation *correctOperation1 = [[MEAccountOperation alloc] initWithCurrency:@"usd" amount:-100];
    XCTAssertTrue([account performAccountOperations:@[correctOperation1]]);
    XCTAssertEqual([account accountForCurrency:@"usd"], 0);
}

- (void)testInitialAccounts {
    MEAccount *account = [[MEAccount alloc] init];
    XCTAssertEqual([account accountForCurrency:@"usd"], 100, @"Incorrect usd account");
    XCTAssertEqual([account accountForCurrency:@"eur"], 100, @"Incorrect usd account");
    XCTAssertEqual([account accountForCurrency:@"gbp"], 100, @"Incorrect usd account");
}

- (void)testInitialAccountsUpperCase {
    MEAccount *account = [[MEAccount alloc] init];
    XCTAssertEqual([account accountForCurrency:@"USD"], 100, @"Incorrect usd account");
    XCTAssertEqual([account accountForCurrency:@"EUR"], 100, @"Incorrect usd account");
    XCTAssertEqual([account accountForCurrency:@"GBP"], 100, @"Incorrect usd account");
}

- (void)testCanUpdateAccount {
    MEAccount *account = [[MEAccount alloc] init];
    
    MEAccountOperation *correctOperation1 = [[MEAccountOperation alloc] initWithCurrency:@"usd" amount:-100];
    XCTAssertTrue([account canPerformOperation:correctOperation1]);
    
    MEAccountOperation *correctOperation2 = [[MEAccountOperation alloc] initWithCurrency:@"gbp" amount:+10000000];
    XCTAssertTrue([account canPerformOperation:correctOperation2]);
    
    MEAccountOperation *incorrectOperation1 = [[MEAccountOperation alloc] initWithCurrency:@"eur" amount:-1000];
    XCTAssertFalse([account canPerformOperation:incorrectOperation1]);
    
    MEAccountOperation *incorrectOperation2 = [[MEAccountOperation alloc] initWithCurrency:@"dasdasdasd" amount:-1000];
    XCTAssertFalse([account canPerformOperation:incorrectOperation2]);
}

@end
