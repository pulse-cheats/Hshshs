#import <UIKit/UIKit.h>
#import <substrate.h>
#import <vector>

// --- STRUCTURES & MATH ---
struct Vec3 { float x, y, z; };
struct Color { float r, g, b, a; };

// --- GLOBAL MODULE STATES ---
struct {
    bool killaura = true;
    bool fly = true;
    bool freecam = false;
    bool esp = true;
    bool tracers = true;
    bool speed = true;
    bool autocrystal = true;
    bool autoanchor = true;
    bool autototem = true;
    bool criticals = true;
    bool autoeat = true;
} darkDev;

// --- UTILS ---
void logClient(NSString *msg) {
    NSLog(@"[DarkDev] %@", msg);
}

// --- HOOKS ---

// 1. KillAura, 11. Criticals, 12. AutoEat
%hook LocalPlayer
- (void)tick {
    %orig;
    
    // AutoEat Logic
    if (darkDev.autoeat && [self getHunger] < 16) {
        [self startUsingItem];
    }
    
    // KillAura Logic
    if (darkDev.killaura) {
        void* level = [self getLevel];
        auto entities = [level getEntities];
        for (auto& entity : entities) {
            if (entity != self && [self distanceTo:entity] < 6.0f) {
                // Criticals: Μικρό άλμα πριν το χτύπημα
                if (darkDev.criticals && [self getFallDistance] == 0.0f) {
                    [self setMotionY:0.12f];
                }
                [self attack:entity];
                [self swing];
            }
        }
    }
}
%end

// 2. Fly & 7. Speed
%hook Player
- (void)normalTick {
    %orig;
    if (darkDev.fly) {
        // Force Abilities (Flying)
        uintptr_t abilities = *(uintptr_t*)((uintptr_t)self + 0x930); 
        *(bool*)(abilities + 0x10) = true; // mayFly
        *(bool*)(abilities + 0x11) = true; // isFlying
    }
}
%end

%hook Mob
- (float)getSpeed {
    if (darkDev.speed) return %orig * 2.8f; // Speed Boost
    return %orig;
}
%end

// 4. ESP, 5-6. Trace Lines (Spawners, Chests, Pistons)
%hook LevelRenderer
- (void)renderLevel:(void*)context {
    %orig;
    
    if (darkDev.tracers) {
        void* level = [self getLevel];
        auto blockEntities = [level getBlockEntityList];
        
        for (auto& tile : blockEntities) {
            int type = *(int*)((uintptr_t)tile + 0x20); // Block ID/Type
            
            // 5. Spawners (Πράσινο)
            if (type == 1) { 
                [self drawTraceLineTo:[tile getPos] color:[UIColor greenColor]];
            }
            // 6. Chests/Dispensers (Κίτρινο)
            if (type == 2 || type == 10) { 
                [self drawTraceLineTo:[tile getPos] color:[UIColor yellowColor]];
            }
            // 6. Pistons (Μωβ)
            if (type == 15) { 
                [self drawTraceLineTo:[tile getPos] color:[UIColor purpleColor]];
            }
        }
    }
}
%end

// 10. Auto Totem Logic
%hook InventoryTransactionManager
- (void)addAction:(void*)action {
    %orig;
    if (darkDev.autototem) {
        // Εδώ μπαίνει ο κώδικας που ελέγχει αν το Totem έσπασε
        // και το αντικαθιστά αυτόματα από το Inventory
    }
}
%end

// --- INITIALIZATION & WATERMARK ---
%ctor {
    logClient(@"Initializing DarkDev Client...");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // Simple Alert GUI
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"§0DarkDev §fClient" 
            message:@"§7Status: §aOnline\n§7Modules: §fCore 12 Loaded" 
            preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Launch" style:UIAlertActionStyleDefault handler:nil]];
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
        
        logClient(@"GUI Ready.");
    });
}
