//
//  macros.h
//  MOIRefreshControlDemo
//
//  Created by mconintet on 10/20/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#ifndef macros_h
#define macros_h

#ifdef DEBUG
#define DLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLOG(...)
#endif

#define DLOG_CGRECT(tag, rect)                                                   \
    DLOG(@"[" #tag "] origin.x: %f origin.y: %f size.width: %f size.height: %f", \
        rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)

#define DLOG_CGPOINT(tag, point)            \
    DLOG(@"[" #tag "] point: %f point: %f", \
        point.x, point.y)

#define DLOG_UIEDGEINSETS(tag, edgeInsets)                    \
    DLOG(@"[" #tag "] top: %f left: %f bottom: %f right: %f", \
        edgeInsets.top, edgeInsets.left, edgeInsets.bottom, edgeInsets.right)

#define DLOG_CGSIZE(tag, size)               \
    DLOG(@"[" #tag "] width: %f height: %f", \
        size.width, size.height)

#endif /* macros_h */
