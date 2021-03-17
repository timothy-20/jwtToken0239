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

@end
