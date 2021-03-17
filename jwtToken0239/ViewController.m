//
//  ViewController.m
//  jwtToken0239
//
//  Created by 임정운 on 2021/03/16.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self run];
    [self run2];
}

-(NSString *)parseFromURLRequest:(NSURLRequest *)request
{
    NSArray *params = [[request.URL query]componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
    NSLog(@"%@", params);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (int i=0; i<[params count]; i+=2) {
        [dic setObject:[params objectAtIndex:1] forKey:@"fileName"];
    }
    
    return [(NSString *)[params objectAtIndex:1] stringByRemovingPercentEncoding];
}

-(void)run
{
    NSString *urlStr = [NSString stringWithFormat:@"fbconnect://success?request=requestid&to%5B0%5D=faceid1&to%5B1%5D=faceid2"];
    NSURL *url = [NSURL URLWithString:urlStr];

    NSURLRequest *reqUrl = [NSURLRequest requestWithURL:url];
    
    NSString *params = [self parseFromURLRequest:reqUrl];
    
    NSLog(@"%@", params);
    NSLog(@"done");
}

-(NSMutableArray *)jsonDic
{
    NSMutableArray *arrJSON = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 3; i++) {
        NSMutableDictionary *dicJSON = [[NSMutableDictionary alloc] init];
        dicJSON[@"name"] = @"DEAN";
        dicJSON[@"age"] = @(28+i);
        dicJSON[@"gender"] = @"male";
        
        [arrJSON addObject:dicJSON];
    }
    
    return arrJSON;
}

-(void)run2
{
    NSData *dtJSON = [NSJSONSerialization dataWithJSONObject:[self jsonDic] options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strJSON = [[NSString alloc] initWithData:dtJSON encoding:NSUTF8StringEncoding];
    NSLog(@"%@", strJSON);
    
    NSError *err = nil;
    NSArray *arrJSON = [NSJSONSerialization JSONObjectWithData:dtJSON options:kNilOptions error:&err];
//     특별한 경우를 제외하곤 kNilOptions를 사용해도 전혀 무방함.
//     - NSJSONReadingMutableContainers, - NSJSONReadingMutableLeaves, - NSJSONReadingAllowFragMents 등의 옵션이 있음.
    
    NSLog(@"array 형태로 추출");
    NSLog(@"%@", arrJSON);
    
    if(err) {
        NSLog(@"error");
    }
}

@end
