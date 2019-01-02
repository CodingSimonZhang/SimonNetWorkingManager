//
//  SimonNetWorkingHelp.m
//  SimonNetWrokingHelp
//
//  Created by 大智云校 on 2018/12/29.
//  Copyright © 2018 SimonNetWrokingHelp. All rights reserved.
//

#import "SimonNetWorkingHelp.h"
#import "JSONModel.h"
@implementation SimonNetWorkingHelp
+ (void)NetRequestPostParameters:(id)requestParatmeters
                       urlString:(NSString *)urlString
              ResponseParameters:(id)responseParameters 
                        CallBack:(void(^)(BOOL netWorkingSuccess,NSString *errorString))callBack{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"application/x-www-form-urlencoded", @"image/*", nil];
    
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self urlStringUTF8Encoding:urlString];
    __block id response = responseParameters;
    [manager POST:URLString parameters:[requestParatmeters toDictionary] progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //网络获取数据成功
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        response = [response initWithString:jsonStr error : nil];//拿到数据处理jsonModel
        if (callBack) {
            callBack(YES,@"成功");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callBack) {
            callBack(NO,@"当前服务器开了点小岔");
        }
    }];
    
}
#pragma mark - url 中文格式化
+ (NSString *)urlStringUTF8Encoding:(NSString *)urlString{
    /*! ios9适配的话 打开第一个 */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0){
        return [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }
    else{
        return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}
@end
