---
layout: default
title: C# Fundamentals
parent: Advanced Visual Programming (C# .NET)

nav_order: 1
---

# C# Fundamentals
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

# what is C#? 
## Little background on C#
 - One of the primary languages that MicroSoft pushes in the .NET ecosystem.
 - C# is a very C style language, syntax-based laguage. 
 - Java is nearly identical syntax wised to C#. There is a lot of similarities between Java and C#. 

## Prerequisite
 - The .Net Ecosystems has been evolving and C# is going to develop on a .NET Framework (Not NET.Core developement).
 - The lastest version of Visual Studio
 - Make sure you have got comfort-level dealing with mathmatical operations and arrays, File IO operations.

### IDE - About 'Test Explorer'
* Location: Visual Studio > Test > Test Explorer (Ctrl+E,T) 
* What it is doing? It scans through the project and it tries to find the unit tests that are defined. 
* Test Methods are testing to make sure the testing harness is working well. 
* While testing(Debugging) on Visual Studio
- F5 Key : It will go to the next break point.
- F10 and F11 keys : It will step through the code and execute that line of code. It allows you to stay in the current method where you are at. 

### Tips before starting implementation
* Write 'throw new NotImplementedException();' in an empty method.  
- System.NotImplementedException: 'The method or operation is not implemented.'
- Meaning: Method isn't finished! Throw an error!
- Purpose: When you created a method, you are stubbing it out don't want to fill in the guts of what the method is going to do.
* Type thre slashes(///) above a method, property or field and the documentation code will show up. 
- Purpose of code Documentation: Explanation for what the method is doing. Description of what the two inputs are and what kinds of thing is returned. 
- Code comments are meant to provide a brief explanation in areas where the code is less self-explanatory. 
- This will cause the IDE to automatically create the commenting structure that you will need to fill in. 

```ruby

 /// <summary> 
  ///
  /// </summary> 
  /// <param name="input1"></param> 
  /// <param name="input2"></param> 
  /// <returns></returns> 

```

## C# .NET Features
### Pros and Cons as a language
 * Advanatges: Quick prototype windows form apps, Familiar C-style syntax, Entire .NET Framework suite of languages, Prevalent OOP language for the .NET ecosystem, A type-safe language
 * Disadvantages: Virtual machine and garbage collector(MacOS or Linux), Less performance(Higher overhead for virtual functions in the multiple inheritance, .NET Core and Mono(Only available in Window), Space allocation), Learning curve.

### Things to do using C#
 * GUI Development:  Windows Form, WPF (Windows Presentation Foundation) 
 * Web Development:  ASP .NET, ASP .NET MVC Framework
 * Game Development:  Game Client Development(Unity, Mono Platform) > Game Server Development (Speed is improved.)
 * IoT Development:  Supported C# Embeded version by MS, but the cost an arm and a leg.

### Current State of .NET Ecosystem
![DotNet structure](../../assets/images/Csharp_dotnetframwork-structure_2020-02-14.png)

# Visibility, Variables, Arrays, Classes
## C# Syntax
### Access Levels
* private – Code in the type that declares a private element, including code within contained types, can access the element. Other code file will not be able to access of this private code. 
"I created my codes and I don't want anybody messing with them!"
* private protected - Code in the class that declares a private protected element, or code in a derived class found in the same assembly as the base class. Combination of the private and protected. 
"It gets the a little bit of concept of inheritance, you can create the sub classes and those sub classes are able to access variables." 
* protected - Code in the class that declares a protected element, or a class derived from it, can access the element.
* internal - Code in the assembly that declares a friend element can access it.
"You will actually see the internal keywords in several places in the project. It is same thing as private but other code files in the same project will be able to access that method. Within the project itself, everyone can see the methods and variables."
* protected internal – Union of protected and internal. Code in the same class or the same assembly as a protected internal element, or within any class derived from the element's class, can access it.
* public - Any code that can see a public element can access it.
-> Compliers assumed that you set your access level as an internal if you don't put any access identifier. 

## Visual Basic Class and Namespace Keywords
* namesapce - Defines the location ot the contained classes or modules. 
* class - Defines a set of properties, methods and events. 
* abstract - Used with a class keyword to define it as abstract. 
* : (colon) - Used by after a class keyword to indicate a class that cannot be sub-classed by other classes. 
* sealed - Used by the class keyword to indicate a class that cannot be sub-classed by other classes. "I have no way to modify that."

** Note about Namespaces: All C# languege source files must have a namespace declaration. The IDE will actually construct the namespace from the location on disk relative to the root of the project. The root namespace is defined under the project properties within your IDE. 


<Project 1> 

example
```ruby
// Using statement allow you say that append this name space appropriate. 
using exp = System.Text.RegularExpressions; // Simplification, shorthand

public string Add(string input1, string input2) {
  var obj = new exp.Regex(".*"); 
}
```
### C# specific Keywords 
* var - Compiler support for type interence
   var myValue = 1; // type inference using var
   int myOtherValue = 2; // explicit type declaration 
* is - Checks to see if an object is of another type
* as - Type-casts an object into a compatible type
* yield - Used for avoiding the creation of custom collection 
* switch - Used for standard case statements and functional pattern matching 
* typeof - Used to retrieve the type informtation associated with an object or generic parameter
* dynamic - Scripting using C# and execute that outside of IDE 

```ruby
public string Add(string input1, string input2) {
  int myInt = 5;
  var myOtherInt = 6; 
  
  myInt++; 
  myOtherInt = myOtherInt + 1; // myOtherInt is automatically changed as an integer value.
  
  ProjectName.Functions.MathFunctions myMath = new ProjectName.Functions.MathFunctions(); 
  var myMath2 = new ProjectName.Functions.MathFunctions();
  var myMath3 = new MathFunctions(); 
  // var someObj = null; ...(x) // Null cannot be a variable.
  
  /* Advanced */ 
  dynamic o = null; 
  o.someMethod(); 
  
  var str = string.Empty;
  object obj = str; // Assign str to Object variable 
    obj = 6; 
  
  if (str is string)
  {
    var anotherStr = obj as a string; // anotherStr is a string. 
  } 
  
}
```
## C# Classes Constructors
* Default Constructor - Created automatically by the compiler if none are defined. 
This constructor is unique as it takes absolutely no parameters. 
* Customized Constructors - Customized constructors that accept initialization information for the object. 
* Static Constructors - Constructors that are fired once during the lifetime of the application the first time the class is referenced or used. It cannot accept any parameters and uses the static keyword. 
```ruby
internal class Class1
{
    private int myAge; 
    
    public Class1()
    {
      // Default Constructor
    }
    
    public Class1(int age)
    {
      // Customized Constructor
      myAge = age
    }
    
    public Class1(decimal height) 
    {
      // Customized Constructor
    }
    
    public Class1(0 : this(5) 
    {
      // A constructor can call another constructor. 
    }
    
    static Class1()
    {
      // happens once and never again during the lifetime of the application. Not recommended to use this. 
      // Perform one-time logic here...
      // Try to avoid these constructors.
      // Not considered OOP-best practice.
    }
}
```

### Property vs Feild Declaration: Data Hiding and not exposing fields directly. 
```ruby
internal class Class1
{
    private int myInt; 
    
    public int MyOtherValue { get; set;}  // Example automatic getter and setter 
    //  public int MyOtherValue { get;private set;}
    
    public Class1()
    {
      // Default Constructor
    }
}
```
```ruby
internal class Class2
{
    
    public void SomeMethod()
    {
      var class1 = new Class1(); 
      var someVal = class1.MyOtherValue; // public value 
      class1.myInt = 3; // Cannot access to myInt. 
    }
}
```


## Automatic Property Getters and Setters : Getters and Setters can have different visibility
```ruby
internal class Class1
{
    public int _MyOtherValues2 = 0; 

    // Equivalent to public int MyOtherValue { get; private set; } 
    public int MyOtherValue2  // Example property with getter and setter
    {
      get
      {
         return _MyOtherValue; 
      }
      private set
      {
         _MyOtherValue2 = value; 
      }
    }
}
```
 
 ### Object Initializer Shorthand Syntax 
 
```ruby
public void exampleMethod()
{
   // Standard property setting 
   // after object intialization 
   var person1 = new Person(); 
   person1.First = "Haemin"; 
   person1.Last = "Ryu";
   
   // Object initializer syntax
   var person2 = new Person(){ 
   First = "Haemin", Last = "Ryu" }; 
}
```

## C# Array Declarations 
