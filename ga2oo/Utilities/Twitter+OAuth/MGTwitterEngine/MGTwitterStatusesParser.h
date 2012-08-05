//
//  MGTwitterStatusesParser.h
//  MGTwitterEngine
//
//  Created by Matt Gemmell on 11/02/2008.
//  Copyright 2008 Instinctive Code.
//

#import "MGTwitterEngineGlobalHeader.h"

#import "MGTwitterXMLParser.h"

#import <Foundation/Foundation.h>

@protocol NSXMLParserDelegate;

@interface MGTwitterStatusesParser : MGTwitterXMLParser <NSXMLParserDelegate>{

}

@end
