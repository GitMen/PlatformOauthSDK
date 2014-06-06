//
//  OauthViewController.m
//  OauthDemo
//
//  Created by 张鼎辉 on 14-5-23.
//  Copyright (c) 2014年 ZhangDinghui. All rights reserved.
//

#import "OauthControl.h"
#import "OauthKey.h"
#import "OauthModel.h"
#import "MBProgressHUD+Show.h"
#import "ASIFormDataRequest.h"


#define kTenxunWB_OauthURL [NSString stringWithFormat:@"https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@", kTenxunWB_AppKey, kTenxunWB_RedirectUri]

#define kRenRen_baseOauthUrl [NSString stringWithFormat:@"https://graph.renren.com/oauth/authorize?client_id=%@&redirect_uri=%@&response_type=code&display=mobile&scope=read_user_feed,read_user_like_history,read_user_comment,read_user_share,publish_feed,publish_share,send_message,read_user_message,publish_comment,operate_like",kRenRen_AppKey,kRenRen_RedirectUri]

#define kkaiXin_OauthURL [NSString stringWithFormat:@"http://api.kaixin001.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@&scope=create_records&oauth_client=1&state=sihaidaoda", kKaiXin_AppKey, kKaiXin_RedirectUri]



@interface OauthControl (){
    UIWebView *_webView;
}

@end

static OauthControl *oauthController;
static OauthEnum _oauthEnum;

@implementation OauthControl


+ (OauthControl *)shareOahtuController{
    if(!oauthController){
        oauthController = [[OauthControl alloc]init];
    }
    return oauthController;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
  
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self oauthWithType:_oauthEnum];
}

- (void)loadView{
    _webView =   [[UIWebView alloc]init];
    self.view = _webView;
}


#pragma mark 开始授权
- (OauthControl *)initOauthWithType:(OauthEnum)oauthType delegate:(id<BaseOauthDelegate>)delegate{
    if(!oauthController){
        oauthController = [[OauthControl alloc]init];
    }

    _oauthEnum = oauthType;

    //设置代理 经理
    oauthController.oauthDelegate = delegate;
    //开始授权
    return oauthController;

}


#pragma mark 根据授权类型，进行授权
- (void)oauthWithType:(OauthEnum)oauthType{
    _oauthEnum = oauthType;
    switch (oauthType) {
        case kSinaOauth:
        {
            [WeiboSDK enableDebugMode:YES];
            [WeiboSDK registerApp:kSina_AppKey];
            
            WBAuthorizeRequest *request = [WBAuthorizeRequest request];
            request.redirectURI = kSina_RedirectURI;
            request.scope = @"all";
            request.userInfo = @{@"SSO_From": @"OauthControl",
                                 @"Other_Info_1": [NSNumber numberWithInt:123],
                                 @"Other_Info_2": @[@"obj1", @"obj2"],
                                 @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
            [WeiboSDK sendRequest:request];
        }
            break;
        case kTencentWbOauth:
        {
            
            _webView.delegate = self;
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kTenxunWB_OauthURL]]];
        }
            break;
        case kTencentQqOauth:
        {
            self.tenxunOauth = [[TencentOAuth alloc]initWithAppId:kTenxunQQ_AppId andDelegate:self];
            self.tenxunOauth.redirectURI = @"www.qq.com";
            NSArray *permissions = @[@"get_user_info",@"add_t"];
            [self.tenxunOauth authorize:permissions inSafari:NO];
        }
            break;
        case kKaixinOauth:
        {
            _webView.delegate = self;
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kkaiXin_OauthURL]];
            [_webView  loadRequest:request];
        }
            
            break;
        case kRenRenOauth:
        {
            _webView.delegate = self;
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kRenRen_baseOauthUrl]];
            [_webView  loadRequest:request];

        }
            break;
       
            
        default:
            break;
    }
}

