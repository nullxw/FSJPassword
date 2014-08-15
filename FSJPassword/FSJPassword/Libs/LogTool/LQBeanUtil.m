//
//  LQBeanUtil.m
//  LQLongQi
//
//  Created by 琥珀先知 on 13-10-11.
//  Copyright (c) 2013年 琥珀先知. All rights reserved.
//

#import "LQBeanUtil.h"
#import <objc/runtime.h>
#import "LQKeyValuePair.h"

@implementation LQBeanUtil
+ (id)getPropertyList:(id)obj {
    NSMutableArray *propertyList = [[[NSMutableArray alloc] init] autorelease];
    id clazzOfObj = objc_getClass(class_getName([obj class]));
    unsigned int numberOfProperties;
    objc_property_t *properties = class_copyPropertyList(clazzOfObj, &numberOfProperties);
    id valueRef;
//    long long v;
    NSInteger v;
    LQKeyValuePair *pair;
    for (int i = 0; i < numberOfProperties; i++) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        const char * atti = property_getAttributes(property);
        // 判断是否是简单数据类型
        if (! [[self class] isClassType:[NSString stringWithCString:atti encoding:NSUTF8StringEncoding]]) {
            // 简单数据类型
            object_getInstanceVariable(obj, property_getName(property), (void *)&v);
            pair = [[LQKeyValuePair alloc] initWithKey:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]
                                                  value:[NSNumber numberWithInteger:v]];
        } else {
            // class数据类型
            object_getInstanceVariable(obj, property_getName(property), (void *)&valueRef);
            pair = [[LQKeyValuePair alloc] initWithKey:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]
                                                  value:valueRef];
        }
        [propertyList addObject:pair];
        [pair release];
    }
    return propertyList;
}

+ (BOOL)isClassType:(NSString *)propDesc {
    return [propDesc rangeOfString:@"T@"].location != NSNotFound;
}

// 获取成员变量的类型
//static const char *getPropertyType(objc_property_t property) {
//    const char *attributes = property_getAttributes(property);
//    //printf("attributes=%s\n", attributes);
//    char buffer[1 + strlen(attributes)];
//    strcpy(buffer, attributes);
//    char *state = buffer, *attribute;
//    while ((attribute = strsep(&state, ",")) != NULL) {
//        if (attribute[0] == 'T' && attribute[1] != '@') {
//            // it's a C primitive type:
//            /*
//             if you want a list of what will be returned for these primitives, search online for
//             "objective-c" "Property Attribute Description Examples"
//             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
//             */
//            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
//            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
//        }
//        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
//            // it's an ObjC id type:
//            return "id";
//        }
//        else if (attribute[0] == 'T' && attribute[1] == '@') {
//            // it's another ObjC object type:
//            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
//            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
//        }
//    }
//    return "";
//}
@end
