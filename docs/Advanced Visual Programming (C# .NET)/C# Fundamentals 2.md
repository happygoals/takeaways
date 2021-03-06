---
layout: default
title: C# Fundamentals 2
parent: Advanced Visual Programming (C# .NET)
permalink: /csharp/fundamentals2

nav_order: 2
---

# C# Fundamentals 2
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
# C# Array
## Array Declarations 

```ruby
// Declare a single-dimension array of 5 numbers. 
int[] numbers1 = new int[5]; 

// Declare a single-dimentsion array and set its 4 values. 
var numbers2 = new int[] { 1, 2, 4, 8 };
var oldNumbers = numbers2; 
numbers2 = new int[16]; 

// Change the size of an existing array to 16 elements and retain the current values. 
if (oldNumbers != null)
   Array.Copy(oldNumbers, numbers2, Math.Min(16, oldNumbers.Length)); 
   
// Redefine the size of an existing array and reset the values. 
numbers2 = new int[16]; 

// Declare a 6 x 6 multidimensional array. 
double[,] matrix1 = new double[6, 6]; 

// Declare a 4 x 3 multidimensional array and set array element values. 
var matrix2 = new int[4,3] { { 1, 2, 3 }, {2, 3, 4}, {3, 4, 5}, {4, 5, 6} }; 

// Declare a jagged array 
double[][] sales = new double[12][]; 
```

## Array with loop
```ruby
// Declare an array with 7 elements. 
int[] students = new int[7]; 

// Assign values to each element. 
students[0] = 23; // k
students[1] = 19; // 1st
students[2] = 21; // 2nd
students[3] = 17; // 3rd
students[4] = 19; // 4th
students[5] = 20; // 5th
students[6] = 22; // 6th

// Display the value of each element. 
for (int ctr = 0; ctr <= 6; ctr++) 
{
    // Do if checks on some sorts and it's followed by a question mark. 
    string grade = ctr == 0 ? "kindergarten" : $"grade {ctr}";      // After the question mark is the result of if it is true.
    Console.WriteLine($"Students in {grade}: {students[ctr]}"); 
}
```
# Comparison 
## Comparison Operator 

| Condition Tested                                                          |       Comparison Operator        |
|:--------------------------------------------------------------------------|:---------------------------------|
| Is the value on the left equal to the value on the right?                 |   == (equality)                  |
| Is the value on the left NOT equal to the value on the right?             |   != (inequality)                |
| Is the value on the left less than the value on the right?                |   < (less than)                  |
| Is the value on the left greater than the value on the right?             |   > (greater than)               |
| Is the value on the left less than or equal to the value on the right?    |   <= (less than or equal to)     |
| Is the value on the left greater than or equal to the value on the right? |   >= (greater than or equal to)  |

## Object Comparison Operators 

```ruby
public void comparisonTests1()
{
     testClass x = null; 
     testClass y = new testClass();
     x = y;
     if (x == y)
     {
         // perform equality logic here ... 
     }
}
```
Result : True

```ruby
public void comparisonTests2()
{
     testClass x = new testClass(); 
     testClass y = new testClass();
     if (x == y)
     {
         // perform equality logic here ... 
     }
}
```
Result : False. Same types but not the same thing. 


## Primitive Operator Parsing
```ruby
public void typeCheck1()
{
     var btn = new Sysyem.Windows.Forms.Button(); // Create a button
     if (btn is System.Windows.Forms.Control)
     {
         // insert code to run if the 'btn' variable is compatible (inherits) from Control
     }
}
```
Result : True

# Exceptions
## Exceptions and Try/Catch/Finally
* Encapsulate all I/O operations in a try/catch/finally block (especially streams).
* Catch specific known exceptions first, then more general exceptions.
* Best Practice: Avoid Exceptions by checking conditions that may cause them.
```ruby
public void tryCatchExample1()
{
     var data = string.Empty;
     try
     {
         data = system.IO.File.ReadAllText("data.txt");       
     }
     catch (System.IO.FileNotFoundException fnf)
     {
         // handle situation where the file doesn't exist
     }
     catch (System.Exception ex)
     {
         // handle any other error that occurs
     }
}
```

```ruby
public void tryCatchExample2()
{
     var data = string.Empty;
     try
     {
         data = system.IO.File.ReadAllText("data.txt");       
     }
     catch (System.Exception ex)
     {
          // perform some logging of the error 
          Console.WriteLine(ex.Message); 
          
          // re-throw the original exception to retain all stack trace information
          throw; 
     }
}
```
* Utilize the finally block to ensure an operation completes
```ruby
var data = string.Empty;
System.IO.FileStream stream = null; 
System.IO.streamReader reader = null; 
try
{
   stream = System.IO.File.OpenRead("data.txt");
   reader = new System.IO.StreamReader(stream); 
   data = reader.ReadToEnd();
}
catch (System.Exception ex)
{
   Console.WriteLine(ex.Message);
   throw;
}
finally 
{
   // dispose of unmanaged resources safely 
   if (null != reader)
      reader.Dispose(); 
   if (null != stream)
      stream.Dispose(); 
}
```
* Exception Handling shorthand syntax with Using statements 
  - Using statement is only valid on classes implementing the IDsiposable interface
```ruby
var data = string.Empty;
using (var stream = System.IO.File.OpenRead("data.txt"))
{
   using (var reader = new System.IO.StreamReader(stream)
   {
      data = reader.ReadToEnd(); 
   }
}
```
  
## Parse numbers from a string
* Parsing integers, decimals and doubles from a string
```ruby
public void ParseValuetypesExample3()
{
   var integerstring = "Happy Bird";
   
   int myInt = 0; 
   if (!int.TryParse(integerString, out myInt))
   {
      // logic to handle what happens if parsing fails 
   }
}
```

## Utilizing Unit Tests within Visual Studio
* 1) Requires a reference to be added to your project
* 2) Requires that your class containing tests have the TestClass attribute
* 3) Requires methods used for testing have the TestMethod attribute
* 4) Use the Main Menu > Test > Windows > Test Explorer Window to display all available tests in your current project (may require compiling the solution)
* 5) May require adjusting the bitness depending on your implementation.  The unit testing executable must be told whether to run 32 or 64 bit.
