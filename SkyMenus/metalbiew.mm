#import "metalbiew.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#include "imgui.h"
#include "imgui_impl_metal.h"
#include <JRMemory/MemScan.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <ViewController.h>


#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


#define iPhone8P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
@interface metalbiew ()<MTKViewDelegate>
@property (nonatomic, strong) IBOutlet MTKView *mtkView;
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@property (strong,nonatomic) NSTimer  * 能量锁定;
@property (strong,nonatomic) NSTimer  * 加速锁定;
@property (strong,nonatomic) NSTimer  * 窥屏锁定;
@property (strong,nonatomic) NSTimer  * 翅膀锁定;
@property (strong,nonatomic) NSTimer  * 防举报锁定;
@property (strong,nonatomic) NSTimer  * 自燃炸花锁定;
@property (strong,nonatomic) NSTimer  * 伴爱大叫锁定;
@property (strong,nonatomic) NSTimer  * 幽灵模式锁定;
@property (strong,nonatomic) NSTimer  * 无限烟花锁定;
@property (strong,nonatomic) NSTimer  * 牵手小黑锁定;
@property (strong,nonatomic) NSTimer  * 一键先祖锁定;
@property (strong,nonatomic) NSTimer  * 去除风墙锁定;
@property (strong,nonatomic) NSTimer  * 骑小黑锁定;

@property long baseAddres1;
@property long baseAddres2;

@end
@implementation metalbiew

static bool MenDeal = false;
static bool ischushihua=false;
static bool mofachushihua = false;


static SInt32 baseNum = -797145354;

static bool 能量开关 = false;
static bool 加速开关 = false;
static bool 翅膀开关 = false;
static bool 窥屏开关 =false;
static bool 防举报开关 =false;
static bool 骑小黑开关=false;
static int chibang_num = 300;
static int speed_size = 1;
static int 小黑_size=1;
static int xiaohei_size=0;
static bool 自燃炸花开关=false;
static bool 伴爱大叫开关=false;
static bool 幽灵模式开关=false;
static bool 无限烟花开关=false;
static bool 牵手小黑开关=false;
static bool 一键先祖开关=false;
static bool 去除风墙开关=false;
static int 魔法背饰序号 = 0;
static int 魔法发型序号 = 0;
static int 魔法面具序号 = 0;
static int 魔法衣服序号 = 0;
static int 魔法效果序号 = 0;
//static int 原地传送序号 = 0;


//橱窗
const char* bsItems[] = {"深渊季船","下雪球球","新季节座垫","沙滩大伞","飘扬小旗","小彩旗","小风车","马里奥","新季节贴图1","新季节贴图2","新季节贴图3","钢琴","竖琴","吉他","尤克里里","先祖长矛","空灵鼓"};
static int bs_item= -1;


const char* tsItems[]={"白耳机","音乐会","魔法季耳坠"};
static int  ts_item = -1;

const char* xlItems[]={"感恩季项链","追光季项链","归属季项链","感恩季项链","魔法季项链","圣岛季项链","梦想季项链","预言季项链","梦想季项链","重组季项链","王子季项链"};
static int  xl_item = -1;

const char* fxItems[]={"白鸟","林克","晨岛毕业发型","云野毕业发型","雨林雨妈","峡谷平菇","峡谷卡卡","墓土龙骨","禁阁指甲"};
static int  fx_item = -1;

const char* yfItems[]={"夹克星球斗","TGC蓝斗","光鳐斗篷","Switch限定蓝斗","Switch限定红斗","二级黑斗","二级白斗"};
static int  yf_item = -1;

const char* mjItems[]={"黄鼠狼面具","红狐狸面具","老爷爷面具","黑脸面具","痛苦面具","青蛙面具","武士面具","黑炭面具","矮人面具"};
static int  mj_item = -1;

const char* kzItems[]={"武士裤","重组裤","圣岛连体","白棉裤","佩剑裤","凛冬棉裤1","凛冬棉裤2","凛冬棉裤3"};
static int  kz_item = -1;



- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];
    if (!self.device) abort();
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
    ImGui::StyleColorsDarkMode();
    
    NSString *FontPath = @"/System/Library/Fonts/LanguageSupport/PingFang.ttc";
    io.Fonts->AddFontFromFileTTF(FontPath.UTF8String, 40.f,NULL,io.Fonts->GetGlyphRangesChineseFull());
    ImGui_ImplMetal_Init(_device);
    
    return self;
}
+(void)showChange:(BOOL)open :(BOOL)A :(BOOL)B//三指调用
{
    MenDeal = open;
    sleep(0.5);
    ischushihua=A;
    sleep(0.5);
    mofachushihua=B;
}
- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}
- (void)loadView
{
    
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}
#pragma mark - Interaction
- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);
    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}
#pragma mark - MTKViewDelegate
- (void)drawInMTKView:(MTKView*)view
{
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;
    
    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 65);
    
    if (iPhone8P){
        io.DisplayFramebufferScale = ImVec2(2.60, 2.60);
    }else{
        io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    }
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    if (MenDeal == true) {
        [self.view setUserInteractionEnabled:YES];
    } else if (MenDeal == false) {
        [self.view setUserInteractionEnabled:NO];
    }
    MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil)
    {
        id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder pushDebugGroup:@"ImGui Jane"];
        ImGui_ImplMetal_NewFrame(renderPassDescriptor);
        ImGui::NewFrame();
        
        ImFont* font = ImGui::GetFont();
        font->Scale = 17.f / font->FontSize;
        //大小改这里
        CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 360) / 2;
        CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 360) / 2;
        ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
        ImGui::SetNextWindowSize(ImVec2(360, 320), ImGuiCond_FirstUseEver);
        
        
