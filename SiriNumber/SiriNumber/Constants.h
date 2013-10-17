//
//  Constants.h
//  SiriNumber
//
//  Created by helen on 10/17/13.
//  Copyright (c) 2013 heleny. All rights reserved.
//

#define localize(key, default) NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], default, nil)

#pragma mark - Domain
#define kNumbersAPIUrl @"http://numbersapi.com/number/type"


#pragma mark - Strings
#define kTypeANumberLabel localize(@"type.a.number.label", @"Please type in a number")


#endif
