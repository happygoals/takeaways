---
layout: default
title: Regular Expressions
parent: XML

nav_order: 6
---

# Chapter 3 - Regular Expressions

1) Basic Regex
| Regex        | Meaning                                                                 |
|:-------------|:------------------------------------------------------------------------|
| \d           | Digit. Find the number (Only one number of number character).           |
| \w           | Character. Find the character. Not special character but underscore(_). |
| +            |  Linked number. one or more than one.                                   |
| \d+          | 1 or linked more than one number digits.                                |

2) Quantifier 
| Regex                         | Meaning                                                                   |
|:------------------------------|:--------------------------------------------------------------------------|
| *                             | 0 or more.                                                                |
| [1-9]\d*                      | Natural numbers. [1]                                                      |
| ?                             |   Something can be there.                                                 |
| -?                            | '-' availability                                                          |
| [- ]?                         |  '-' or blank availability                                                |
| {number}                      | Repeat 'number' times. Digits. 2자리 수.                                   |
| {number1, number2}            | Repeat from 'number1' to 'number2'. Range of the number of numbers. n ~ m |
| \w{2,3}                       | There's 2 or 3 linked(continuous) characters.                             |
| \d+-?\d+-?\d+                 | Phone number (Without any blank) [2]                                      |
| \d+[- ]?\d+[- ]?\d+           | Phone number (Including 'with blank or not') [2]                          |
| \d{2,3}[- ]?\d{3,4}[- ]?\d{4} | Phone number with the digit limits [2] - 3)                               |

[1] How to find the natural number using Regex
 1) The first position of the natural number should not start from 0. It should be between 1 and 9. 
 2) Next position can have the number between 0 and 9. The number of the numbers should be more than 0. 

[2] How to find the phone number (e.g. 021234567, 02-123-4567)
 1) 3 - 4 Continuous numbers
 2) There's '-' between the 3 - 4 Continuous numbers or not. 
  c.f. If there are blanks on the phone number, we should use this condition: There's '-' or blank between the 3 - 4 Continuous numbers or not. 
  
 3) 자리 수 (Unit of digit) 
| 자리 수 unit of digit   | Regex                            |
|:-----------------------|:---------------------------------|
| 처음	2 ~ 3자리          | {2,3}                            |
| 가운데	3 ~ 4자리        | {3,4}                            |
| 마지막	4자리            | {4}                              | 

4) Select
| Regex    | Meaning                                                                |
|:---------|:-----------------------------------------------------------------------|
| [aeiou]  | Select one of Alphabets only from a,e,i,o,u. Vowels.                   |
| [a-z]    | Select all Alphabet lowercases. [abcdefghijklmnopqrlstuvwxyz]          |
| [a-z]+   | Select continuous Alphabet lowercases.                                 | 
| [가-힣]+  | Select continuous Korean lowercases. Words, not 'ㄱㄴㄷ' or 'ㅏㅑㅓㅕ'. | 

** [가-힣]+ : It should be the combination of the vowels and consonant.

5) Others
| Regex    | Meaning                                       |
|:---------|:----------------------------------------------|
| \s       | Space characters (Space, tab, New line)       |
| \S       | Except Space characters                       |
| \D       | Except number characters.                     | 
| \W       | Only special characters and space characters. | 

Reference: 
[Reference1](https://docs.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference)
[Reference2](https://regex101.com/)

