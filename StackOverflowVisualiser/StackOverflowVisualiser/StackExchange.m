//
//  StackExchange.m
//  StackOverflowVisualiser
//
//  Created by Madalina Melinte on 09/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "StackExchange.h"
#import "StackExchangeApiKey.h"

@implementation StackExchange

#define TAG @"ios"

+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@", query,StackExchangeApiKey];
    query = [query stringByAddingPercentEncodingWithAllowedCharacters:(NSCharacterSet.URLQueryAllowedCharacterSet)];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLForRelatedTags
{
    return [self URLForQuery:[NSString stringWithFormat:@"https://api.stackexchange.com/2.2/tags/%@/related?site=stackoverflow",TAG]];
}

+(NSURL *)URLForSearch: (NSString *)tag
{
    return [self URLForQuery:[NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=%@&site=stackoverflow&filter=withbody",tag]];
}

@end
