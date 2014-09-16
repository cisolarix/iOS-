//
//  ViewController.m
//  通讯录
//
//  Created by Yanming Deng on 9/16/14.
//  Copyright (c) 2014 Yanming Deng. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestAddressBook];
}

- (void)requestAddressBook {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        
        if (granted) {
            NSLog(@"允许访问");
            [self readAddressBook];
        } else {
            NSLog(@"不允许访问");
        }
    });
    
    
}

- (void)readAddressBook {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex count = CFArrayGetCount(allPeople);
    for (CFIndex i=0; i<count; i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        
        NSLog(@"%@, %@", firstName, lastName);
        CFRelease(firstName);
        CFRelease(lastName);
        CFRelease(person);
    }
    CFRelease(addressBook);
    CFRelease(allPeople);
}

@end
