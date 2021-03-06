// The MIT License (MIT)
//
// Copyright (c) 2013 Michael May
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ATTIInfoPlistToVersionString.h"

const NSString *CFBundleShortVersionStringKey = @"CFBundleShortVersionString";
const NSString *CFBundleVersionKey = @"CFBundleVersion";

NSString *versionStringFromAppVersionBuildNumber(NSString *appVersion, NSString* buildNumber);
NSString* versionStringFromDictionary(NSDictionary *infoPlistDictionary);

BOOL stringIsAPlistPath(NSString* plistPath)
{
    NSString *lastPathComponent = [plistPath lastPathComponent];
    
    return [lastPathComponent hasSuffix:@".plist"];
}

NSString *versionStringFromAppVersionBuildNumber(NSString *appVersion, NSString* buildNumber)
{
    NSString *versionString = nil;

    if(appVersion) {
        versionString = appVersion;
    }
    
    if(buildNumber) {
        if(versionString == nil) {
            versionString = [NSString stringWithFormat:@"(%@)", buildNumber];
        } else {
            versionString = [versionString stringByAppendingFormat:@" (%@)", buildNumber];
        }
    }
    
    return versionString;
}

NSString* versionStringFromDictionary(NSDictionary *infoPlistDictionary)
{
    if(infoPlistDictionary) {
        NSString *appVersion = [infoPlistDictionary objectForKey:CFBundleShortVersionStringKey];
        NSString *buildNumber = [infoPlistDictionary objectForKey:CFBundleVersionKey];
        
        return versionStringFromAppVersionBuildNumber(appVersion, buildNumber);
    }
    
    return nil;
}

NSString* versionStringFromInfoPlistFilename(NSString* infoPlistFilename)
{
    NSDictionary *plistFileAsDictionary = [[NSDictionary alloc] initWithContentsOfFile:infoPlistFilename];

    if(plistFileAsDictionary) {
        return versionStringFromDictionary(plistFileAsDictionary);
    }
    
    return nil;
}
