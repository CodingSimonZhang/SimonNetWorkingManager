//
//  SimonNetWorkingHelp.h
//  SimonNetWrokingHelp
//
//  Created by 大智云校 on 2018/12/29.
//  Copyright © 2018 SimonNetWrokingHelp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface SimonNetWorkingHelp : NSObject
+ (void)NetRequestPostParameters:(id)requestParatmeters
                       urlString:(NSString *)urlString
              ResponseParameters:(id)responseParameters
                        CallBack:(void(^)(BOOL netWorkingSuccess,NSString *errorString))callBack;
@end

