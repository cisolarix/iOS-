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
//            [self readAddressBook];
        } else {
            NSLog(@"不允许访问");
        }
    });
    
    
}
- (IBAction)readAllPeople:(id)sender {
//    [self accessAllPeopleWithC];
    [self accessAllPeopleWithOC];
}

- (void)accessAllPeopleWithC {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex count = CFArrayGetCount(allPeople);
    for (CFIndex i=0; i<count; i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        CFArrayRef phoneArray = ABMultiValueCopyArrayOfAllValues(phone);
        CFIndex phoneCount = CFArrayGetCount(phoneArray);
        for (CFIndex j=0; j<phoneCount; j++) {
            CFStringRef phoneStr = CFArrayGetValueAtIndex(phoneArray, j);
            NSLog(@"phone %li: %@", j, phoneStr);
        }
        
        NSLog(@"%@, %@", firstName, lastName);
        CFRelease(firstName);
        CFRelease(lastName);
        CFRelease(person);
    }
    CFRelease(addressBook);
    //    CFRelease(allPeople);
}

- (void)accessAllPeopleWithOC {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSArray *allPeople = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
    int count =  allPeople.count;
    for (int i=0; i<count; i++) {
        ABRecordRef person = (__bridge ABRecordRef)(allPeople[i]);
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        NSArray *phoneArray = (__bridge NSArray *)(ABMultiValueCopyArrayOfAllValues(phone));
        int phoneCount = phoneArray.count;
        for (int j=0; j<phoneCount; j++) {
            NSString *phoneStr = phoneArray[j];
            NSLog(@"phone %i: %@", j, phoneStr);
        }
        
        NSLog(@"%@, %@", firstName, lastName);
        CFRelease(person);
    }
    CFRelease(addressBook);
    //    CFRelease(allPeople);
}


@end
