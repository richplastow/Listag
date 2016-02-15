Export Module
=============

#### The module’s only entry-point is the `Listag` class

First, try defining an AMD module, eg for [RequireJS](http://requirejs.org/). 

    if _o.F == typeof define and define.amd
      define -> Listag

Next, try exporting for CommonJS, eg for [Node.js](http://goo.gl/Lf84YI):  
`var Listag = require('listag');`

    else if _o.O == typeof module and module and module.exports
      module.exports = Listag

Otherwise, add the `Listag` class to global scope.  
Browser usage: `var listag = new window.Listag();`

    else _o.G.Listag = Listag


    ;

