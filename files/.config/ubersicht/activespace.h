//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#ifndef ActiveSpaceBridge_h
#define ActiveSpaceBridge_h

#import <Foundation/Foundation.h>

int _CGSDefaultConnection();
id CGSCopyManagedDisplaySpaces(int conn);

#endif