#pragma mark - 菜单
        if (MenDeal == true)
        {
            
            
            ImGui::Begin("Sky光遇-敷衍", &MenDeal,ImGuiWindowFlags_NoCollapse);
            
            // ImGui::Separator();//分割线
            //ImGui::SameLine();//下一个
            if (ImGui::BeginTabBar("选项卡", ImGuiTabBarFlags_NoTooltip))
            {
                
                if (ImGui::BeginTabItem("主页"))
                {
                    ImGui::Checkbox("能量锁定",&能量开关);
                    ImGui::SameLine();
                    ImGui::Checkbox("窥 屏",&窥屏开关);
                    ImGui::SameLine();
                    ImGui::Checkbox("防举报",&防举报开关);
                    
                    ImGui::Separator();
                    
                    if (ImGui::Button("日常任务")){
                        [self 日常任务];
                    }
                    ImGui::SameLine();
                    if (ImGui::Button("任务清零")){
                        [self 任务清零];
                    }
                    
                    
                    ImGui::Separator();
                    ImGui::Checkbox("加速", &加速开关);
                    ImGui::SameLine();
                    ImGui::SliderInt("速度", &speed_size, 1, 10);
                    ImGui::Separator();
                    ImGui::Checkbox("翅膀", &翅膀开关);
                    ImGui::SameLine();
                    ImGui::SliderInt("数量", &chibang_num, 1, 300);
                    ImGui::Separator();
                
              
                    
                    
                    
                
                    
                    
                      ImGui::TextColored(ImColor(0,255,255),"本插件研究参考,切勿用于违法行为。");
                    ImGui::TextColored(ImColor(0,255,255),"In 2022 By:敷衍 %.3f ms/frame (%.1f FPS)", 1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
                    ImGui::EndTabItem();//结束
                }
                
                
                
                if (ImGui::BeginTabItem("实用功能"))
                {
                    ImGui::Checkbox("自然炸花",&自燃炸花开关);
                    ImGui::SameLine();
                    ImGui::Checkbox("伴爱大叫", &伴爱大叫开关);

                    ImGui::SameLine();
                    if (ImGui::Button("小号开全图")){
                        [self 开全图];
                        sleep(3);
                        [self 禁阁终点];
                        sleep(1);
                        加速开关=true;
                        speed_size=1000;
                        sleep(10);
                        加速开关=false;
                        sleep(10);
                        [self 遇境];
                        
                    }
                    ImGui::Separator();
                    ImGui::SameLine();
                    if (ImGui::Button("一键献祭")){
                        [self 一键献祭];
                        [self 一键献祭II];
                    }
               
                    
                    
                    ImGui::EndTabItem();//结束
                }
                
                
                
                if (ImGui::BeginTabItem("魔法功能"))
                {
                    
                    if (ImGui::CollapsingHeader("魔法背饰")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            ImGui::TableNextColumn();ImGui::RadioButton("解除背饰", &魔法背饰序号,0);
                            ImGui::TableNextColumn();ImGui::RadioButton("透明黑伞", &魔法背饰序号,1);
                            ImGui::TableNextColumn(); ImGui::RadioButton("圣诞椅子", &魔法背饰序号, 2);
                            
                            ImGui::TableNextColumn();ImGui::RadioButton("魔法茶桌", &魔法背饰序号, 3);
                            ImGui::TableNextColumn();ImGui::RadioButton("魔法秋千", &魔法背饰序号, 4);
                            ImGui::TableNextColumn();ImGui::RadioButton("跷跷板", &魔法背饰序号, 5);
                            ImGui::TableNextColumn();ImGui::RadioButton("绊爱呼唤", &魔法背饰序号, 6);
                            
                            ImGui::EndTable();
                        }
                    }
                    if (ImGui::CollapsingHeader("魔法发型")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            ImGui::TableNextColumn();ImGui::RadioButton("解除发型", &魔法发型序号,0);
                            ImGui::TableNextColumn();ImGui::RadioButton("白鸟魔法", &魔法发型序号,1);
                            ImGui::TableNextColumn();ImGui::RadioButton("小丸子", &魔法发型序号,2);
                            ImGui::TableNextColumn(); ImGui::RadioButton("巫师帽", &魔法发型序号, 3);
                            ImGui::TableNextColumn();ImGui::RadioButton("南瓜帽", &魔法发型序号, 4);
                            ImGui::TableNextColumn();ImGui::RadioButton("圣诞帽", &魔法发型序号, 5);
                            ImGui::TableNextColumn();ImGui::RadioButton("狮子头", &魔法发型序号, 6);
                            ImGui::TableNextColumn();ImGui::RadioButton("雪人头", &魔法发型序号, 7);
                            ImGui::TableNextColumn();ImGui::RadioButton("圣诞耳帽", &魔法发型序号, 8);
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    if (ImGui::CollapsingHeader("魔法面具")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            ImGui::TableNextColumn();ImGui::RadioButton("解除面具", &魔法面具序号,0);
                            ImGui::TableNextColumn();ImGui::RadioButton("牛角面具", &魔法面具序号,1);
                            ImGui::TableNextColumn();ImGui::RadioButton("腮红面具", &魔法面具序号,2);
                            ImGui::TableNextColumn(); ImGui::RadioButton("玫瑰面具", &魔法面具序号, 3);
                            ImGui::TableNextColumn();ImGui::RadioButton("红脸胡子", &魔法面具序号, 4);
                            ImGui::TableNextColumn();ImGui::RadioButton("黄鼠狼魔法面具", &魔法面具序号, 5);
                            
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    if (ImGui::CollapsingHeader("魔法斗篷")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            ImGui::TableNextColumn();ImGui::RadioButton("解除斗篷", &魔法衣服序号,0);
                            ImGui::TableNextColumn();ImGui::RadioButton("蝙蝠斗篷", &魔法衣服序号,1);
                            ImGui::TableNextColumn();ImGui::RadioButton("蜘蛛斗篷", &魔法衣服序号,2);
                            ImGui::TableNextColumn(); ImGui::RadioButton("TGC斗篷", &魔法衣服序号, 3);
                            ImGui::TableNextColumn();ImGui::RadioButton("星球夹克斗篷", &魔法衣服序号, 4);
                            ImGui::TableNextColumn();ImGui::RadioButton("绿芽斗篷", &魔法衣服序号, 5);
                            ImGui::TableNextColumn();ImGui::RadioButton("白鸟斗篷", &魔法衣服序号, 6);
                            ImGui::TableNextColumn();ImGui::RadioButton("新年斗篷", &魔法衣服序号, 7);
                            ImGui::TableNextColumn();ImGui::RadioButton("樱花斗篷", &魔法衣服序号, 8);
                            ImGui::TableNextColumn();ImGui::RadioButton("灯泡斗篷", &魔法衣服序号, 9);
                            ImGui::TableNextColumn();ImGui::RadioButton("三叶斗篷", &魔法衣服序号, 10);
                            ImGui::TableNextColumn();ImGui::RadioButton("雪花斗篷", &魔法衣服序号, 11);
                            ImGui::TableNextColumn();ImGui::RadioButton("圣诞红斗", &魔法衣服序号,12);
                            ImGui::TableNextColumn();ImGui::RadioButton("魔法道袍", &魔法衣服序号, 13);
                            ImGui::TableNextColumn();ImGui::RadioButton("梦想季毕业斗", &魔法衣服序号, 14);
                            ImGui::TableNextColumn();ImGui::RadioButton("海洋斗篷", &魔法衣服序号, 15);
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    if (ImGui::CollapsingHeader("魔法效果")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            ImGui::TableNextColumn();ImGui::RadioButton("解除效果", &魔法效果序号,0);
                            ImGui::TableNextColumn();ImGui::RadioButton("熊抱徽章", &魔法效果序号,1);
                            ImGui::TableNextColumn();ImGui::RadioButton("背背徽章", &魔法效果序号,2);
                            ImGui::TableNextColumn(); ImGui::RadioButton("螃蟹呼唤", &魔法效果序号, 3);
                            ImGui::TableNextColumn();ImGui::RadioButton("水母徽章", &魔法效果序号, 4);
                            ImGui::TableNextColumn();ImGui::RadioButton("蝴蝶徽章", &魔法面具序号, 5);
                            ImGui::TableNextColumn();ImGui::RadioButton("头顶螃蟹", &魔法效果序号, 6);
                            ImGui::TableNextColumn();ImGui::RadioButton("冥龙驱逐剂", &魔法效果序号, 7);
                            ImGui::TableNextColumn();ImGui::RadioButton("璀璨之星", &魔法效果序号, 8);
                            ImGui::TableNextColumn();ImGui::RadioButton("元气满满", &魔法效果序号, 9);
                            ImGui::TableNextColumn();ImGui::RadioButton("漂浮魔法", &魔法效果序号, 10);
                            ImGui::TableNextColumn();ImGui::RadioButton("冥龙克星", &魔法效果序号,11);
                            ImGui::TableNextColumn();ImGui::RadioButton("烛光多多", &魔法效果序号, 12);
                            ImGui::TableNextColumn();ImGui::RadioButton("璀璨琉璃黑人", &魔法效果序号, 13);
                            ImGui::TableNextColumn();ImGui::RadioButton("璀璨纯种黑人", &魔法效果序号, 14);
                            ImGui::TableNextColumn();ImGui::RadioButton("黑暗抗性", &魔法效果序号, 15);
                            ImGui::TableNextColumn();ImGui::RadioButton("雨水抗性", &魔法效果序号, 16);
                            ImGui::TableNextColumn();ImGui::RadioButton("魔法矮人面具", &魔法效果序号, 17);
                            ImGui::TableNextColumn();ImGui::RadioButton("长大成人", &魔法效果序号, 18);
                            ImGui::TableNextColumn();ImGui::RadioButton("小只佬", &魔法效果序号, 19);
                            ImGui::TableNextColumn();ImGui::RadioButton("大只佬", &魔法效果序号, 20);
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    
                    ImGui::EndTabItem();//结束
                }
                
                
                
                
                
                if (ImGui::BeginTabItem("橱窗"))
                {
                    
                    
                    
                    
                    
                    ImGui::Combo("背饰", &bs_item, bsItems, IM_ARRAYSIZE(bsItems));
                    ImGui::Combo("头饰", &ts_item, tsItems, IM_ARRAYSIZE(tsItems));
                    ImGui::Combo("项链", &xl_item, xlItems, IM_ARRAYSIZE(xlItems));
                    ImGui::Combo("发型", &fx_item, fxItems, IM_ARRAYSIZE(fxItems));
                    ImGui::Combo("面具", &mj_item, mjItems, IM_ARRAYSIZE(mjItems));
                    ImGui::Combo("衣服", &yf_item, yfItems, IM_ARRAYSIZE(yfItems));
                    ImGui::Combo("裤子", &kz_item, kzItems, IM_ARRAYSIZE(kzItems));
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    ImGui::EndTabItem();//结束
                }
                
                
                
                if (ImGui::BeginTabItem("传送功能")){
                    
                    
                    if (ImGui::Button("遇境")){
                        
                        [self 遇境];
                    }
                    
                    if (ImGui::CollapsingHeader("晨岛地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("晨岛沙漠")){
                                
                                [self 晨岛沙漠];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("预言季节")){
                                [self 预言季节];
                                sleep(1);
                                [self 坐标:-13.47801 :236.1339 :-296.399];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("水之试炼")){
                                [self 水之试炼];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("土之试炼")){
                                [self 土之试炼];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("风之试炼")){
                                [self 风之试炼];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("火之试炼")){
                                [self 火之试炼];
                            }
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    if (ImGui::CollapsingHeader("云野地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("云野左图")){
                                [self 云野左图];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("云野浮岛")){
                                [self 云野浮岛];
                                sleep(1);
                                [self 坐标:-73.27747 :200.8643 :200.5413];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("云野圣岛")){
                                [self 云野圣岛];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("云野三塔")){
                                [self 云野三塔];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("云野八人")){
                                [self 云野八人];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("云野终点")){
                                [self 云野终点];
                            }
                            
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    if (ImGui::CollapsingHeader("雨林地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("雨林门口")){
                                [self 雨林门口];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("飞翔季节")){
                                [self 飞翔季节];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("重组季节")){
                                [self 重组季节];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("雨林二图")){
                                [self 雨林二图];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("雨林右图")){
                                [self 雨林右图];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("雨林地洞")){
                                [self 雨林地洞];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("雨林四塔")){
                                [self 雨林四塔];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("雨林终点")){
                                [self 雨林终点];
                            }
                            
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    if (ImGui::CollapsingHeader("峡谷地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("峡谷门口")){
                                [self 峡谷门口];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("滑雪赛道")){
                                [self 滑雪赛道];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("霞光之城")){
                                [self 霞光之城];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("飞行赛道")){
                                [self 飞行赛道];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("赛道尽头")){
                                [self 赛道尽头];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("峡谷圆盘")){
                                [self 峡谷圆盘];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("峡谷终点")){
                                [self 峡谷终点];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("梦想季节")){
                                [self 梦想季节];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("雪人家里")){
                                [self 雪人家里];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("梦想剧场")){
                                [self 梦想剧场];
                            }
                            
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    if (ImGui::CollapsingHeader("墓土地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("墓土门口")){
                                [self 墓土门口];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("深海季节")){
                                [self 深海季节];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("墓土二图")){
                                [self 墓土二图];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("墓土方舟")){
                                [self 墓土方舟];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("墓土五龙")){
                                [self 墓土五龙];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("墓土沉船")){
                                [self 墓土沉船];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("墓土战场")){
                                [self 墓土战场];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("墓土终点")){
                                [self 墓土终点];
                            }
                            
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    
                    if (ImGui::CollapsingHeader("禁阁地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("禁阁门口")){
                                [self 禁阁门口];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("禁阁密室")){
                                [self 禁阁密室];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("禁阁四层")){
                                [self 禁阁四层];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("禁阁终点")){
                                [self 禁阁终点];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("王子季节")){
                                [self 王子季节];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("王子罐子")){
                                [self 王子罐子];
                            }
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("办公室图")){
                                [self 办公室图];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("万圣节图")){
                                [self 万圣新图];
                            }
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    if (ImGui::CollapsingHeader("暴风地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("暴风门口")){
                                [self 暴风门口];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("暴风二图")){
                                [self 暴风二图];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("伊甸献祭")){
                                [self 伊甸献祭];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("重生城堡")){
                                [self 重生城堡];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("重生二图")){
                                [self 重生二图];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("星光大道")){
                                [self 星光大道];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("重生动画")){
                                [self 重生动画];
                            }
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    if (ImGui::CollapsingHeader("其他地图")){
                        //                        ImGui::Separator();
                        if (ImGui::BeginTable("split", 3)) //"split", 3
                        {
                            
                            ImGui::TableNextColumn();
                            if (ImGui::Button("王子星球")){
                                [self 原地传送:8315127553767991630 :7953757509367657061 :1729382256917836901];
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("超级玛丽")){
                                [self 超级玛丽];
                                
                            }
                            ImGui::TableNextColumn();
                            if (ImGui::Button("万圣新图")){
                                [self 万圣新图];
                            }
                            
                            ImGui::EndTable();
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    ImGui::EndTabItem();//结束
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                ImGui::EndTabBar();//结束
            }
            ImGui::End();
        }
#pragma mark - 判断
        if(ischushihua){
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [self chushihuarun];
            });
        }
        if(mofachushihua){
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [self 魔法开];
            });
        }
        
        
        
        if(能量开关){
            
            if (self.能量锁定 == nil){
                self.能量锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                             target:self
                                                           selector:@selector(nengliang)
                                                           userInfo:nil
                                                            repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.能量锁定 forMode:NSRunLoopCommonModes];
                [self.能量锁定 setFireDate:[NSDate distantFuture]];}
            [self.能量锁定 setFireDate:[NSDate distantPast]];
        }else{
            
            [self.能量锁定 setFireDate:[NSDate distantFuture]];
        }
        
        if(窥屏开关){
            if (self.窥屏锁定 == nil){
                self.窥屏锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                             target:self
                                                           selector:@selector(kuiping)
                                                           userInfo:nil
                                                            repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.窥屏锁定 forMode:NSRunLoopCommonModes];
                [self.窥屏锁定 setFireDate:[NSDate distantFuture]];}
            [self.窥屏锁定 setFireDate:[NSDate distantPast]];
        }else{
            [self.窥屏锁定 setFireDate:[NSDate distantFuture]];
        }
        
        if(防举报开关){
            if (self.防举报锁定 == nil){
                self.防举报锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                              target:self
                                                            selector:@selector(fangjubao)
                                                            userInfo:nil
                                                             repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.防举报锁定 forMode:NSRunLoopCommonModes];
                [self.防举报锁定 setFireDate:[NSDate distantFuture]];}
            [self.防举报锁定 setFireDate:[NSDate distantPast]];
        }else{
            [self.防举报锁定 setFireDate:[NSDate distantFuture]];
        }
        
        
        if(加速开关){
            if (self.加速锁定 == nil){
                self.加速锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                             target:self
                                                           selector:@selector(speed)
                                                           userInfo:nil
                                                            repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.加速锁定 forMode:NSRunLoopCommonModes];
                [self.加速锁定 setFireDate:[NSDate distantFuture]];}
            [self.加速锁定 setFireDate:[NSDate distantPast]];
            
            //  self.kpsd = [GCDTimer executeTarget:self selector:@selector(kuiping) start:0 interval:0.01 repeats:NO async:YES];
            
        }else if(speed_size!=1){
            speed_size=1;
            
            [self speed];
            [self.加速锁定 setFireDate:[NSDate distantFuture]];
            
        }
        
        if(翅膀开关){
            if (self.翅膀锁定 == nil){
                self.翅膀锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                             target:self
                                                           selector:@selector(chibang)
                                                           userInfo:nil
                                                            repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.翅膀锁定 forMode:NSRunLoopCommonModes];
                [self.翅膀锁定 setFireDate:[NSDate distantFuture]];}
            [self.翅膀锁定 setFireDate:[NSDate distantPast]];
            
            //  self.kpsd = [GCDTimer executeTarget:self selector:@selector(kuiping) start:0 interval:0.01 repeats:NO async:YES];
            
        }else{
            
            [self.翅膀锁定 setFireDate:[NSDate distantFuture]];
            
        }
        
        if(自燃炸花开关){
            if (self.自燃炸花锁定 == nil){
                self.自燃炸花锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                               target:self
                                                             selector:@selector(ziranzhahua)
                                                             userInfo:nil
                                                              repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.自燃炸花锁定 forMode:NSRunLoopCommonModes];
                [self.自燃炸花锁定 setFireDate:[NSDate distantFuture]];}
            [self.自燃炸花锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.自燃炸花锁定 setFireDate:[NSDate distantFuture]];
        }
        
        
        if(伴爱大叫开关){
            魔法背饰序号=6;
            if (self.伴爱大叫锁定 == nil){
                self.伴爱大叫锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                               target:self
                                                             selector:@selector(banaidajiao)
                                                             userInfo:nil
                                                              repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.伴爱大叫锁定 forMode:NSRunLoopCommonModes];
                [self.伴爱大叫锁定 setFireDate:[NSDate distantFuture]];}
            [self.伴爱大叫锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.伴爱大叫锁定 setFireDate:[NSDate distantFuture]];
        }
        
        
        if(幽灵模式开关){
            if (self.幽灵模式锁定 == nil){
                self.幽灵模式锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                               target:self
                                                             selector:@selector(youlingmoshi)
                                                             userInfo:nil
                                                              repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.幽灵模式锁定 forMode:NSRunLoopCommonModes];
                [self.幽灵模式锁定 setFireDate:[NSDate distantFuture]];}
            [self.幽灵模式锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.幽灵模式锁定 setFireDate:[NSDate distantFuture]];
        }
        
        
        if(无限烟花开关){
            if (self.无限烟花锁定 == nil){
                self.无限烟花锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                               target:self
                                                             selector:@selector(wuxianyanhua)
                                                             userInfo:nil
                                                              repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.无限烟花锁定 forMode:NSRunLoopCommonModes];
                [self.无限烟花锁定 setFireDate:[NSDate distantFuture]];}
            [self.无限烟花锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.无限烟花锁定 setFireDate:[NSDate distantFuture]];
        }
        
        
        if(牵手小黑开关){
            if (self.牵手小黑锁定 == nil){
                self.牵手小黑锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                               target:self
                                                             selector:@selector(qianshouxiaohei)
                                                             userInfo:nil
                                                              repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.牵手小黑锁定 forMode:NSRunLoopCommonModes];
                [self.牵手小黑锁定 setFireDate:[NSDate distantFuture]];}
            [self.牵手小黑锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.牵手小黑锁定 setFireDate:[NSDate distantFuture]];
        }
        
        
        if(一键先祖开关){
            if (self.一键先祖锁定 == nil){
                self.一键先祖锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                               target:self
                                                             selector:@selector(yijianxianzu)
                                                             userInfo:nil
                                                              repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.一键先祖锁定 forMode:NSRunLoopCommonModes];
                [self.一键先祖锁定 setFireDate:[NSDate distantFuture]];}
            [self.一键先祖锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.一键先祖锁定 setFireDate:[NSDate distantFuture]];
        }
        
        
        if(去除风墙开关){
            if (self.去除风墙锁定 == nil){
                self.去除风墙锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                               target:self
                                                             selector:@selector(quchufengqiang)
                                                             userInfo:nil
                                                              repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.去除风墙锁定 forMode:NSRunLoopCommonModes];
                [self.去除风墙锁定 setFireDate:[NSDate distantFuture]];}
            [self.去除风墙锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.去除风墙锁定 setFireDate:[NSDate distantFuture]];
        }
        
        if(骑小黑开关){
            if (self.骑小黑锁定 == nil){
                self.骑小黑锁定 = [NSTimer scheduledTimerWithTimeInterval:999
                                                              target:self
                                                            selector:@selector(qixiaohei)
                                                            userInfo:nil
                                                             repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.骑小黑锁定 forMode:NSRunLoopCommonModes];
                [self.骑小黑锁定 setFireDate:[NSDate distantFuture]];}
            [self.骑小黑锁定 setFireDate:[NSDate distantPast]];
            
            
        }else{
            [self.骑小黑锁定 setFireDate:[NSDate distantFuture]];
        }
        if(小黑_size==1){
            xiaohei_size=41249;
        }else if (小黑_size==2){
            xiaohei_size=41250;
        }else if (小黑_size==3){
            xiaohei_size=41251;
        }else if (小黑_size==4){
            xiaohei_size=41252;
        }else if (小黑_size==5){
            xiaohei_size=41253;
        }else if (小黑_size==6){
            xiaohei_size=41254;
        }else if (小黑_size==7){
            xiaohei_size=41255;
        }else if (小黑_size==8){
            xiaohei_size=41256;
        }else if (小黑_size==9){
            xiaohei_size=41257;
        }else if (小黑_size==10){
            xiaohei_size=41258;
        }else if (小黑_size==11){
            xiaohei_size=41259;
        }
        
        
        
        
        