#pragma mark 应用在appDelegate中网络数据的传输
- (BOOL)handleOpenUrl:(NSURL *)url{
    BOOL _isOK = NO;
    switch (_oauthEnum) {
        case kSinaOauth:
            _isOK = [WeiboSDK handleOpenURL:url delegate:self];
            break;
        case kTencentQqOauth:
            _isOK = [TencentOAuth HandleOpenURL:url];
            break;
               default:
            break;
    }
    return _isOK;
}


#pragma mark 新浪微博的代理
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *access_token = [(WBAuthorizeResponse *)response accessToken];
        NSString *uid = [(WBAuthorizeResponse *)response userID];
        NSDate *expiresIn =  [(WBAuthorizeResponse *)response expirationDate];

        if(!access_token && !uid){
            [self.oauthDelegate resultWithOauthType:kSinaOauth isOauth:NO errorMsg:@"用户取消授权"];
        }else{
            SinaOauth *sinaOauth = [[SinaOauth alloc]init];
            sinaOauth.accessToken = access_token;
            sinaOauth.uid = uid;
            sinaOauth.expiresInDate = expiresIn;
            [OauthModel shareOauthModel].sina = sinaOauth;
            
            //存档
            [OauthModel enCodeModel];
            [self.oauthDelegate resultWithOauthType:kSinaOauth isOauth:YES errorMsg:nil];
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark 新浪微博授权错误提示
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
   [self.oauthDelegate resultWithOauthType:kSinaOauth isOauth:NO errorMsg:[NSString stringWithFormat:@"%@",error]];
   [self dismissViewControllerAnimated:NO completion:nil];
}



#pragma mark webDelegate
#pragma mark webView每次发送请求都会调用这个方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //如果返回YES代表请求可以加载，否则不允许 加载
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSURL *backURL = request.URL;
    NSString *backURLString = backURL.absoluteString;
    
    switch (_oauthEnum) {
        case kTencentWbOauth:
            return [self oauthTencentWBWithBackString:backURLString];
            break;
       
        case kKaixinOauth:
            return [self oauthKaixinWithBackString:backURLString];
            break;
        case kRenRenOauth:
            return [self oauthRenRenBackString:backURLString];
            break;
        default:
            break;
    }
    
    
    return YES;
}

