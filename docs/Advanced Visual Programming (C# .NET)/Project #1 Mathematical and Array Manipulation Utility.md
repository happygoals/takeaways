---
layout: default
title: Mathematical and Array Manipulation Utility
parent: Advanced Visual Programming (C# .NET)

nav_order: 2
---

# Project 1 Mathematical and Array Manipulation Utility
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---
*  Project Name: Project #1 - Mathematical and Array Manipulation Utility
 *  File Name: ArrayFunctions.cs , MathFunctions.cs
 *  Start Date: 01/21/2020
 *  Last Modified Date: 01/23/2020
 
 * Future Work : Calculation functions can be simple by removing duplication. 
 If we make a function include operator as a parameter, it will make less duplication code.  
 
 
 <div class="code-example" markdown="1">
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
</div>

{% highlight markdown %}
            string directory = System.IO.Path.GetFullPath(PersistentFile);
            directory = System.IO.Path.GetDirectoryName(directory);
{% endhighlight %}



