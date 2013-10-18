//
//  Constants.h
//  SiriNumber
//
//  Created by helen on 10/17/13.
//  Copyright (c) 2013 heleny. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - URL
#define kNumbersAPIUrl @"http://numbersapi.com/"


#pragma mark - String
#define kTypeANumberLabel localize(@"type.a.number.label", @"Please input a number")
