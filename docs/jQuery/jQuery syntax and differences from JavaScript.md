---
layout: default
title: jQuery Syntax and Differences from JavaScript
parent: jQuery
permalink: /jquery/syntax-compared-to-js

nav_order: 1
---

# jQuery Syntax and Differences from JavaScript  
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---


## Start coding! 
```ruby
<!DOCTYPE html> 
<html> 
<head> 
    <title></title> 
    <script src="js/jquery-3.2.1.min.js"></script> 
    <script src="js/main.js"></script>      // Just try to take record directly inside our front page
</head> 
<body> 
<p id="test">This is a paragraph!</p>
<script> 
        /* javaScript */ 
          document.getElementById("test").onclick = function() { 
            alert("Clicked!"); 
          }
          
        /* jQuery */  
        $("#test").click(function(){
            alert("Clicked");
        });          
</script> 
</body> 
</html> 
```

document.getElementById   // we want to select something 
"test"    // id of the thing if we want to select 
.onclick()    // Event handler 
function() { 
            alert("Clicked!"); 
          }
          // what needs to happen when the user does something

$(    )   // we want to select something 
"#test"    // id of the thing if we want to select 
.click(function() {         // Event handler. what needs to happen in order for something else to happen 
}); 

alert("Clicked");   // what needs to happen 


* We need to make sure that JavaScript loads last 
because it is just a rule of thumb inside a website because JavaScript usually manipulates HTML code so we need the HTML to look first 
and then the JavaScript code having said this it means that 
we need to include the JavaScript code at the very last of the documents because a document loads from top to bottom so we need to have it at the ends




```ruby
<!DOCTYPE html> 
<html> 
<head> 
    <title></title> 
    <script src="js/jquery-3.2.1.min.js"></script> 
    <script src="js/main.js"></script>      // Just try to take record directly inside our front page
</head> 
<body> 
<p id="test">This is a paragraph!</p>
<script> 

        /* jQuery */  
        $(document).ready(function() {          // Once the document has been loaded
              $("#test").click(function(){        // Then it needs to go ahead and load the jQuery code
                  alert("Clicked");
               });            
        });
        
</script> 
</body> 
</html> 
```



Selector inside jQuery 
```
$("#id")
$(".class")
$("div")

```
jquery : Go ahead, include code inside for example the head tag if you want to because we have a function inside to a query that actually allow for us to load the code after everything else has been loaded. 

ID
```ruby
        /* jQuery */  
        $(document).ready(function() {          // Once the document has been loaded
              $("#id").click(function(){        // Then it needs to go ahead and load the jQuery code
                  alert("Clicked");
               });            
        });
        
```
Class
```ruby
        /* jQuery */  
        $(document).ready(function() {          // Once the document has been loaded
              $(".class").click(function(){        // Then it needs to go ahead and load the jQuery code
                  alert("Clicked");
               });            
        });
        
```
Tag
```ruby
        /* jQuery */  
        $(document).ready(function() {          // Once the document has been loaded
              $("div").click(function(){        // Then it needs to go ahead and load the jQuery code
                  alert("Clicked");
               });            
        });
        
```
Paragraph with the class
```ruby
        /* jQuery */  
        $(document).ready(function() {          // Once the document has been loaded
              $("p.test").click(function(){        // Then it needs to go ahead and load the jQuery code
                  alert("Clicked");
               });            
        });
        
```

If you want to do something with this element 
```ruby
        /* jQuery */  
        $(document).ready(function() {          // Once the document has been loaded
              $("#id").click(function(){        // Then it needs to go ahead and load the jQuery code
                 $(this).hide();                 // If I click this, it disappered. 
               });            
        });
        
```

