# SimonNetWorkingManager

封装的网络请求方法


把数据模型Model穿进去，会在方法里处理model,然后callback 传出来，直接内部处理了。不需要在vc处理。

如下：

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