#pragma mark 腾讯微博授权
- (BOOL)oauthTencentWBWithBackString:(NSString *)backURLString{
    //判断是否是授权调用返回的URL
    if([backURLString hasPrefix:kTenxunWB_RedirectUri]){
        
        //获取code /?分割
        backURLString  = [backURLString componentsSeparatedByString:@"/?"][1];
        NSArray *array = [backURLString componentsSeparatedByString:@"&"];
        
        NSString *code = @"";
        NSString *openid = @"";
        NSString *openkey = @"";
        for(NSString *str in array){
            NSArray *resultArray = [str componentsSeparatedByString:@"="];
            if([resultArray[0] isEqualToString:@"code"])code = resultArray[1];
            if([resultArray[0] isEqualToString:@"openid"])openid = resultArray[1];
            if([resultArray[0] isEqualToString:@"openkey"])openkey = resultArray[1];
        }
        
        NSMutableString *muString = [[NSMutableString alloc]initWithFormat:@"https://open.t.qq.com/cgi-bin/oauth2/access_token?client_id=%@&client_secret=%@&redirect_uri=%@&grant_type=authorization_code&code=%@",kTenxunWB_AppKey,kTenxunWB_Secret,kTenxunWB_RedirectUri,code];
        
        //第一步创建URL
        NSURL *urlString = [NSURL URLWithString:muString];
        //第二部：创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlString cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];
        NSString *str = @"type=focus-c";//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        
        //第三部：连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
        
        //如何从str1中获取access_token
        NSArray *strArray = [str1 componentsSeparatedByString:@"&"];
        
        NSString *access_token = @"";
        NSString *expires_in = @"";
        NSString *refresh_token = @"";
        
        for(NSString *str in strArray){
            NSArray *resultArray = [str componentsSeparatedByString:@"="];
            if([resultArray[0] isEqualToString:@"access_token"])access_token = resultArray[1];
            if([resultArray[0] isEqualToString:@"expires_in"])expires_in = resultArray[1];
            if([resultArray[0] isEqualToString:@"refresh_token"])refresh_token = resultArray[1];
        }
        
        if(access_token != nil){
            TenxunWB *wb = [[TenxunWB alloc]init];
            wb.openID = openid;
            wb.openKey = openkey;
            wb.accessToken = access_token;
            wb.expiresIn = expires_in;
            wb.refreshToken = refresh_token;
            [OauthModel shareOauthModel].tencentWB = wb;
            
            //腾讯微博存档
            [OauthModel enCodeModel];
            [self.oauthDelegate resultWithOauthType:kTencentWbOauth isOauth:YES errorMsg:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}

#pragma mark 开心网授权
- (BOOL)oauthKaixinWithBackString:(NSString *)backURLString{
    //判断是否是授权调用返回的URL
    __block BOOL isOk = YES;
    if([backURLString hasPrefix:kKaiXin_RedirectUri]){
        
        //获取code /?分割
        backURLString  = [backURLString componentsSeparatedByString:@"/?"][1];
        NSArray *array = [backURLString componentsSeparatedByString:@"="];
        
        NSString *code = [array[1] componentsSeparatedByString:@"&"][0];
 
        
        __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://api.kaixin001.com/oauth2/access_token"]];
        [requestData setPostValue:@"authorization_code" forKey:@"grant_type"];
        [requestData setPostValue:code forKey:@"code"];
        [requestData setPostValue:kKaiXin_AppKey forKey:@"client_id"];
        [requestData setPostValue:kKaiXin_Secret forKey:@"client_secret"];
        [requestData setPostValue:kKaiXin_RedirectUri forKey:@"redirect_uri"];
        
        [requestData startAsynchronous];
        [requestData setCompletionBlock:^{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableLeaves error:nil];
            NSString *access_token = dict[@"access_token"];
            Kaixin *kaixin = [[Kaixin alloc]init];
            kaixin.accessToken = access_token;
            kaixin.refreshToken = dict[@"refresh_token"];
            kaixin.expiresIn = dict[@"expires_in"];
            [OauthModel shareOauthModel].kaixin = kaixin;
            [OauthModel enCodeModel];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.oauthDelegate resultWithOauthType:kKaixinOauth isOauth:YES errorMsg:nil];
            isOk = NO;
        }];
        return isOk;
    }
    return isOk;
}

#pragma mark  人人授权
- (BOOL)oauthRenRenBackString:(NSString *)backURLString{
    //判断是否是授权调用返回的URL
    __block BOOL isOk = YES;
    if([backURLString hasPrefix:kRenRen_RedirectUri]){
        
        //获取code /?分割
        backURLString  = [backURLString componentsSeparatedByString:@"?"][1];
        NSArray *array = [backURLString componentsSeparatedByString:@"="];
        
        NSString *code = array[1];
        
        __weak ASIFormDataRequest *requestData = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://graph.renren.com/oauth/token"]];
        [requestData setPostValue:@"authorization_code" forKey:@"grant_type"];
        [requestData setPostValue:code forKey:@"code"];
        [requestData setPostValue:kRenRen_AppKey forKey:@"client_id"];
        [requestData setPostValue:kRenRen_AppSecrect forKey:@"client_secret"];
        [requestData setPostValue:kRenRen_RedirectUri forKey:@"redirect_uri"];
        
        [requestData startAsynchronous];
        [requestData setCompletionBlock:^{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[requestData responseData] options:NSJSONReadingMutableLeaves error:nil];
            RenRen *renren = [[RenRen alloc]init];
            renren.accessToken = dict[@"access_token"];
            renren.uid = dict[@"user"][@"id"];
            renren.expiresIn = dict[@"expires_in"];
            renren.refreshToken = dict[@"refresh_token"];
            [OauthModel shareOauthModel].renren = renren;
            [OauthModel enCodeModel];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.oauthDelegate resultWithOauthType:kRenRenOauth isOauth:YES errorMsg:nil];
            isOk = NO;
        }];
        return isOk;
    }
    
    return isOk;

}

