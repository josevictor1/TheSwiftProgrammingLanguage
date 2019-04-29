import Foundation
import UIKit

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

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//You may have noticed that the bodies of the swapTwoInts(_:_:), swapTwoStrings(_:_:), and swapTwoDoubles(_:_:) functions are identical. The only difference is the type of the values that they accept(Int, String, and Double).

//It's more useful, and considerably more flexible, to write a single function that swaps two values of any type. Generic code enables you to write such a function.

//NOTE

//In all three functions, the types of a and b must be the same. If a and b aren't of the same type, it isn't possible to swap their values.  Swift is a type-safe language, and doesn’t allow (for example) a variable of type String and a variable of type Double to swap values with each other. Attempting to do so results in a compile-time error.s

//Generic Functions

//Generic functions can work with any type. Here’s a generic version of the swapTwoInts(_:_:) function from above, called swapTwoValues(_:_:):

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}


//The body of the swapTwoValues(_:_:) function is identical to the body of the swapTwoInts(_:_:) function. However, the first line of swapTwoValues(_:_:) is slightly different from swapTwoInts(_:_:). Here’s how the first lines compare:
//
//func swapTwoInts(_ a: inout Int, _ b: inout Int)
//func swapTwoValues<T>(_ a: inout T, _ b: inout T)

//The generic version of the function uses a placeholder type name (called T, in this case) instead of an actual type name (such as Int, String, or Double). The placeholder type name doesn’t say anything about what T must be, but it does say that both a and b must be of the same type T, whatever T represents. The actual type to use in place of T is determined each time the swapTwoValues(_:_:) function is called.
//
//The other difference between a generic function and a nongeneric function is that the generic function’s name (swapTwoValues(_:_:)) is followed by the placeholder type name (T) inside angle brackets (<T>). The brackets tell Swift that T is a placeholder type name within the swapTwoValues(_:_:) function definition. Because T is a placeholder, Swift doesn’t look for an actual type called T.
//
//The swapTwoValues(_:_:) function can now be called in the same way as swapTwoInts, except that it can be passed two values of any type, as long as both of those values are of the same type as each other. Each time swapTwoValues(_:_:) is called, the type to use for T is inferred from the types of values passed to the function.

var someInt1 = 3
var anotherInt1 = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"

//NOTE
//
//The swapTwoValues(_:_:) function defined above is inspired by a generic function called swap, which is part of the Swift standard library, and is automatically made available for you to use in your apps. If you need the behavior of the swapTwoValues(_:_:) function in your own code, you can use Swift’s existing swap(_:_:) function rather than providing your own implementation.

/*Type Parameters*/

//In the swapTwoValues(_:_:) example above, the placeholder type T is an example of a type parameter. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).
//
//Once you specify a type parameter, you can use it to define the type of a function’s parameters (such as the a and b parameters of the swapTwoValues(_:_:) function), or as the function’s return type, or as a type annotation within the body of the function. In each case, the type parameter is replaced with an actual type whenever the function is called. (In the swapTwoValues(_:_:) example above, T was replaced with Int the first time the function was called, and was replaced with String the second time it was called.)
//
//You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.

//NOTE
//
//The concept of a stack is used by the UINavigationController class to model the view controllers in its navigation hierarchy. You call the UINavigationController class pushViewController(_:animated:) method to add (or push) a view controller on to the navigation stack, and its popViewControllerAnimated(_:) method to remove (or pop) a view controller from the navigation stack. A stack is a useful collection model whenever you need a strict “last in, first out” approach to managing a collection.

//Here’s how to write a nongeneric version of a stack, in this case for a stack of Int values:

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

func showImage(with url: String) -> UIImage{
    let imageUrl = URL(string: url)
    let data = try? Data(contentsOf: imageUrl!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
    if let dataImage = data, let image = UIImage(data: dataImage) {
        return image
    }
    
    return UIImage()
}

showImage(with: "https://docs.swift.org/swift-book/_images/stackPushPop_2x.png")

//This structure uses an Array property called items to store the values in the stack. Stack provides two methods, push and pop, to push and pop values on and off the stack. These methods are marked as mutating, because they need to modify (or mutate) the structure’s items array.
//
//The IntStack type shown above can only be used with Int values, however. It would be much more useful to define a generic Stack class, that can manage a stack of any type of value.
//
//Here’s a generic version of the same code:

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

//
//Note how the generic version of Stack is essentially the same as the nongeneric version, but with a type parameter called Element instead of an actual type of Int. This type parameter is written within a pair of angle brackets (<Element>) immediately after the structure’s name.

//Element defines a placeholder name for a type to be provided later. This future type can be referred to as Element anywhere within the structure’s definition. In this case, Element is used as a placeholder in three places:
//
//To create a property called items, which is initialized with an empty array of values of type Element
//To specify that the push(_:) method has a single parameter called item, which must be of type Element
//To specify that the value returned by the pop() method will be a value of type Element
//Because it’s a generic type, Stack can be used to create a stack of any valid type in Swift, in a similar manner to Array and Dictionary.
//
//You create a new Stack instance by writing the type to be stored in the stack within angle brackets. For example, to create a new stack of strings, you write Stack<String>():

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

// Can stack suport other types ?
//Proof:

var stackOfInt = Stack<Int>()

stackOfInt.push(1)
stackOfInt.push(2)
stackOfInt.push(3)
stackOfInt.push(4)

//Here’s how stackOfStrings looks after pushing these four values on to the stack:

showImage(with: "https://docs.swift.org/swift-book/_images/stackPushedFourStrings_2x.png")

//Popping a value from the stack removes and returns the top value, "cuatro":

let fromTheTop = stackOfStrings.pop()

//Here's how the stack looks after popping its top value:

showImage(with: "https://docs.swift.org/swift-book/_images/stackPoppedOneString_2x.png")

/*Extending a Generic Type*/

//When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the original type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.
//
//The following example extends the generic Stack type to add a read-only computed property called topItem, which returns the top item on the stack without popping it from the stack:

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

//Can we do this ?
//
//struct MyStack: Stack {
//
//}
//Nope!
// Why ?
// reference to generic type 'Stack' requires arguments in <...>
//struct MyStack: Stack {
//    ^
//    <Any>
// https://stackoverflow.com/questions/31465100/subclassing-generic-structs
//It's my understanding that inheritance is the defining difference between classes and non-class objects like structs and enums in swift. Classes have inheritance, other objects types do not.

//Thus I think the answer is "No, not now, and not ever, by design."
//
// Proof: The problem it's not the generic term
//struct A {
//
//}
//
//struct B: A {
//
//}

//error: Generics.xcplaygroundpage:211:8: error: inheritance from non-protocol type 'A'
//struct B: A {
//^

//Note that this extension doesn’t define a type parameter list. Instead, the Stack type’s existing type parameter name, Element, is used within the extension to indicate the optional type of the topItem computed property.

//The topItem computed property can now be used with any Stack instance to access and query its top item without removing it.

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."

/*Type Constraints*/
