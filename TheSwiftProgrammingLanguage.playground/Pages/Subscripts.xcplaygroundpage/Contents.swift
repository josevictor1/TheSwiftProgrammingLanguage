import Foundation

/*Subscripts*/

//Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. For example, you access elements in an Array instance as someArray[index] and elements in a Dictionary instance as someDictionary[key].
//
//You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript. Subscripts are not limited to a single dimension, and you can define subscripts with multiple input parameters to suit your custom type’s needs.

/*Subscript Syntax*/

//Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name. Their syntax is similar to both instance method syntax and computed property syntax. You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type, in the same way as instance methods. Unlike instance methods, subscripts can be read-write or read-only. This behavior is communicated by a getter and setter in the same way as for computed properties:

//subscript(index: Int) -> Int {
//    get {
//
//    }
//    set(newValue) {
//
//Remember: When we was studying Generics we saw objects with arrays inside. Those arrays are the objects the could be setted by set propertie.
//    }
//}


//The type of newValue is the same as the return value of the subscript. As with computed properties, you can choose not to specify the setter’s (newValue) parameter. A default parameter called newValue is provided to your setter if you do not provide one yourself.
//
//As with read-only computed properties, you can simplify the declaration of a read-only subscript by removing the get keyword and its braces:

//subscript(index: Int) -> Int {
//    // return an appropriate subscript value here
//}

//Here’s an example of a read-only subscript implementation, which defines a TimesTable structure to represent an n-times-table of integers:

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

//In this example, a new instance of TimesTable is created to represent the three-times-table. This is indicated by passing a value of 3 to the structure’s initializer as the value to use for the instance’s multiplier parameter.
//
//You can query the threeTimesTable instance by calling its subscript, as shown in the call to threeTimesTable[6]. This requests the sixth entry in the three-times-table, which returns a value of 18, or 3 times 6.