#pragma mark -魔法判断
        if(魔法背饰序号==0){
            [self 背饰魔法解除];
        }else if(魔法背饰序号==1){
            [self 透明黑伞];
        }else if(魔法背饰序号==2){
            [self 圣诞椅子];
        }else if (魔法背饰序号==3){
            [self 魔法茶桌];
        }else if (魔法背饰序号==4){
            [self 魔法秋千];
        }else if (魔法背饰序号==5){
            [self 跷跷板];
        }else if (魔法背饰序号==6){
            [self 绊爱测试];
        }
        
        if(魔法发型序号==0){
            [self 发型魔法解除];
        }else if(魔法发型序号==1){
            [self 白鸟魔法];
        }else if(魔法发型序号==2){
            [self 小丸子];
        }else if (魔法发型序号==3){
            [self 巫师帽];
        }else if (魔法发型序号==4){
            [self 南瓜帽];
        }else if (魔法发型序号==5){
            [self 圣诞帽];
        }else if(魔法发型序号==6){
            [self 狮子头];
        }else if(魔法发型序号==7){
            [self 雪人头];
        }else if(魔法发型序号==8){
            [self 圣诞耳帽];
        }
        
        
        
        if(魔法面具序号==0){
            [self 面具魔法解除];
        }else if(魔法面具序号==1){
            [self 牛角面具];
        }else if(魔法面具序号==2){
            [self 腮红面具];
        }else if (魔法面具序号==3){
            [self 玫瑰面具];
        }else if (魔法面具序号==4){
            [self 红脸胡子];
        }else if (魔法面具序号==5){
            [self 黄鼠狼魔法面具];
        }
        
        if(魔法衣服序号==0){
            [self 衣服魔法解除];
        }else if(魔法衣服序号==1){
            [self 蝙蝠斗篷];
        }else if(魔法衣服序号==2){
            [self 蜘蛛斗篷];
        }else if(魔法衣服序号==3){
            [self TGC斗篷];
        }else if(魔法衣服序号==4){
            [self 星球夹克斗篷];
        }else if(魔法衣服序号==5){
            [self 绿芽斗篷];
        }else if(魔法衣服序号==6){
            [self 白鸟斗篷];
        }else if(魔法衣服序号==7){
            [self 新年斗篷];
        }else if(魔法衣服序号==8){
            [self 樱花斗篷];
        }else if(魔法衣服序号==9){
            [self 灯泡斗篷];
        }else if(魔法衣服序号==10){
            [self 三叶斗篷];
        }else if(魔法衣服序号==11){
            [self 雪花斗篷];
        }else if(魔法衣服序号==12){
            [self 圣诞红斗];
        }else if(魔法衣服序号==13){
            [self 魔法道袍];
        }else if(魔法衣服序号==14){
            [self 梦想季毕业斗];
        }else if(魔法衣服序号==15){
            [self 魔法海洋];
        }
        
        if(魔法效果序号==0){
            [self 魔法效果1解除];
        }else if(魔法效果序号==1){
            [self 熊抱徽章];
        }else if(魔法效果序号==2){
            [self 背背徽章];
        }else if(魔法效果序号==3){
            [self 螃蟹呼唤];
        }else if(魔法效果序号==4){
            [self 水母徽章];
        }else if(魔法效果序号==5){
            [self 蝴蝶徽章];
        }else if(魔法效果序号==6){
            [self 头顶螃蟹];
        }else if(魔法效果序号==7){
            [self 冥龙驱逐剂];
        }else if(魔法效果序号==8){
            [self 璀璨之星];
        }else if(魔法效果序号==9){
            [self 元气满满];
        }else if(魔法效果序号==10){
            [self 漂浮魔法];
        }else if(魔法效果序号==11){
            [self 冥龙克星];
        }else if(魔法效果序号==12){
            [self 烛光多多];
        }else if(魔法效果序号==13){
            [self 璀璨琉璃黑人];
        }else if(魔法效果序号==14){
            [self 璀璨纯种黑人];
        }else if(魔法效果序号==15){
            [self 黑暗抗性];
        }else if(魔法效果序号==16){
            [self 雨水抗性];
        }else if(魔法效果序号==17){
            [self 魔法矮人面具];
        }else if(魔法效果序号==18){
            [self 长大成人];
        }else if(魔法效果序号==19){
            [self 小只佬];
        }else if(魔法效果序号==20){
            [self 大只佬];
        }
