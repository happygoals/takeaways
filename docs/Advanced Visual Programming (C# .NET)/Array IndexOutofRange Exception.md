---
layout: default
title: Array IndexOutofRange Exception
parent: Advanced Visual Programming (C# .NET)
permalink: /csharp/IndexOutofRange
nav_order: 12
---

# Array IndexOutofRange Exception
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Array IndexOutofRange Exception
[Reference](https://www.geeksforgeeks.org/c-sharp-array-indexoutofrange-exception/)

* IndexOutOfRangeException = a Runtime Exception thrown only at runtime.
* The index of an array is an integer value that has value in the interval [0, n-1], where n is the size of the array. 
* If a request for a negative or an index greater than or equal to the size of the array is made, then the C# throws an System.IndexOutOfRange Exception..
 
 
## Example
```ruby
// C# program to demonstrate the  
// IndexOutofRange Exception in array 
using System; 
  
public class GFG { 
      
    // Main Method 
    public static void Main(String[] args) 
    { 
        int[] ar = {1, 2, 3, 4, 5}; 
          
        // causing exception 
        for (int i = 0; i <= ar.Length; i++) 
            Console.WriteLine(ar[i]); 
    } 
} 
```

## Error
```ruby
Unhandled Exception:
System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
```

## Interpretation 
* Index here defines the index we are trying to access.
* The size gives us information of the size of the list.
* Since size is 2, the last index we can access is (2-1)=1, and thus the exception.
* 'i <= ar.Length' should be changed to 'i < ar.Length'.

## Solution 
```ruby
using System; 
  
public class GFG { 
      
    // Main Method 
    public static void Main(String[] args) 
    { 
        int[] ar = {1, 2, 3, 4, 5}; 
          
        // No more causing exception 
        for (int i = 0; i < ar.Length; i++) 
            Console.WriteLine(ar[i]); 
    } 
} 
```



