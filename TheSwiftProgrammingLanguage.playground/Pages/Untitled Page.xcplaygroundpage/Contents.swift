import Foundation

/*Generics*/

//Generic code enables you to write flexible, reusable functions and types thath can work with any type, subject to requirements that define. You can write code that voids duplication and expresses its intent in a clear, abstracted manner.


/*The Problem That Generics Solve*/

//Here's standard, nongeneric function called swapTwoInts(_:_:), which swaps two Int values:

func swapTwoInts(_ a: inout Int,_ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//The swapTwoInts(_:_:) function swaps the original value of b into a, and the original value of a into b. You can call this function to swap the values in two Int variables:

var someInt = 3

var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)

print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//

func swapTwoStrings(_ a: inout String, _b: inout) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout) {
    let temporary = a
    a = b
    b = temporaryA
}

//You may have noticed that the bodies of the swapTwoInts(_:_:), swapTwoStrings(_:_:), and swapTwoDoubles(_:_:) functions are identical. The only difference is the type of the values that they accept(Int, String, and Double).

//It's more useful, and considerably more flexible, to write a single function that swaps two values of any type. Generic code enables you to write such a function.

//NOTE

//In all three functions, the types of a and b must be the same. If a and b aren't of the same type, it isn't possible to swap