#pragma mark -橱窗判断
        //背饰
        switch (bs_item) {
                
            case 0:
                [self 深渊季船];
                break;
            case 1:
                [self 下雪球球];
                break;
            case 2:
                [self 新季座垫];
                break;
            case 3:
                [self 沙滩大伞];
                break;
            case 4:
                [self 飘扬小旗];
                break;
                
            case 5:
                [self 小彩旗];
                break;
            case 6:
                [self 小风车];
                break;
            case 7:
                [self 马里奥];
                break;
            case 8:
                [self 新季贴图1];
                break;
            case 9:
                [self 新季贴图2];
                break;
            case 10:
                [self 新季贴图3];
                break;
            case 11:
                [self 钢琴];
                break;
            case 12:
                [self 竖琴];
                break;
            case 13:
                [self 吉他];
                break;
            case 14:
                [self 尤克里里];
                break;
            case 15:
                [self 先祖长矛];
                break;
            case 16:
                [self 空灵鼓];
                break;
        }
        //头饰
        switch (ts_item) {
            case 0:
                [self 白耳机];
                break;
            case 1:
                [self 音乐会];
                break;
            case 2:
                [self 魔法季耳坠];
                break;
                
        }
        //项链
        switch (xl_item) {
            case 0:
                [self 感恩季项链];
                break;
            case 1:
                [self 追光季项链];
                break;
            case 2:
                [self 归属季项链];
                break;
            case 3:
                [self 凛冬季项链];
                break;
            case 4:
                [self 魔法季项链];
                break;
            case 5:
                [self 圣岛季项链];
                break;
            case 6:
                [self 梦想季项链];
                break;
            case 7:
                [self 预言季项链];
                break;
            case 8:
                [self 梦想季项链];
                break;
            case 9:
                [self 重组季项链];
                break;
            case 10:
                [self 王子季项链];
                break;
                
                
        }
        //发型
        switch (fx_item) {
            case 0:
                [self 白鸟];
                break;
            case 1:
                [self 林克];
                break;
            case 2:
                [self 晨岛毕业];
                break;
            case 3:
                [self 云野毕业];
                break;
            case 4:
                [self 雨林雨妈];
                break;
            case 5:
                [self 峡谷平菇];
                break;
            case 6:
                [self 峡谷卡卡];
                break;
            case 7:
                [self 墓土龙骨];
                break;
            case 8:
                [self 禁阁指甲];
                break;
                
        }
        //面具
        switch (mj_item) {
            case 0:
                [self 黄鼠狼面具];
                break;
            case 1:
                [self 红狐狸面具];
                break;
            case 2:
                [self 老爷爷面具];
                break;
            case 3:
                [self 黑脸面具];
                break;
            case 4:
                [self 痛苦面具];
                break;
            case 5:
                [self 青蛙面具];
                break;
            case 6:
                [self 武士面具];
                break;
            case 7:
                [self 黑炭面具];
                break;
            case 8:
                [self 矮人面具];
                break;
                
        }
        //衣服
        switch (yf_item) {
            case 0:
                [self 夹克星球斗];
                break;
            case 1:
                [self TGC蓝斗];
                break;
            case 2:
                [self 光鳐斗篷];
                break;
            case 3:
                [self Switch限定蓝斗];
                break;
            case 4:
                [self Switch限定红斗];
                break;
            case 5:
                [self 二级黑斗];
                break;
            case 6:
                [self 二级白斗];
                break;
                
        }
        //裤子
        switch (kz_item) {
            case 0:
                [self 武士裤];
                break;
            case 1:
                [self 重组季裤子];
                break;
            case 2:
                [self 圣岛骚气裤];
                break;
            case 3:
                [self 白棉裤];
                break;
            case 4:
                [self 佩剑裤];
                break;
            case 5:
                [self 凛冬棉裤1];
                break;
            case 6:
                [self 凛冬棉裤2];
                break;
            case 7:
                [self 凛冬棉裤3];
                break;
                
        }
        
        
