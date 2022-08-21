#import "ViewController.h"
#import "DragView.h"
#import "metalbiew.h"


@interface ViewController ()
@property (nonatomic, strong) metalbiew *vna;


@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

static BOOL MenDeal;
static BOOL init;
static ViewController *extraInfo;


+(void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        extraInfo =  [ViewController new];
        [extraInfo tapIconView];
        [extraInfo initTapGes];
       
    });
  
}


-(void)initTapGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 3; // 点击次数
    tap.numberOfTouchesRequired = 3; // 手指数
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController.view addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapIconView)];
}




-(void)tapIconView
{
    DragView *view = [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController.view viewWithTag:100];
    if (!view) {
        view = [[DragView alloc] init];
        view.tag = 100;
        [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController.view addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onConsoleButtonTapped:)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
    }
    
    if (!MenDeal) {
        // 显示
        view.hidden = NO;
    } else {
        // 隐藏
        view.hidden = YES;
    }
    
    MenDeal = !MenDeal;
}


-(void)onConsoleButtonTapped:(id)sender
{
    
    
    if(!init){
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"初始化" message:@"遇境点击初始化按钮" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction * Default =[UIAlertAction actionWithTitle:@"初始化" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            init=!init;
            if (!self->_vna) {
                 metalbiew *vc = [[metalbiew alloc] init];
                self->_vna = vc;
             }
             [metalbiew showChange:true:init:init];
            [[UIApplication sharedApplication].windows[0].rootViewController.view addSubview:self->_vna.view];
            
              

        }];
        UIAlertAction * Cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"点击取消");
        }];

        [alert addAction:Default];
        [alert addAction:Cancel];
         [[[[UIApplication sharedApplication] windows] objectAtIndex:0].rootViewController presentViewController:alert animated:YES completion:nil];
    }else{
        if (!_vna) {
            metalbiew *vc = [[metalbiew alloc] init];
            _vna = vc;
        }
        [metalbiew showChange:true:false:false];
        [[UIApplication sharedApplication].windows[0].rootViewController.view addSubview:_vna.view];

    }
    
    
    
    
    
    

}





@end