#pragma mark webView代理
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (_oauthEnum) {
        case kTencentWbOauth:
            [self.oauthDelegate resultWithOauthType:kTencentWbOauth isOauth:NO errorMsg:@"网络连接失败"];
            break;
        case kKaixinOauth:
            [self.oauthDelegate resultWithOauthType:kKaixinOauth isOauth:NO errorMsg:@"网络连接失败"];
            break;
        default:
            break;
    }
}

#pragma mark -QQ授权代理
#pragma mark 网络错误导致登录失败
- (void)tencentDidNotNetWork
{
    [self dismissViewControllerAnimated:NO completion:nil];
	[self.oauthDelegate resultWithOauthType:kTencentQqOauth isOauth:NO errorMsg:@"网络连接失败"];
}

#pragma mark 登陆成功后调用
- (void)tencentDidLogin{
    if (_tenxunOauth.accessToken && 0 != [_tenxunOauth.accessToken length]){
        NSLog(@"qq_accessToken:%@",_tenxunOauth.accessToken);
        NSLog(@"qq_uid:%@",_tenxunOauth.openId);
        NSLog(@"qq_accessToken的失效期:%@",_tenxunOauth.expirationDate);
        TenxunQQ *qq = [[TenxunQQ alloc]init];
        qq.uid = _tenxunOauth.openId;
        qq.accessToken = _tenxunOauth.openId;
        qq.expirationDate = _tenxunOauth.expirationDate;
        qq.isLogin = YES;
        [OauthModel shareOauthModel].tencentQQ = qq;
        [OauthModel enCodeModel];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.oauthDelegate resultWithOauthType:kTencentQqOauth isOauth:YES errorMsg:nil];
        
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.oauthDelegate resultWithOauthType:kTencentQqOauth isOauth:NO errorMsg:@"授权失败"];
    }
    
}

#pragma mark 非网络错误导致登录失败
- (void)tencentDidNotLogin:(BOOL)cancelled{
    [self dismissViewControllerAnimated:NO completion:nil];
    if (cancelled){
        [self.oauthDelegate resultWithOauthType:kTencentQqOauth isOauth:NO errorMsg:@"用户取消登陆"];
	}
	else{
        [self.oauthDelegate resultWithOauthType:kTencentQqOauth isOauth:NO errorMsg:@"授权失败"];
    }
}

#pragma mark 归档授权内容
- (void)encodeOauthResult{
    [NSKeyedArchiver archiveRootObject:[OauthModel shareOauthModel] toFile:kOauthModelFiel];
}

#pragma mark 是否安装QQ
+ (BOOL)isInstalledQQ{
    return [TencentOAuth iphoneQQInstalled];
    
}

#pragma mark 是否安装QQ空间
+ (BOOL)isInstalledQQZone{
    return [TencentOAuth iphoneQZoneInstalled];
}


#pragma mark 获取QQ用户信息
- (void)getQQUserInfo{
    [self.tenxunOauth getUserInfo];
}

- (void)getUserInfoResponse:(APIResponse *)response{
    NSLog(@"%@",response.jsonResponse);
}

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    // incrAuthWithPermissions是增量授权时需要调用的登录接口
    // permissions是需要增量授权的权限列表
    
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO; // 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}


- (void)sendStoryResponse:(APIResponse *)response{
    NSLog(@"%@",response.jsonResponse);
    if (URLREQUEST_SUCCEED == response.retCode
        && kOpenSDKErrorSuccess == response.detailRetCode)
    {
        NSMutableString *str=[NSMutableString stringWithFormat:@""];
        for (id key in response.jsonResponse) {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
            NSLog(@"%@",str);
        }
    }
}


-(void)responseDidReceived:(APIResponse *)response forMessage:(NSString *)message{
    NSLog(@"%@",message);
}

- (void)addShareResponse:(APIResponse *)response{
    NSLog(@"%@",[response errorMsg]);
}

@end