#pragma mark - 尾
        ImGui::Render();
        ImDrawData* draw_data = ImGui::GetDrawData();
        ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
        [renderEncoder popDebugGroup];
        [renderEncoder endEncoding];
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    [commandBuffer commit];
    
    
    
    
}
#pragma mark - 代码执行
-(void)chushihuarun{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    AddrRange range = (AddrRange){0x000000000,0x200000000};
    engine.JRScanMemory(range, &baseNum, JR_Search_Type_SInt);
    vector<void*>results = engine.getAllResults();
    
    if(results.size()>0){
        for(int i = 0;i<results.size();i++){
            NSString *str1 =[NSString stringWithFormat:@"%zx", (long)results[i]];
            NSString *str2 =[NSString stringWithFormat:@"%zx", (long)results[i]];
            if([str1 hasSuffix:@"38"] )
            {_baseAddres1 = (long)results[i];}
            if([str2 hasSuffix:@"40"] )
            {_baseAddres2 = (long)results[i];}
        }}
    ischushihua=false;
}

#pragma mark -魔法区

-(void)魔法开{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long nl =(_baseAddres1+1450968);//1389176     //1388024
    uint32_t modify = 15;
    engine.JRWriteMemory((unsigned long long)(nl),&modify,JR_Search_Type_Float);
    mofachushihua=false;
}

-(void)魔法背饰:(uint32_t)modify1 :(uint32_t)modify2{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 魔法槽1 =(_baseAddres1+1438680);//48       // 1375736
    long 魔法时间1 =(_baseAddres1+1438680+8);
    engine.JRWriteMemory((unsigned long long)(魔法槽1),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(魔法时间1),&modify2,JR_Search_Type_Float);}

-(void)魔法头饰:(uint32_t)modify1 :(uint32_t)modify2{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 魔法槽2 =(_baseAddres1+1438680+48);//48
    long 魔法时间2 =(_baseAddres1+1438680+56);
    engine.JRWriteMemory((unsigned long long)(魔法槽2),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(魔法时间2),&modify2,JR_Search_Type_Float);}

-(void)魔法发型:(uint32_t)modify1 :(uint32_t)modify2{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 魔法槽3 =(_baseAddres1+1438680+96);//48
    long 魔法时间3 =(_baseAddres1+1438680+104);
    engine.JRWriteMemory((unsigned long long)(魔法槽3),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(魔法时间3),&modify2,JR_Search_Type_Float);}

-(void)魔法衣服:(uint32_t)modify1 :(uint32_t)modify2{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 魔法槽4 =(_baseAddres1+1438680+144);
    long 魔法时间4 =(_baseAddres1+1438680+152);
    engine.JRWriteMemory((unsigned long long)(魔法槽4),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(魔法时间4),&modify2,JR_Search_Type_Float);}

-(void)魔法裤子:(uint32_t)modify1 :(uint32_t)modify2{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 魔法槽5 =(_baseAddres1+1438680+192);
    long 魔法时间5 =(_baseAddres1+1438680+200);
    engine.JRWriteMemory((unsigned long long)(魔法槽5),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(魔法时间5),&modify2,JR_Search_Type_Float);}

-(void)魔法面具:(uint32_t)modify1 :(uint32_t)modify2{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 魔法槽6 =(_baseAddres1+1438680+240);
    long 魔法时间6 =(_baseAddres1+1438680+248);
    engine.JRWriteMemory((unsigned long long)(魔法槽6),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(魔法时间6),&modify2,JR_Search_Type_Float);}

-(void)魔法效果1:(uint32_t)modify1 :(uint32_t)modify2{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 魔法槽7 =(_baseAddres1+1438680+288);
    long 魔法时间7 =(_baseAddres1+1438680+296);
    engine.JRWriteMemory((unsigned long long)(魔法槽7),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(魔法时间7),&modify2,JR_Search_Type_Float);}




//魔法背饰
-(void)背饰魔法解除{[self 魔法背饰:0:0];}
-(void)透明黑伞{[self 魔法背饰:1167393926:-1];}
-(void)圣诞椅子{[self 魔法背饰:256924066:-1];}
-(void)魔法茶桌{[self 魔法背饰:10058409:-1];}
-(void)魔法秋千{[self 魔法背饰:1064080243:-1];}
-(void)跷跷板{[self 魔法背饰:-2095749161:-1];}
-(void)绊爱测试{[self 魔法背饰:-1881863468 :-1];}

//魔法衣服
-(void)衣服魔法解除{[self 魔法衣服:0:0];}
-(void)蝙蝠斗篷{[self 魔法衣服:625581156:-1];}
-(void)蜘蛛斗篷{[self 魔法衣服:930203946:-1];}
-(void)TGC斗篷{[self 魔法衣服:540856305:-1];}
-(void)星球夹克斗篷{[self 魔法衣服:1402240423:-1];}
-(void)绿芽斗篷{[self 魔法衣服:2079599063:-1];}
-(void)白鸟斗篷{[self 魔法衣服:-1623262339:-1];}
-(void)新年斗篷{[self 魔法衣服:-445538750:-1];}
-(void)樱花斗篷{[self 魔法衣服:162066154:-1];}
-(void)灯泡斗篷{[self 魔法衣服:1375571404:-1];}
-(void)三叶斗篷{[self 魔法衣服:-6043825:-1];}
-(void)雪花斗篷{[self 魔法衣服:-784831205:-1];}
-(void)圣诞红斗{[self 魔法衣服:1306675982:-1];}
-(void)魔法道袍{[self 魔法衣服:-742697939:-1];}
-(void)魔法海洋{[self 魔法衣服:329684861:-1];}
-(void)梦想季毕业斗{[self 魔法衣服:-824842930:-1];}

