Export Module
=============

#### The module’s only entry-point is the `Listag` class

Prevent properties being accidentally modified or added to the module. 

    oo.lock Listag

First, try defining an AMD module, eg for [RequireJS](http://requirejs.org/). 

    if oo.F == typeof define and define.amd
      define -> Listag

Next, try exporting for CommonJS, eg for [Node.js](http://goo.gl/Lf84YI):  
`var Listag = require('listag');`

    else if oo.O == typeof module and module and module.exports
      module.exports = Listag

Otherwise, add the `Listag` class to global scope.  
Browser usage: `var listag = new window.Listag();`

    else oo.G.Listag = Listag


    ;

