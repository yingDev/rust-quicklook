#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#import <Cocoa/Cocoa.h>

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
	CFBundleRef bundle = QLPreviewRequestGetGeneratorBundle(preview);
	NSURL* htmlUrl = (__bridge NSURL*) CFBundleCopyResourceURL(bundle, CFSTR("load.html"), NULL, NULL);

	NSString* html = [NSString stringWithContentsOfURL:htmlUrl encoding:NSUTF8StringEncoding error:nil];
	
	NSString *_content = [NSString stringWithContentsOfURL:(__bridge NSURL *)url encoding:NSUTF8StringEncoding error:nil];
	
	
 	NSString* finalHtml = [html stringByReplacingOccurrencesOfString:@"@@@{code}" withString:_content];
	
	QLPreviewRequestSetDataRepresentation(preview,(__bridge CFDataRef)[finalHtml dataUsingEncoding:NSUTF8StringEncoding],kUTTypeHTML,NULL);
	
	return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
