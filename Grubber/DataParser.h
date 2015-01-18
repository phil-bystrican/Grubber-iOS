//
//  DataParser.h
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataParser : NSObject

-(void) fetchJson;

-(NSMutableArray *) parseJson;

@end
