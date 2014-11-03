//
//  ViewController.m
//  fairy
//
//  Created by apple on 14/11/1.
//  Copyright (c) 2014年 onecat. All rights reserved.
//

#import "ViewController.h"
#import "BaseTextField.h"
#import "NSString+MD5.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BaseTextField *phoneNumTxtField;
@property (weak, nonatomic) IBOutlet BaseTextField *passwordTxtField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupView];
}

-(void)setupView
{
    _phoneNumTxtField.backgroundColor = [UIColor clearColor];
    _phoneNumTxtField.isLeftViewPadding = YES;
    [_phoneNumTxtField setLeftBounds:CGRectMake(16, 9, 18, 18)];
    [_phoneNumTxtField setPadding:YES top:5 right:16 bottom:5 left:42];
    _phoneNumTxtField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account"]];
    _phoneNumTxtField.leftViewMode = UITextFieldViewModeAlways;
    [_phoneNumTxtField setValue:COLOR_PLACE_HOLDER
                     forKeyPath:@"_placeholderLabel.textColor"];
    
    _passwordTxtField.backgroundColor = [UIColor clearColor];
    _passwordTxtField.isLeftViewPadding = YES;
    [_passwordTxtField setLeftBounds:CGRectMake(16, 9, 18, 18)];
    [_passwordTxtField setPadding:YES top:5 right:16 bottom:5 left:42];
    _passwordTxtField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    _passwordTxtField.leftViewMode = UITextFieldViewModeAlways;
    [_passwordTxtField setValue:COLOR_PLACE_HOLDER
                     forKeyPath:@"_placeholderLabel.textColor"];
}

- (IBAction)loginAction:(id)sender {
    
    NSString *phoneNum = _phoneNumTxtField.text;
    NSString *password = _passwordTxtField.text;
//    { 'phoneNum':'ywang','password':'e10adc3949ba59abbe56e057f20f883e ','lng':'117.157954','lat':'31.873432',
//        'deviceToken':'8a2597aa1d37d432a88a446d82b6561e','osVersion':'8.0 ' , 'systemType':'iOS','phoneModel':'iPhone 5s'}
    
    float osVersion = TTOSVersion();
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:phoneNum forKey:@"phoneNum"];
    [dict setObject:[password MD5] forKey:@"password"];
    [dict setObject:[NSString stringWithFormat:@"%f", osVersion] forKey:@"osVersion"];
    [dict setObject:@"iOS" forKey:@"systemType"];
    [dict setObject:TTDeviceModelName() forKey:@"phoneModel"];
    [dict setObject:@"" forKey:@"lat"];
    [dict setObject:@"" forKey:@"lng"];
    
    [dict setObject:@"8a2597aa1d37d432a88a446d82b6561e" forKey:@"deviceToken"];
    [dict setObject:@"iOS" forKey:@"systemType"];
    
    NSString *jsonParam = [dict jsonStringWithPrettyPrint:NO];
    NSLog(@"jsonParam %@", jsonParam);
    NSString *url = [NSString stringWithFormat:@"%@%@", HOST, API_AUTHPATH];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:@{@"msg":[NSString stringWithFormat:@"A01%@", jsonParam]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject)
        {
            NSError *error;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            NSString *retCode = dic[@"ret"];
            if(retCode.integerValue == 0)
            {
                //成功登录
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
