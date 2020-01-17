//
//  AddReceiverController.m
//  毕业
//
//  Created by 龙波 on 2017/11/12.
//  Copyright © 2017年 吴添培. All rights reserved.
//

#import "AddReceiverController.h"
#import "EditTextView.h"
#import "XFAreaPickerView.h"
#import "PersonInfo.h"
@interface AddReceiverController ()<XFAreaPickerViewDelegate>
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *iphone;
@property(nonatomic,strong) NSString *zip;
@property(nonatomic,strong) NSString *province;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *district;
@property(nonatomic,strong) NSString *address;

@end

@implementation AddReceiverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加收货地址";
    [self initUi];
    // Do any additional setup after loading the view.
}

-(void)setUpRightBtn
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finished)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

- (void)initUi{
    [self setUpRightBtn];
    CGFloat btnH = 60;

    
    _nameAddBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0, 100+btnH, SCREENWIDTH, btnH)];
    [_nameAddBtn addTarget:self action:@selector(addName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nameAddBtn];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameAddBtn.frame), SCREENWIDTH - 25, 1)];
    lineView2.backgroundColor=[UIColor grayColor];
    [self.view addSubview:lineView2];
    
    _iphoneAddBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0, 100 + btnH*2, SCREENWIDTH, btnH)];
    [_iphoneAddBtn addTarget:self action:@selector(addIphone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_iphoneAddBtn];
    
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_iphoneAddBtn.frame), SCREENWIDTH -25, 1)];
    lineView3.backgroundColor=[UIColor grayColor];
    [self.view addSubview:lineView3];
    
    _addressAddBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0, 100 + btnH*3, SCREENWIDTH, btnH)];
    [_addressAddBtn addTarget:self action:@selector(addRess) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addressAddBtn];
    
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_addressAddBtn.frame), SCREENWIDTH -25, 1)];
    lineView4.backgroundColor=[UIColor grayColor];
    [self.view addSubview:lineView4];
    
    _zipAddBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0, 100 + btnH*5, SCREENWIDTH, btnH)];
    [_zipAddBtn addTarget:self action:@selector(zipAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zipAddBtn];
    

    _areaAddBtn = [[EditBtn alloc]initWithFrame:CGRectMake(0, 100 + btnH*4, SCREENWIDTH, btnH)];
    [_areaAddBtn addTarget:self action:@selector(areaAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_areaAddBtn];
    
    UIView *lineView5=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_areaAddBtn.frame), SCREENWIDTH -25, 1)];
    lineView5.backgroundColor=[UIColor grayColor];
    [self.view addSubview:lineView5];

    [_iphoneAddBtn setUpKey:@"手机号" value:@" "];
    [_nameAddBtn setUpKey:@"收货人名字" value:@" "];
    [_addressAddBtn setUpKey:@"收货人地址" value:@" "];
    [_areaAddBtn setUpKey:@"详细地址" value:@""];
    [_zipAddBtn setUpKey:@"邮政编码" value:@""];
    
}


- (void)finished
{
    if (self.name==nil || self.district == nil || self.iphone == nil) {
        [UIAlertController creatAlertControllerTitle:@"提示" withMessage:@"请补全信息" target:self];
    
    }else if (self.zip.length != 6)
    {
        [UIAlertController creatAlertControllerTitle:@"提示" withMessage:@"请填好邮政编码" target:self];
    }else{
    
    NSDictionary *params = @{@"userId":[[PersonInfo sharePersonInfo]getLoginUserId],
                             @"receiverName":self.name,
                             @"receiverPhone":self.iphone,
                             @"receiverProvince":self.province,
                             @"receiverCity":self.city,
                             @"receiverDistrict":self.district,
                             @"receiverAddress":self.address,
                             @"receiverZip":self.zip,
                             @"receiverMobile":@""
                             };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://47.93.33.181:8080/shipping/add.do" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-----------------------%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"申请失败%@",error);
    }];

    }
}

- (void)addName
{
    [EditTextView showWithController:self andRequestDataBlock:^(NSString *text) {
        self.name = text;
        [_nameAddBtn setUpKey:@"收货人名字" value:text];
        
    }];

}



- (void)addIphone{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"添加手机号" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *iohoneTextField = alertController.textFields.firstObject;
        self.iphone = iohoneTextField.text;
        [_iphoneAddBtn setUpKey:@"手机号" value:iohoneTextField.text];
        NSLog(@"用户名 = %@，",iohoneTextField.text);
        
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"手机号";
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)addRess
{
    XFAreaPickerView *areaPicker = [[XFAreaPickerView alloc]initWithDelegate:self];
    areaPicker.isHidden = NO;

}

- (void)areaPickerView:(XFAreaPickerView *)areaPickerView didSelectProvince:(NSString *)province selectedCity:(NSString *)city selectedDistrict:(NSString *)district
{
    NSString *area = [NSString stringWithFormat:@"%@%@%@",province,city,district];
    self.province = province;
    self.city = city;
    self.district = district;
    [_addressAddBtn setUpKey:@"收货地址" value:area];
}

- (void)zipAdd{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"添加邮政编码" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *zipTextField = alertController.textFields.firstObject;
        self.zip = zipTextField.text;
        [_zipAddBtn setUpKey:@"邮政编码" value:zipTextField.text];
        
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"邮政编码";
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)areaAdd
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"添加详细地址" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *areaTextField = alertController.textFields.firstObject;
        self.address = areaTextField.text;
        [_areaAddBtn setUpKey:@"详细地址" value:areaTextField.text];
        
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"详细地址";
    }];
    
    
    [self presentViewController:alertController animated:true completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
