---
layout: default
title: Write Unit Tests for Manage Code
parent: Advanced Visual Programming (C# .NET)
permalink: /csharp/unit-test
nav_order: 9
---

# Write Unit Tests for Manage Code
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

[Walkthrough: Create and run unit tests for managed code](https://docs.microsoft.com/en-us/visualstudio/test/walkthrough-creating-and-running-unit-tests-for-managed-code?view=vs-2019)

## Unit Testing 
* Goal: To verify the project by creating, running, and customizing a series of unit tests using the Microsoft unit test framwork for managed code and Visual Studio Test Explorer. 
* Process: Create tests that exercise its code --> Run the tests --> Examine the results --> Change the project Code --> Rerun the tests. 

## How to create a unit test project 
1. On the File menu, select Add > New Project.
2. Search for and select the C# MSTest Test Project (.NET Core) project template, and then click Next.
3. Name the project for testing. 
4. Click Create. The project for testing is added to the project solution.
5. In the Tests project, add a reference to the solution project. In Solution Explorer, select Dependencies under the Tests project and then choose Add Reference from the right-click menu.
6. In the Reference Manager dialog box, expand Projects, select Solution, and then check the Project item.
7. Choose OK.

## How to Create a Unit Test Class 
### Rename a file and class and Add a using statement
#### Example structure
```ruby 
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ExampleTests
{
    [TestClass]
    public class ExampletTests
    {
        [TestMethod]
        public void TestMethod1()
        {
        }
    }
}
```
#### Test class Requirements
* The [TestClass] attribute is required on any class that contains unit test methods that you want to run in Test Explorer.
* Each test method that you want Test Explorer to recognize must have the [TestMethod] attribute.
* Add a using statement to the test class to be able to call into the project under test without using fully qualified names.

## How to Create the First Test Method
### 3 Steps of testing method: Arrange --> Act --> Assert
1. Arrange: Set up the variable(s0 or the object(s) 
2. Act: Call the method(s) 
3. Assert: Verify the result that is expected using AreEqual(), AreNotEqual(), IsNotNull(), IsNull(), IsTrue(), IsFalse(), or ThrowsException<System.ArgumentOutOfRangeException>(), etc. 
#### Test Method Requirements
* Decorated with the [TestMethod] attribute.
* Returns void.
* No parameters.

## Build and run the test, Fix your code and rerun your tests
1. On the Build menu, choose Build Solution.
2. If Test Explorer is not open, open it by choosing Test > Windows > Test Explorer from the top menu bar.
3. Choose Run All to run the test.
  - While the test is running, the status bar at the top of the Test Explorer window is animated. At the end of the test run, the bar turns green if all the test methods pass, or red if any of the tests fail.
4. Select the method in Test Explorer to view the details at the bottom of the window.
5. Correct the bug.
6. Rerun the test.
7. Use Unit Tests to Improve Your Code. 
* To make your production code more robust and effective, with an iterative process of analysis, unit test development, and refactoring. 