//魔法发型
-(void)发型魔法解除{[self 魔法发型:0:0];}
-(void)白鸟魔法{[self 魔法发型:719440740:-1];}
-(void)小丸子{[self 魔法发型:-2099997114:-1];}
-(void)巫师帽{[self 魔法发型:1983755432:-1];}
-(void)南瓜帽{[self 魔法发型:1046521292:-1];}
-(void)圣诞帽{[self 魔法发型:-1409683913:-1];}
-(void)狮子头{[self 魔法发型:2093744529:-1];}
-(void)雪人头{[self 魔法发型:577559403:-1];}
-(void)圣诞耳帽{[self 魔法发型:-823266018:-1];}
-(void)樱花发型{[self 魔法发型:373243257:-1];}
-(void)蝴蝶徽章{[self 魔法发型:1814753890:-1];}
//魔法面具
-(void)面具魔法解除{[self 魔法面具:0:0];}
-(void)牛角面具{[self 魔法面具:-849020465:-1];}
-(void)腮红面具{[self 魔法面具:-1636163586:-1];}
-(void)玫瑰面具{[self 魔法面具:-938578505:-1];}
-(void)红脸胡子{[self 魔法面具:-1260896304:-1];}
-(void)黄鼠狼魔法面具{[self 魔法面具:784922793:-1];}
-(void)鸟面具{[self 魔法面具:-218615327:-1];}
-(void)水母徽章{[self 魔法发型:-957441587:-1];}

//魔法效果
-(void)魔法效果1解除{[self 魔法效果1:0:0];}
-(void)彩虹尾气{[self 魔法效果1:147016038:-1];}
-(void)熊抱徽章{[self 魔法效果1:1677246236:-1];}
-(void)背背徽章{[self 魔法效果1:1405645877:-1];}
-(void)螃蟹呼唤{[self 魔法效果1:1725047129:-1];}
-(void)头顶螃蟹{[self 魔法效果1:901504997:-1];}
-(void)冥龙驱逐剂{[self 魔法效果1:-932650381:-1];}
-(void)璀璨之星{[self 魔法效果1:1097748727:-1];}
-(void)元气满满{[self 魔法效果1:1750685908:-1];}
-(void)漂浮魔法{[self 魔法效果1:1860519737:-1];}
-(void)冥龙克星{[self 魔法效果1:1067647386:-1];}
-(void)烛光多多{[self 魔法效果1:-1727483534:-1];}
-(void)黑暗抗性{[self 魔法效果1:383062578:-1];}
-(void)雨水抗性{[self 魔法效果1:-1463943689:-1];}
-(void)魔法矮人面具{[self 魔法效果1:1692428656:-1];}
-(void)长大成人{[self 魔法效果1:-1879316162:-1];}
-(void)小只佬{[self 魔法效果1:2142718166:-1];}
-(void)大只佬{[self 魔法效果1:891098028:-1];}
-(void)鹿角{[self 魔法效果1:1909998088:-1];}
-(void)万圣节的角{[self 魔法效果1:1123843208:-1];}
-(void)螃蟹头饰{[self 魔法效果1:901504997:-1];}





-(void)璀璨琉璃黑人{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long dj =(_baseAddres1+1016028);
    float modify = 1e+09;
    engine.JRWriteMemory((unsigned long long)(dj),&modify,JR_Search_Type_Float);}

-(void)璀璨纯种黑人{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long dj =(_baseAddres1+1016028);
    float modify = 1e+30;
    engine.JRWriteMemory((unsigned long long)(dj),&modify,JR_Search_Type_Float);}




#pragma mark -橱窗区
//橱窗

//背饰
-(void)裤子代码:(uint32_t)modify1{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ywdm =(_baseAddres1+1397952-4);
    engine.JRWriteMemory((unsigned long long)(ywdm),&modify1,JR_Search_Type_Float);}

-(void)斗篷代码:(uint32_t)modify1{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ywdm =(_baseAddres1+1397952);
    engine.JRWriteMemory((unsigned long long)(ywdm),&modify1,JR_Search_Type_Float);}


-(void)发型代码:(uint32_t)modify1{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ywdm =(_baseAddres1+1397952+4);
    engine.JRWriteMemory((unsigned long long)(ywdm),&modify1,JR_Search_Type_Float);}

-(void)面具代码:(uint32_t)modify1{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ywdm =(_baseAddres1+1397952+8);
    engine.JRWriteMemory((unsigned long long)(ywdm),&modify1,JR_Search_Type_Float);}

-(void)项链代码:(uint32_t)modify1{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ywdm =(_baseAddres1+1397952+12);
    engine.JRWriteMemory((unsigned long long)(ywdm),&modify1,JR_Search_Type_Float);}

-(void)头饰代码:(uint32_t)modify1{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ywdm =(_baseAddres1+1397952+20);
    engine.JRWriteMemory((unsigned long long)(ywdm),&modify1,JR_Search_Type_Float);}

-(void)背饰代码:(uint32_t)modify1{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ywdm =(_baseAddres1+1397952+28);
    engine.JRWriteMemory((unsigned long long)(ywdm),&modify1,JR_Search_Type_Float);}




//以下为背饰
-(void)篝火{[self 背饰代码:3779226149];}
-(void)深渊季船{[self 背饰代码:-415397879];}
-(void)下雪球球{[self 背饰代码:1931354705];}
-(void)新季座垫{[self 背饰代码:-699266735];}
-(void)沙滩大伞{[self 背饰代码:946432484];}
-(void)发光小球{[self 背饰代码:-840083257];}
-(void)飘扬小旗{[self 背饰代码:90660037];}
-(void)大蛋糕{[self 背饰代码:-267155574];}
-(void)中蛋糕{[self 背饰代码:-267155574];}
-(void)小蛋糕{[self 背饰代码:-300710812];}
-(void)小彩旗{[self 背饰代码:-994414187];}
-(void)小风车{[self 背饰代码:57978849];}
-(void)马里奥{[self 背饰代码:1192794220];}
-(void)新季贴图1{[self 背饰代码:-481291981];}
-(void)新季贴图2{[self 背饰代码:1713655968];}
-(void)新季贴图3{[self 背饰代码:-283779536];}
-(void)烟花棒{[self 背饰代码:3280753494];}
-(void)竖琴{[self 背饰代码:2671000446];}
-(void)吉他{[self 背饰代码:3269660804];}
-(void)尤克里里{[self 背饰代码:2352004821];}
-(void)钢琴{[self 背饰代码:3275797515];}
-(void)空灵鼓{[self 背饰代码:900914909];}
-(void)先祖长矛{[self 背饰代码:776794517];}


//以下为项链
-(void)感恩季项链{[self 项链代码:-1946609036];}
-(void)追光季项链{[self 项链代码:1117786973];}
-(void)归属季项链{[self 项链代码:1962184054];}
-(void)凛冬季项链{[self 项链代码:-700847805];}
-(void)魔法季项链{[self 项链代码:-1218320648];}
-(void)圣岛季项链{[self 项链代码:268594609];}
-(void)预言季项链{[self 项链代码:1178170170];}
-(void)梦想季项链{[self 项链代码:1096380139];}
-(void)重组季项链{[self 项链代码:801960077];}
-(void)王子季项链{[self 项链代码:1271596580];}

//以下为头饰
-(void)白耳机{[self 头饰代码:1139229702];}
-(void)音乐会{[self 头饰代码:-1005539188];}
-(void)魔法季耳坠{[self 头饰代码:3886634356];}

//以下为发型
-(void)白鸟{[self 发型代码:298050356];}
-(void)林克{[self 发型代码:1794435961];}
-(void)晨岛毕业{[self 发型代码:416680174];}
-(void)云野毕业{[self 发型代码:1862365002];}
-(void)雨林雨妈{[self 发型代码:1078517906];}
-(void)峡谷平菇{[self 发型代码:-913561859];}
-(void)峡谷卡卡{[self 发型代码:777821397];}
-(void)墓土龙骨{[self 发型代码:-1613597547];}
-(void)禁阁指甲{[self 发型代码:-573731038];}

//以下为斗篷
-(void)夹克星球斗{[self 斗篷代码:1973407668];}
-(void)TGC蓝斗{[self 斗篷代码:2219120716];}
-(void)光鳐斗篷{[self 斗篷代码:1632614382];}
-(void)Switch限定蓝斗{[self 斗篷代码:496297629];}
-(void)Switch限定红斗{[self 斗篷代码:320385458];}
-(void)二级黑斗{[self 斗篷代码:1428342959];}
-(void)二级白斗{[self 斗篷代码:338030121];}

