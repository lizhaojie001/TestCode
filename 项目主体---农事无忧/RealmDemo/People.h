//
//  People.h
//  RealmDemo
//
//  Created by Mac on 16/11/24.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import <Realm/Realm.h>



@class Person;

// Dog model
@interface Dog : RLMObject
@property NSString *name;
@property Person   *owner;
@end
RLM_ARRAY_TYPE(Dog) // define RLMArray<Dog>

// Person model
@interface Person : RLMObject
@property NSString             *name;
@property NSDate               *birthdate;
@property RLMArray<Dog *><Dog> *dogs;
@end
RLM_ARRAY_TYPE(Person) // define RLMArray<Person>

// Implementations
@implementation Dog
@end // none needed

@implementation Person
@end // none needed
