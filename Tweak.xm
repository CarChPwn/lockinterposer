#import <liblockdown.h>
#import <Foundation/Foundation.h>
#import "substrate.h"
#import <MobileGestalt.h>
#import <Security/SecKey.h>

#define DEVICE_UDID "4a5a5fe4eebdb5a11c6d6a7fce4795e914769802"
#define IMEI "010113006310121"
#define MG_SERIAL "C40KFBXFFH23"

static CFPropertyListRef (*original_lockdown_copy_value)(LockdownConnectionRef connection, CFStringRef domain, CFStringRef key);

static CFPropertyListRef replaced_lockdown_copy_value(LockdownConnectionRef connection, CFStringRef domain, CFStringRef key){
        CFStringRef ActivationState = CFSTR("FactoryActivated");
        //CFStringRef DeviceUdid = CFSTR(DEVICE_UDID);
if(!CFStringCompare(key, CFSTR("ActivationState"), 0)){
            NSLog(@"This works!!");
            return ActivationState;
}
if(!CFStringCompare(key, CFSTR("BrickState"), 0)){
     NSLog(@"This works!!");
            return kCFBooleanFalse;
}

        return lockdown_copy_value(connection, domain, key);
}

%ctor{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSLog(@"Init for dylib interposer");
    MSHookFunction((void*)lockdown_copy_value,(void*)replaced_lockdown_copy_value,(void**)&original_lockdown_copy_value);
    [pool drain];

}