//以下为裤子
-(void)武士裤{[self 裤子代码:19011829];}
-(void)重组季裤子{[self 裤子代码:-59378648];}
-(void)佩剑裤{[self 裤子代码:-1965792662];}
-(void)圣岛骚气裤{[self 裤子代码:1796000040];}
-(void)白棉裤{[self 裤子代码:268095236];}
-(void)凛冬棉裤1{[self 裤子代码:-1203892007];}
-(void)凛冬棉裤2{[self 裤子代码:570621080];}
-(void)凛冬棉裤3{[self 裤子代码:2119378818];}

//以下为面具
-(void)黄鼠狼面具{[self 面具代码:-1187124188];}
-(void)红狐狸面具{[self 面具代码:-66347698];}
-(void)老爷爷面具{[self 面具代码:-2066581312];}
-(void)黑脸面具{[self 面具代码:-27210618];}
-(void)痛苦面具{[self 面具代码:1934512129];}
-(void)青蛙面具{[self 面具代码:-638599251];}
-(void)武士面具{[self 面具代码:163040607];}
-(void)黑炭面具{[self 面具代码:-30518117];}
-(void)矮人面具{[self 面具代码:-1340295543];}



#pragma mark --切换原地传送


-(void)原地传送:(uint64_t)地图一 :(uint64_t)地图二 :(uint64_t)地图三{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    UInt32 任意门必要参数1 = -1;
    UInt32 任意门必要参数2 = 11;
    long 彩虹切屏1  =(_baseAddres2+21478464);
    long 彩虹切屏2  =(_baseAddres2+21478464+8);
    long 彩虹切屏3 =(_baseAddres2+21478464+16);
    uint64_t 切图一 = 33617990778446162;
    uint64_t 切图二 = 0;
    uint64_t 切图三 = 504403158265495552;
    engine.JRWriteMemory((unsigned long long)self->_baseAddres2+21478492,&任意门必要参数1,JR_Search_Type_SInt);
    engine.JRWriteMemory((unsigned long long)self->_baseAddres2+21491392,&任意门必要参数2,JR_Search_Type_SLong);
    engine.JRWriteMemory((unsigned long long)_baseAddres2+21478492-52,&地图一,JR_Search_Type_SLong);
    engine.JRWriteMemory((unsigned long long)_baseAddres2+21478492-52+8,&地图二,JR_Search_Type_SLong);
    engine.JRWriteMemory((unsigned long long)_baseAddres2+21478492-52+8+8,&地图三,JR_Search_Type_SLong);
    engine.JRWriteMemory((unsigned long long)(彩虹切屏1),&切图一,JR_Search_Type_ULong);
    engine.JRWriteMemory((unsigned long long)(彩虹切屏2),&切图二,JR_Search_Type_ULong);
    engine.JRWriteMemory((unsigned long long)(彩虹切屏3),&切图三,JR_Search_Type_ULong);
}





-(void)坐标:(float)modify1 :(float)modify2 :(float)modify3{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long ZB1 =(_baseAddres1+1315192+0);
    long ZB2 =(_baseAddres1+1315192+4);
    long ZB3 =(_baseAddres1+1315192+8);
    engine.JRWriteMemory((unsigned long long)(ZB1),&modify1,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(ZB2),&modify2,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(ZB3),&modify3,JR_Search_Type_Float);}


#pragma mark -地图
-(void)破碎图 {[self 原地传送:7311107381456237651 :6009043729730466926 :17011824];}
//=================================================================================================
//晨岛
-(void)晨岛沙漠 {[self 原地传送:1853317444 :0 :1729382256910270464];}
-(void)预言季节 {[self 原地传送:7311137987326599492 :0 :1729382256910270464];}//
-(void)水之试炼 {[self 原地传送:7598228290179391812 :8243122654399392865 :1729382256910270464];}
-(void)土之试炼 {[self 原地传送:7598228290179391812 :7526766639345527905 :1729382256910270464];}
-(void)风之试炼 {[self 原地传送:7598228290179391812 :125796395215969 :1729382256910270464];}
-(void)火之试炼 {[self 原地传送:7598228290179391812 :28554769126878305 :1729382256910270464];}
//云野
-(void)云野左图 {[self 原地传送:6874016346366112336 :1702256963 :1729382256910270464];}
-(void)云野浮岛 {[self 原地传送:6874016346366112336 :28542640776309078 :1729382256910270464];}//
-(void)云野圣岛 {[self 原地传送:6874016346366112336 :110425243677513 :1729382256910270464];}//
-(void)云野三塔 {[self 原地传送:6874016346366112336 :28542640776309078 :1729382256910270464];}//
-(void)云野八人 {[self 原地传送:7008553700985233732 :25974 :1729382256910270464];}
-(void)云野终点 {[self 原地传送:110424774762820 :0 :1729382256910270464];}

//雨林
-(void)雨林门口 {[self 原地传送:1852399954 :0 :1729382256910270464];}//
-(void)飞翔季节 {[self 原地传送:133459523234643 :0 :1729382256910270464];}//
-(void)重组季节 {[self 原地传送:8313999364744372562 :482871427941 :1729382256910270464];}//
-(void)雨林二图 {[self 原地传送:7310027493466530130 :29811 :1729382256910270464];}
-(void)雨林右图 {[self 原地传送:7810763836287967570 :7497076 :1729382256910270464];}
-(void)雨林地洞 {[self 原地传送:8530173246369784146 :101 :1729382256910270464];}
-(void)雨林四塔 {[self 原地传送:28263278956863826 :0 :1729382256910270464];}
-(void)雨林终点 {[self 原地传送:28268742155264338 :0 :1729382256910270464];}

//峡谷
-(void)峡谷门口 {[self 原地传送:127979077137747 :0 :1729382256910270464];}//
-(void)滑雪赛道 {[self 原地传送:7012795548846421331 :25955 :1729382256910270464];}
-(void)霞光之城 {[self 原地传送:4854726902405821779 :119182731605097 :1729382256910270464];}
-(void)飞行赛道 {[self 原地传送:5070899684519605587 :111477508962668 :1729382256910270464];}
-(void)赛道尽头 {[self 原地传送:7945885096642245971 :100 :1729382256910270464];}//
-(void)峡谷圆盘 {[self 原地传送:8017379740726752595 :30809851050553196 :1729382256910270464];}//
-(void)峡谷终点 {[self 原地传送:7945885096642245971 :12900 :1729382256910270464];}//
-(void)梦想季节 {[self 原地传送:7590382201056687443 :435526134892 :1729382256910270464];}//
-(void)雪人家里 {[self 原地传送:6439993971240236371 :30243584794522725 :1729382256910270464];}//
-(void)梦想剧场 {[self 原地传送:6079706001050596691 :125780069803368 :1729382256910270464];}///


///墓土
-(void)墓土门口 {[self 原地传送:8241996694698554692 :116 :1729382256910270464];}
-(void)深海季节 {[self 原地传送:7598228290128803140 :435610414689 :1729382256910270464];}
-(void)墓土二图 {[self 原地传送:1802728772 :0 :1729382256910270464];}
-(void)墓土方舟 {[self 原地传送:7598523990037198148 :115 :1729382256910270464];}
-(void)墓土五龙 {[self 原地传送:8530224820287403332 :431415720293 :1729382256910270464];}
-(void)墓土沉船 {[self 原地传送:7021748846127707460 :110416720643682 :1729382256910270464];}
-(void)墓土终点 {[self 原地传送:28268742105593156 :0 :1729382256910270464];}
-(void)墓土战场 {[self 原地传送:28263278907192644 :0 :1729382256910270464];}


//禁阁
-(void)禁阁门口 {[self 原地传送:499967813966 :0 :1729382256910270464];}
-(void)禁阁密室 {[self 原地传送:7165861925323499854 :1702259048 :1729382256910270464];}
-(void)禁阁四层 {[self 原地传送:55475549202766 :0 :1729382256910270464];}
-(void)禁阁终点 {[self 原地传送:7236798017501096270 :0 :1729382256910270464];}
-(void)王子季节 {[self 原地传送:8315127553767991630 :7631461 :1729382256910270464];}
-(void)王子罐子 {[self 原地传送:7010520723528051022 :435777782642 :1729382256910270464];}
-(void)办公室图 {[self 原地传送:7163369271911991124 :101 :1729382256910270464];}

//暴风
-(void)暴风门口 {[self 原地传送:7022329448513893459 :29810 :1729382256910270464];}
-(void)暴风二图 {[self 原地传送:470071342163 :0 :1729382256910270464];}
-(void)伊甸献祭 {[self 原地传送:7236797987604624467 :0 :1729382256910270464];}
-(void)重生城堡 {[self 原地传送:7235399438727017039 :0 :1729382256910270464];}
-(void)重生二图 {[self 原地传送:7236798017517548111 :110424773452641 :1729382256910270464];}
-(void)星光大道 {[self 原地传送:8093924471530742083 :110424773452641 :1729382256910270464];}
-(void)重生动画 {[self 原地传送:32497618326483523 :0 :1729382256910270464];}


