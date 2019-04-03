/*Protocols*/

//A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.
//
//In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.

/*Protocol Syntax*/
//
//You define protocols in a very similar way to classes, structures, and enumerations:


//protocol SomeProtocol {
//    // protocol definition goes here
//}

//If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma:

//class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
//    // class definition goes here
//}

/* Property Requirements*/

//A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. The protocol also specifies whether each property must be gettable or gettable and settable.
//
//If a protocol requires a property to be gettable and settable, that property requirement can’t be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it’s valid for the property to be also settable if this is useful for your own code.
//
//Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

//Always prefix type property requirements with the static keyword when you define them in a protocol. This rule pertains even though type property requirements can be prefixed with the class or static keyword when implemented by a class:

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

//The FullyNamed protocol requires a conforming type to provide a fully-qualified name. The protocol doesn’t specify anything else about the nature of the conforming type—it only specifies that the type must be able to provide a full name for itself. The protocol states that any FullyNamed type must have a gettable instance property called fullName, which is of type String.

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")


//Each instance of Person has a single stored property called fullName, which is of type String. This matches the single requirement of the FullyNamed protocol, and means that Person has correctly conformed to the protocol. (Swift reports an error at compile-time if a protocol requirement is not fulfilled.
//Proof:

//struct Person1: FullyNamed {
//
//}

//Protocols.xcplaygroundpage:42:9: note: protocol requires property 'fullName' with type 'String'; do you want to add a stub?
//var fullName: String { get }

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")


//This class implements the fullName property requirement as a computed read-only property for a starship. Each Starship class instance stores a mandatory name and an optional prefix. The fullName property uses the prefix value if it exists, and prepends it to the beginning of name to create a full name for the starship.
//

/*Method Requirements*/

//Protocols can require specific instance methods and type methods to be implemented by conforming types. These methods are written as part of the protocol’s definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body. Variadic parameters are allowed, subject to the same rules as for normal methods. Default values, however, can’t be specified for method parameters within a protocol’s definition.
//
//As with type property requirements, you always prefix type method requirements with the static keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class:

protocol SomeProtocol2 {
    static func someTypeMethod()
}

class TestClass: SomeProtocol2 {
    //It's need have static... when we remove static it will show an error and ask to stub
    static func someTypeMethod() {
        
    }
}
// type methods has the same way to use as type variables
TestClass.someTypeMethod()

//The following example defines a protocol with a single instance method requirement:

protocol RandomNumberGenerator {
    func random() -> Double
}

//Here’s an implementation of a class that adopts and conforms to the RandomNumberGenerator protocol. This class implements a pseudorandom number generator algorithm known as a linear congruential generator:

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")

print("And another one: \(generator.random())")

/*Mutating Method Requirements*/

//It’s sometimes necessary for a method to modify (or mutate) the instance it belongs to. For instance methods on value types (that is, structures and enumerations) you place the mutating keyword before a method’s func keyword to indicate that the method is allowed to modify the instance it belongs to and any properties of that instance. This process is described in Modifying Value Types from Within Instance Methods.

//
//If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition. This enables structures and enumerations to adopt the protocol and satisfy that method requirement.
//
//NOTE
//
//If you mark a protocol instance method requirement as mutating, you don’t need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
    // if you remove the mutating
//    func toggle() {
//        switch self {
//        case .off:
//            self = .on
//        case .on:
//            self = .off
//        }
//    }
//
//    Protocols.xcplaygroundpage:148:5: note: mark method 'mutating' to make 'self' mutable
//    func toggle() {
//        ^
//        mutating
    
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

//Trying use mutating on classes:
class MyOnOffSwitch: Togglable {
    func toggle() {
        print("toggle")
    }
}

// Classes are reference type, that way you always you modify the instance not a copy.
// This is way mutating is not required when we you implements the protocol method.

/*Initializer Requirements*/

//Protocols can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:

protocol SomeProtocol3 {
    init(someParameter: Int)
}

// Try open curly braces:

//protocol SomeProtocol {
//    init(someParameter: Int) {
//        print(someParameter)
//    }
//}
//Result:
//error: Protocols.xcplaygroundpage:187:30: error: protocol initializers must not have bodies
//init(someParameter: Int) {
//                           ˆ

// What happens if we try to extend it ?

//extension SomeProtocol3 {
//    init(someParameter: Int) {
//        self.init(someParameter: someParameter)
//        print(someParameter)
//    }
//}
//It's very wrong!!! Because when you do somethig like that you enter in a loop. Init is calling init recursively
// If you not insert self.init(someParameter: someParameter)
//  error: Protocols.xcplaygroundpage:201:5: error: 'self.init' isn't called on all paths before returning from initializer
//
//
//class TestProtocolInit: SomeProtocol3 {
//
//}
//
//let myTest = TestProtocolInit(someParameter: 10)

/*Class Implementations of Protocol Initializer Requirements*/

//You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier:

class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

//The use of the required modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.
//
//For more information on required initializers, see Required Initializers.
//
//NOTE
//
//You don’t need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes can’t subclassed. For more about the final modifier, see Preventing Overrides.
