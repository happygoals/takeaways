---
layout: default
title: Apply JavaScript with HTML DOM Attributes
parent: Front-end Development Basics
permalink: /front-end/js-with-HTML-DOM

nav_order: 5
---

# Apply JavaScript with HTML DOM Attributes
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---


## Principles 

### The NamedNodeMap Object
NamedNodeMap object represents an unordered collection of an elements attribute nodes.
- Nodes in a NamedNodeMap can be accessed by name or by index (number).

Example of NamedNodeMap
```ruby
fullHero.attributes
NamedNodeMap {0: class, 1: index, class: class, index: index, length: 2}
```

## Problem Code
```ruby
    function moveHeroInDOM(oldIndex,newIndex,up) {
        up ? iaePos = 'beforebegin' : iaePos = 'afterend';
        var heroNode = heroElementNodes[oldIndex];
        heroNodeHeight = heroNode.offsetHeight; 
        var targetNode = heroElementNodes[newIndex];
        targetNodeHeight = targetNode.offsetHeight;
        targetNodeIndex = parseInt(targetNode.querySelector('.mshero__field--index input'));

        up ? heroNodeStyle = -Math.abs(heroNodeHeight+30) : heroNodeStyle = heroNodeHeight+30;
        up ? targetNodeStyle = targetNodeHeight+30 : targetNodeStyle = -Math.abs(targetNodeHeight+30);
        heroNode.style = 'transition:all .4s ease;transform:translateY('+heroNodeStyle+'px)';
        targetNode.style = 'transition:all .4s ease;transform:translateY('+targetNodeStyle+'px)';
        setTimeout(function() {
            heroNode.style = '';
            targetNode.style = '';
            allHeroes.removeChild(heroNode);
            targetNode.insertAdjacentElement(iaePos,heroNode);
            targetNode.dataset.position = oldIndex;
            up ? targetNodeIndex = targetNodeIndex + 1 : targetNodeIndex = targetNodeIndex - 1;
            targetNode.querySelector('.mshero__field--index input') = targetNodeIndex;
            initHeroes();
        },450);
    }
```
## Solution Code
```ruby
     function findPrevious(elm) {
        do {
            elm = elm.previousSibling;
        } while (elm && elm.nodeType != 1);
        return elm;
     }

    function moveHeroInDOM(elem, up){
        up ? iaePos = 'beforebegin' : iaePos = 'afterend';
        var previous = findPrevious(elem);
        elem.parentNode.insertBefore(elem,previous);
    }
```
 
## Reference
* [Stackoverflow-How to swap HTML elements in javascript?](https://stackoverflow.com/questions/2943140/how-to-swap-html-elements-in-javascript)
* [MDN web docs-NamedNodeMap](https://developer.mozilla.org/en-US/docs/Web/API/NamedNodeMap)
* [The HTML DOM Attribute Object](https://www.w3schools.com/jsref/dom_obj_attributes.asp)
* [MDN web docs-WebAPI Element.attributes](https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes)
* [HTML DOM offsetHeight Property](https://www.w3schools.com/jsref/prop_element_offsetheight.asp)
* [DOM Manipulation with jQuery](https://blog.garstasio.com/you-dont-need-jquery/dom-manipulation/#inserting-elements-as-children)