//其他
-(void)万圣新图 {[self 原地传送:7008831873768322629 :7166187213226472313 :1717922152];}
-(void)星球 {[self 原地传送:8315127553767991630 :7953757509367657061 :1729382256917836901];}
-(void)超级玛丽 {[self 原地传送:8026661817905211726 :6009328456400192351 :1729382258611282288];}

-(void)遇境{[self 原地传送:8093924471530742083 :6644577 :1729382256910270464];}
-(void)伊甸{[self 原地传送:7236797987604624467 :0 :1729382256910270464];}
-(void)星河{[self 原地传送:8093924471530742083 :110424773452641 :1729382256910270464];}
-(void)晨岛{[self 原地传送:1853317444 :0 :1729382256910270464];}
-(void)重生门{[self 原地传送:32497618326483523 :0 :1729382256910270464];}




#pragma mark -实用功能


-(void)nengliang{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long nl =(_baseAddres1 + 1390444);
    float modify = 15;
    engine.JRWriteMemory((unsigned long long)(nl),&modify,JR_Search_Type_Float);
    
}


-(void)fangjubao{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long dj =(_baseAddres1+1390444);
    float modify = -1000;
    engine.JRWriteMemory((unsigned long long)(dj),&modify,JR_Search_Type_Float);}

-(void)kuiping{
    
    
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    for (int i=0 ;i<=33 ;i++){
        long 自燃 =(_baseAddres2+32526164+828*i);
        SInt32 修改为 = 1077936128;
        engine.JRWriteMemory((unsigned long long)(自燃),&修改为,JR_Search_Type_SInt);
        
    }
    
    JRMemoryEngine engine1 = JRMemoryEngine(mach_task_self());
    long dj =(_baseAddres2+32566016);
    SInt32 modify = 1077936128;
    engine.JRWriteMemory((unsigned long long)(dj),&modify,JR_Search_Type_SInt);}



-(void)speed{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long num =6367068;
    long 加速倍数0 =(_baseAddres2-num),  //8月更新前6177312 后
    加速锁定1 =(_baseAddres2-num+4),
    加速锁定2 =(_baseAddres2-num+8),
    加速锁定3 =(_baseAddres2-num+12);
    float 加速锁值 = 1e+15;
    float 加速倍速 =speed_size;
    engine.JRWriteMemory((unsigned long long)(加速倍数0),&加速倍速,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(加速锁定1),&加速锁值,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(加速锁定2),&加速锁值,JR_Search_Type_Float);
    engine.JRWriteMemory((unsigned long long)(加速锁定3),&加速锁值,JR_Search_Type_Float);
    
}

-(void)chibang{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 金人偏移 =(_baseAddres1+1242240);
    uint32_t 金人数 = chibang_num;
    engine.JRWriteMemory((unsigned long long)(金人偏移),&金人数,JR_Search_Type_Float);}


-(void)ziranzhahua{//球球新增
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    for (int i=0 ;i<=600 ;i++){
        long 自燃 =(_baseAddres2+21501440+448*i);
        float 修改为 = 1;
        engine.JRWriteMemory((unsigned long long)(自燃),&修改为,JR_Search_Type_Float);}
    JRMemoryEngine engine1 = JRMemoryEngine(mach_task_self());
    for (int i=0 ;i<=480 ;i++){
        long 炸花 =(_baseAddres2+34985348+8*i);
        uint32_t 修改为 = 1006699012;
        engine.JRWriteMemory((unsigned long long)(炸花),&修改为,JR_Search_Type_ULong);}
}

-(void)youlingmoshi{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long rxh =(_baseAddres2+1865632);
    uint32_t modify = 2;
    engine.JRWriteMemory((unsigned long long)(rxh),&modify,JR_Search_Type_ULong);
}

-(void)wuxianyanhua{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long q1 =(_baseAddres1+1351736);       //1350584
    uint32_t modify = 5;
    engine.JRWriteMemory((unsigned long long)(q1),&modify,JR_Search_Type_Float);}

-(void)qianshouxiaohei{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long nl =(_baseAddres2-13484);
    uint32_t modify = 0;
    engine.JRWriteMemory((unsigned long long)(nl),&modify,JR_Search_Type_UInt);
    
}

-(void)yijianxianzu{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    UInt32 x = 250;
    long addres=(_baseAddres1+909384);
    long addres2=(_baseAddres1+900312);
    engine.JRWriteMemory((unsigned long long)addres,&x,JR_Search_Type_SInt);
    for (int x = 0; x < 43; x++){
        engine.JRWriteMemory((unsigned long long)addres2+(x*48),&先祖[x],JR_Search_Type_SLong);
    }
}

-(void)quchufengqiang{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    for (int i=0 ;i<=57 ;i++){
        long nl =(_baseAddres2+12015604+256*i);//1338656
        float modify = 0;
        engine.JRWriteMemory((unsigned long long)(nl),&modify,JR_Search_Type_Float);
    }
}
-(void)qixiaohei{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 骑小黑偏移 =(_baseAddres1+1366800);
    uint32_t num = xiaohei_size;
    
    engine.JRWriteMemory((unsigned long long)(骑小黑偏移),&num,JR_Search_Type_UInt);}


-(void)banaidajiao{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long 大叫0 =(_baseAddres1+1438680+40);
    SInt32 大叫 = 0;
    engine.JRWriteMemory((unsigned long long)(大叫0),&大叫,JR_Search_Type_SInt);
}


-(void)开全图{
    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
    long rxh =(_baseAddres1-591856);
    uint32_t modify = -2027781754;
    engine.JRWriteMemory((unsigned long long)(rxh),&modify,JR_Search_Type_ULong);
}

-(void)日常任务

{
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        for (int x = 0; x < 289; x++) {
            float modify = abs(int (*(float*)((unsigned long long)(self->_baseAddres2)+(x*8+105720))))+60;
            engine.JRWriteMemory((unsigned long long)(self->_baseAddres2)+(x*8+105720),&modify,JR_Search_Type_Float);
        }
        for (int x = 1; x < 290; x++) {
            engine.JRWriteMemory((unsigned long long)(self->_baseAddres2)+(105720+2304+(x-1)*4),&x,JR_Search_Type_Float);
        }
    });
}

-(void) 任务清零 {
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        for (int x = 0; x < 289; x++) {
            float modify = 0;
            engine.JRWriteMemory((unsigned long long)(self->_baseAddres2)+(x*8+105720),&modify,JR_Search_Type_Float);
        }
    });
}




#pragma mark -跑图坐标
static Float32 加速;

-(void)一键献祭II {
    加速 = 15;
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        UInt32 num2 = 2;
        float num1 = 1;
        engine.JRWriteMemory((unsigned long long)self->_baseAddres2-6367068,&加速,JR_Search_Type_Float);
        engine.JRWriteMemory((unsigned long long)self->_baseAddres2+26954800,&num2,JR_Search_Type_SInt);
        engine.JRWriteMemory((unsigned long long)self->_baseAddres2-6367068+4,&num1,JR_Search_Type_Float);
        engine.JRWriteMemory((unsigned long long)self->_baseAddres2-6367068+4+4,&num1,JR_Search_Type_Float);
        engine.JRWriteMemory((unsigned long long)self->_baseAddres2-6367068+4+4+4,&num1,JR_Search_Type_Float);
    }];
}

-(void)一键献祭 {
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [self 伊甸献祭];
        [NSThread sleepForTimeInterval:10];
    });
    dispatch_async(queue, ^{
        [self 星光大道];
        [NSThread sleepForTimeInterval:15];
    });
    dispatch_async(queue, ^{
        [self 星球];
        [NSThread sleepForTimeInterval:4];
    });
    
    dispatch_async(queue, ^{
        [self 遇境];
    });
    
    dispatch_async(queue, ^{
        加速 = 1;
    });
}
//先祖
static long 先祖[42] = {
    414084241,3666569351,4249009249,1466879858,64338276,2540775602,1568825369,2851084244,3063270590,1060667581,3881128326,4182042971,419578801,1156673674,2381086145,1464190897,3576552037,3930381583,1728053750,3307167098,1942389483,3809307521,2395108553,2859830090,416637648,3768849824,3630339793,2886532097,4155738138,1999438929,1060292445,2159324587,2797886853,2041153668,2017461200,3576140497,3594096657,2301512864,3431578562,2912184286,3688883494,1394749743
};





@end


