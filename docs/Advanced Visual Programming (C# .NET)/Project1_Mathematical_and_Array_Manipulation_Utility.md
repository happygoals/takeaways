---
layout: default
title: Mathematical and Array Manipulation Utility
parent: Advanced Visual Programming (C# .NET)
permalink: /csharp/project1

nav_order: 3
---

# Project #1 Mathematical and Array Manipulation Utility
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
* Project Name: Project #1 - Mathematical and Array Manipulation Utility
* [Project Description](../../assets/files/012120_Csharp_Project1_Mathematical_and_Array_Manipulation_Utility.pdf)
* Start Date: 01/21/2020
* Last Modified Date: 01/23/2020
* Future Work : Calculation functions can be simple by removing duplication. 
If we make a function include operator as a parameter, it will make less duplication code.  

* File Name: MathFunctions.cs

## Method 1: public string Add(string input1, string input2) <-- Basic way 
```ruby
        public string Add(string input1, string input2)
        {
            var val1 = 0M; // 0m is how you say (decimal)0 because m is the suffix that means decimal.
            var val2 = 0M;
            if (decimal.TryParse(input1, out val1) && decimal.TryParse(input2, out val2))
                return (val1 + val2).ToString();
        }
```
## Method 2: public string Multiply(string input1, string input2) <-- Using MathematicalOperation Method 
```ruby
        public string Multiply(string input1, string input2)
        {
            var val1, val2 = 0M; 
            return MathematicalOperation(input1, input2, (val1, val2)=> 
            {
                return (val1*val2).ToString(); 
            }); 
        }
```
## Method 3: public string Subtract(string input1, string input2) <-- Using Add Method
```ruby
        public string Subtract(string input1, string input2)
        {
            var val1, val2 = 0M; 
            
            // Extract '-' character and remove it. 
            return Add(input1, string.IsNullOrWhiteSpace(input2)?input 2: (input2.Trim().StartsWith)"-")? 
                   input2.Trim().Trim('-'): 
                   ("-" + input2.trim()))); 
        }

```

## Method 4: public string Divide(string input1, string input2) <-- Consider the case 'DividByZero' 
```ruby
        public string Divide(string input1, string input2)
        {
            var val1, val2 = 0M; 
            
            if (val2 == 0)
                 return ErrorMessage; 
            return(val1/val2).ToString();   // Else. If (val2 != 0).
        }
```

## Method 5: public string Power(string input1, string input2)
```ruby
        public string Power(string input1, string input2)
        {
            var val1, val2 = 0M; 
            
            return MathematicalOperation(input1, input2, (val1, val2)=> 
            {
                if(val == 0 && val2 >= 0) // ZeroRasiedtoANonZeroPower
                    return "0"; 
                // Pow method is used to calculate a number raise to the power of some other number and it is a double-precision floating-point number. The parameters in the Pow method should be double base. 
                return Math.Pow(val1, val2).ToString();   // Else. If (val != 0 || val2 < 0).
            }); 
        }
```
 
 * File Name: ArrayFunctions.cs
 ## Method 6: public ArrayFunctions(string persistentFile, int? seed)
```ruby
        public ArrayFunctions(string persistentFile, int? seed)
        {
            this.PersistentFile = persistentFile;     // PersistentFile Parameter and the persistent file are equal. 

            string directory = System.IO.Path.GetFullPath(PersistentFile);
            directory = System.IO.Path.GetDirectoryName(directory);

            if (seed.HasValue)
            {
                    Randomizer = new Random(seed.Value);
            }
            else if (string.IsNullOrWhiteSpace(persistentFile))      // EmptyOrWhitespacePersistentFilenamethrowsException
            {
                throw new System.ArgumentException("PersistentFile cannot be null", "persistentFile");          //  NullPersistentFileThrowsException
            }
            else if (persistentFile == null)
            {
                throw new ArgumentNullException("Argument is null.");
            }
            // ** Issue. Need to figure out how to get the result of PersistentFilePointsToNonExistentDirectory
            else if (!Directory.Exists(directory))
            {
                throw new DirectoryNotFoundException("The data file was not found.");            //FileDoesNotExist
            }
        }
```

```ruby
            string directory = System.IO.Path.GetFullPath(PersistentFile);
            directory = System.IO.Path.GetDirectoryName(directory);
```


