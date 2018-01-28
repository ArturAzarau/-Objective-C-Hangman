//
//  main.m
//  [Objective-C] Hangman
//
//  Created by Артур Азаров on 28.01.2018.
//  Copyright © 2018 Артур Азаров. All rights reserved.
//

#import <Foundation/Foundation.h>

void printWord(NSString *word, NSMutableArray<NSString*> *usedLetters) {
    printf("\nWord: ");
    
    // this will be used to track missing letters
    BOOL missingLetters = NO;
    
    // loop over every letter
    for (NSInteger i = 0; i < [word length]; ++i) {
        // convert the unichar into NSString for arrays
        unichar letter = [word characterAtIndex:i];
        NSString *letterString = [NSString stringWithFormat:@"%C", letter];
        
        // if we already guessed this letter, print it out
        if ([usedLetters containsObject:letterString]) {
            printf("%C",letter);
        } else {
            // letter not guessed; mark with a placeholder
            printf("_");
            
            // we haven't won yet
            missingLetters = YES;
        }
    }
    printf("\nGuesses: %ld/8\n", [usedLetters count]);
    if (missingLetters == NO) {
        printf("You won!\n");
        exit(0);
    } else {
        if ([usedLetters count] == 8) {
            printf("Oops - you died! The word was %s.\n", [word cStringUsingEncoding:NSUTF8StringEncoding]);
            exit(0);
        } else {
            printf("Enter a guess: ");
        }
    }
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *word = @"RHYTHM";
        NSMutableArray<NSString*> *usedLetters = [NSMutableArray arrayWithCapacity:8];
        printf("Welcome to Hangman!\n");
        printf("Press a letter to guess, or Ctrl+C to quit\n");
        while (1) {
            // read a string from user
            char cstring[256];
            scanf("%s", cstring);
            
            // convert to NSString
            NSString *input = [NSString stringWithCString:cstring encoding:NSUTF8StringEncoding];
            if ([input length] != 1) {
                printf("Please type exactly one letter, or Ctrl + C to quit.");
            } else {
                // pull out the first letter from the input
                unichar letter = [input characterAtIndex:0];
                
                // convert to an uppercase NSString
                NSString *letterString = [[NSString stringWithFormat:@"%C",letter] uppercaseString];
                if ([usedLetters containsObject:letterString]) {
                    printf("You used that letter already!\n");
                } else {
                    [usedLetters addObject:letterString];
                }
                
            }
            
            // no matter what, print the game state again
            printWord(word, usedLetters);
            
            
        }
        
    }
    return 0;
}
