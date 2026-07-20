#import <UIKit/UIKit.h>
#import <substrate.h>
#import <vector>
#import <cmath>

// ==================== CLASS HEADERS ====================
@interface LocalPlayer : NSObject
- (void)tick;
- (float)getHunger;
- (void)startUsingItem;
- (void)attack:(id)entity;
- (void)swing;
- (void*)getLevel;
- (float)getFallDistance;
- (void)setMotionY:(float)y;
@end

@interface Player : NSObject
- (void)normalTick;
- (void)moveRelative:(float)strafe forward:(float)yaw;
- (void)moveFlying;
@end

@interface Mob : NSObject
- (float)getSpeed;
- (float)getHealth;
@end

@interface LevelRenderer : NSObject
- (void)renderLevel:(void*)context;
- (void)renderEntities:(id)camera;
- (void*)getLevel;
@end

@interface BlockEntity : NSObject
- (int)getBlockType;
- (id)getPos;
@end

@interface GameRenderer : NSObject
- (void)render:(float)partialTicks;
@end

@interface Level : NSObject
- (NSArray*)getEntities;
- (NSArray*)getBlockEntityList;
@end

// ==================== FLOATING BUTTON ====================
@interface DDFloatingButton : UIButton
@property (nonatomic) CGPoint startLocation;
@property (nonatomic, copy) void(^onTap)(void);
@end

@implementation DDFloatingButton
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.9];
        self.layer.cornerRadius = frame.size.width / 2;
        self.clipsToBounds = YES;
        [self setTitle:@"DD" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18 weight:UIFontWeightBold];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowRadius = 8;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self.superview];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.startLocation = location;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint difference = CGPointMake(location.x - self.startLocation.x, location.y - self.startLocation.y);
        self.center = CGPointMake(self.center.x + difference.x, self.center.y + difference.y);
        self.startLocation = location;
    }
}
@end

// ==================== MAIN GUI WINDOW ====================
@interface DDMainWindow : UIView
@property (nonatomic, strong) UIView *sidebarView;
@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic) BOOL isVisible;
@property (nonatomic, strong) NSMutableArray *modulesToggles;
@end

@implementation DDMainWindow
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:0.95];
        self.layer.cornerRadius = 12;
        self.clipsToBounds = YES;
        self.modulesToggles = [NSMutableArray array];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.8;
        self.layer.shadowRadius = 12;
        self.layer.shadowOffset = CGSizeMake(0, 8);
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.6].CGColor;
        
        [self setupSidebar];
        [self setupContentArea];
    }
    return self;
}

- (void)setupSidebar {
    self.sidebarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, self.bounds.size.height)];
    self.sidebarView.backgroundColor = [UIColor colorWithRed:0.03 green:0.03 blue:0.03 alpha:1.0];
    self.sidebarView.layer.borderRightWidth = 2;
    self.sidebarView.layer.borderRightColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.4].CGColor;
    
    NSArray *categories = @[@"Combat", @"Movement", @"Visuals", @"Player"];
    for (int i = 0; i < categories.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(5, 10 + (i * 65), 80, 60);
        [btn setTitle:categories[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
        [btn setTitleColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.0];
        btn.layer.cornerRadius = 8;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3].CGColor;
        btn.tag = i;
        [btn addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchUpInside];
        [self.sidebarView addSubview:btn];
    }
    
    [self addSubview:self.sidebarView];
}

- (void)setupContentArea {
    self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(95, 10, self.bounds.size.width - 105, self.bounds.size.height - 20)];
    self.contentScroll.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentScroll];
}

