//
//  UIImage+LB.m
//  TBR
//
//  Created by andrei tchijov on 12/31/10.
//  Copyright 2010 Leaping Bytes, LLC. All rights reserved.
//

#import "UIImage+LB.h"


@implementation UIImage(LB)

-(UIImage*) imageWithColor: (UIColor*) color {
	CGImageRef 	cgSelf = self.CGImage;
	
	int			pixelsWide = self.size.width;
	int			pixelsHeight = self.size.height;
	
	void* 		bitmapData;
	int			bitmapByteCount;
	int 		bitmapBytesPerRow;
	
	bitmapBytesPerRow = CGImageGetBytesPerRow( cgSelf );
	bitmapByteCount = bitmapBytesPerRow * pixelsHeight;
	
	bitmapData = malloc( bitmapByteCount );
	
	CGContextRef bitmapContext = CGBitmapContextCreate(
		bitmapData,
		pixelsWide,	pixelsHeight,
		CGImageGetBitsPerComponent( cgSelf ), 
		bitmapBytesPerRow,
		CGImageGetColorSpace( cgSelf ),
		kCGImageAlphaPremultipliedLast
	);
	
	CGContextClearRect( bitmapContext, CGRectMake( 0, 0, pixelsWide, pixelsHeight ));
	CGContextSetFillColorWithColor( bitmapContext, color.CGColor );
	CGContextFillRect(bitmapContext,  CGRectMake( 0, 0, pixelsWide, pixelsHeight ));
	CGContextSetBlendMode( bitmapContext, kCGBlendModeDestinationIn );
	CGContextDrawImage( bitmapContext, CGRectMake( 0, 0, pixelsWide, pixelsHeight ), cgSelf );
	
	CGImageRef cgColored = CGBitmapContextCreateImage( bitmapContext );
	
	CGContextRelease( bitmapContext );
	
	return [ UIImage imageWithCGImage: cgColored ];
}

@end
