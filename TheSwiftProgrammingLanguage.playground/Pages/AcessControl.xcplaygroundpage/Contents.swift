//: [Previous](@previous)

import Foundation


//AcessControl

// What is Access Control ?
// Access Control is a language feature that provides control to access types and properties in defined contexts. This enables you to hide code implementation.
// Access control restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.

// Access levels:

    // open: enable you to inherit the class, is the least restrictive access level.

    // public: enable you to access the code but you can't override the properies

    // internal: default type, enables you to use the entities in any source file of the defined module, but no outside that

    // fileprivate: access restricts the use of an entity to its own defining a source file.

    // private: the most restrict tive level.

    // final: determine that the class can't be ineherited

// - Diference between fileprivate and private?
// Private restrict the access level to the entity that this enclose. Fileprivate restrict the access level to the file.

// How to use it ?
// You will use the reserved words as a first word on the statement.

// When to use it ?
// When you need to resctrict the access to some implementation or hide some piece of code.

// How it relate with swift type structure ?

    // - Structs

    // - Class

    // - Protocols

    // - Extentsions

    // - Generics

// Open vs Public
// Open allows subclassing but public don't
