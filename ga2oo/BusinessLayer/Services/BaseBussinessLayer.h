//
//  BaseBussinessLayer.h
//  Enki
//
//  Created by Prashanth on 21/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseBusinessObject.h"
#import "DataAccessLayer.h"

@interface BaseBussinessLayer : NSObject 
{
    
}

-(BOOL)Insert:(BaseBusinessObject*)BaseBusinessObj withSave:(BOOL)Save;
-(BOOL)Update:(BaseBusinessObject*)BaseBusinessObj withSave:(BOOL)Save;
-(NSMutableArray*)SelectAll;
-(BaseBusinessObject*)SelectByKey:(NSString*)Key withMode:(BOOL)ModeString;
-(NSMutableArray*)FilerDataUsing:(NSString*)strPredicate;
//-(BOOL)DeleteByKey:(NSString*)Key;
-(BOOL)Save;
-(void)deleteAll;
-(void)InsertArray:(NSMutableArray*)arrData;
- (NSString *)flattenHTML:(NSString *)html;

@end