- (void)switchCategory:(UIButton *)btn {
    [self.contentScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat yPos = 10;
    if (btn.tag == 0) {
        [self addModuleToggle:@"KillAura" y:&yPos];
        [self addModuleToggle:@"Aimbot" y:&yPos];
        [self addModuleToggle:@"Velocity" y:&yPos];
        [self addModuleToggle:@"Anti-Knockback" y:&yPos];
        [self addModuleToggle:@"Criticals" y:&yPos];
    } else if (btn.tag == 1) {
        [self addModuleToggle:@"Flight" y:&yPos];
        [self addModuleToggle:@"Speed" y:&yPos];
        [self addModuleToggle:@"BunnyHop" y:&yPos];
        [self addModuleToggle:@"Spider" y:&yPos];
        [self addModuleToggle:@"Water Walk" y:&yPos];
    } else if (btn.tag == 2) {
        [self addModuleToggle:@"Player ESP" y:&yPos];
        [self addModuleToggle:@"Spawner Tracers" y:&yPos];
        [self addModuleToggle:@"Chest Tracers" y:&yPos];
        [self addModuleToggle:@"Piston Tracers" y:&yPos];
        [self addModuleToggle:@"XRay" y:&yPos];
        [self addModuleToggle:@"FullBright" y:&yPos];
    } else if (btn.tag == 3) {
        [self addModuleToggle:@"Auto-Eat" y:&yPos];
        [self addModuleToggle:@"Auto-Totem" y:&yPos];
        [self addModuleToggle:@"FastPlace" y:&yPos];
        [self addModuleToggle:@"InstaBreak" y:&yPos];
        [self addModuleToggle:@"Scaffold" y:&yPos];
    }
    
    self.contentScroll.contentSize = CGSizeMake(self.contentScroll.frame.size.width, yPos + 20);
}

- (void)addModuleToggle:(NSString *)moduleName y:(CGFloat *)yPos {
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(5, *yPos, self.contentScroll.frame.size.width - 15, 40)];
    container.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:0.8];
    container.layer.cornerRadius = 6;
    container.layer.borderWidth = 1;
    container.layer.borderColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2].CGColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 150, 24)];
    label.text = moduleName;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
    [container addSubview:label];
    
    UISwitch *toggle = [[UISwitch alloc] initWithFrame:CGRectMake(container.frame.size.width - 55, 6, 50, 28)];
    toggle.onTintColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.8];
    toggle.transform = CGAffineTransformMakeScale(0.85, 0.85);
    [container addSubview:toggle];
    
    [self.contentScroll addSubview:container];
    [self.modulesToggles addObject:@{@"name": moduleName, @"toggle": toggle}];
    
    *yPos += 50;
}

- (void)toggleVisibility {
    self.isVisible = !self.isVisible;
    self.alpha = self.isVisible ? 1.0 : 0.0;
    self.userInteractionEnabled = self.isVisible;
    
    if (self.isVisible) {
        [self switchCategory:[UIButton buttonWithType:UIButtonTypeCustom]];
    }
}
@end

// ==================== MODULE STATES ====================
static struct {
    bool killaura, aimbot, velocity, antiKnockback, criticals;
    bool flight, speed, bunnyHop, spider, waterWalk;
    bool playerESP, spawnerTracers, chestTracers, pistonTracers, xray, fullBright;
    bool autoEat, autoTotem, fastPlace, instaBreak;
} g_modules = {1};

void DDLog(const char *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithUTF8String:format] arguments:args];
    NSLog(@"[DarkDev] %@", msg);
    va_end(args);
}

// ==================== COMBAT HOOKS ====================
%hook LocalPlayer
- (void)tick {
    %orig;
    if (g_modules.killaura) DDLog("KillAura: Active");
    if (g_modules.autoEat && [self getHunger] < 10) [self startUsingItem];
}
- (void)jump {
    if (g_modules.criticals && [self getFallDistance] == 0.0f) [self setMotionY:0.42f];
    %orig;
}
%end

%hook GameRenderer
- (void)render:(float)partialTicks {
    %orig;
    if (g_modules.aimbot) DDLog("Aimbot: Targeting");
}
%end

// ==================== MOVEMENT HOOKS ====================
%hook Player
- (void)normalTick {
    %orig;
    if (g_modules.flight) {
        uintptr_t abilities = *(uintptr_t*)((uintptr_t)self + 0x930);
        *(bool*)(abilities + 0x10) = true;
    }
}
- (void)moveRelative:(float)strafe forward:(float)yaw {
    if (g_modules.speed) { strafe *= 2.8f; yaw *= 2.8f; }
    %orig;
}
%end

%hook Mob
- (float)getSpeed {
    if (g_modules.speed) return %orig * 2.5f;
    return %orig;
}
%end

// ==================== VISUAL HOOKS ====================
%hook LevelRenderer
- (void)renderLevel:(void*)context {
    %orig;
    if (g_modules.playerESP) DDLog("ESP: Rendering");
    if (g_modules.xray) DDLog("XRay: Active");
}
%end

// ==================== INITIALIZATION ====================
static DDFloatingButton *g_floatingBtn;
static DDMainWindow *g_mainWindow;

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if ([UIApplication sharedApplication].windows.count > 0) {
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        }
        
        if (window) {
            g_floatingBtn = [[DDFloatingButton alloc] initWithFrame:CGRectMake(20, 120, 65, 65)];
            [window addSubview:g_floatingBtn];
            
            g_mainWindow = [[DDMainWindow alloc] initWithFrame:CGRectMake(20, 200, 350, 550)];
            g_mainWindow.alpha = 0.0;
            g_mainWindow.userInteractionEnabled = NO;
            [window addSubview:g_mainWindow];
            
            [g_floatingBtn addTarget:^{ [g_mainWindow toggleVisibility]; } forControlEvents:UIControlEventTouchUpInside];
            
            DDLog("=== DarkDev v3.0 ===");
            DDLog("Status: ONLINE");
            DDLog("Modules: 20+");
        }
    });
}
