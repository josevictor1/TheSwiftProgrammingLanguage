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
    var mustBeSettable: Int
    
    var doesNotNeedToBeSettable: Int
    
    required init(someParameter: Int) {
        mustBeSettable = 3
        doesNotNeedToBeSettable = 3
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


//If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers:

protocol SomeProtocol4 {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol4 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

/*Failable Initializer Requirements*/

//Protocols can define failable initializer requirements for conforming types, as defined in Failable Initializers.
//
//    A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.

/*Protocols as Types*/

//Protocols don’t actually implement any functionality themselves. Nonetheless, any protocol you create will become a fully-fledged type for use in your code.
//
//Because it’s a type, you can use a protocol in many places where other types are allowed, including:
//
//As a parameter type or return type in a function, method, or initializer
//As the type of a constant, variable, or property
//As the type of items in an array, dictionary, or other container
//NOTE
//
//Because protocols are types, begin their names with a capital letter (such as FullyNamed and RandomNumberGenerator) to match the names of other types in Swift (such as Int, String, and Double).

//Here’s an example of a protocol used as a type:

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

/*Delegation*/

//Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                print(newSquare)
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

/*Adding Protocol Conformance with an Extension*/

//You can extend an existing type to adopt and conform to a new protocol, even if you don’t have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand. For more about extensions, see Extensions.
//
//NOTE
//
//Existing instances of a type automatically adopt and conform to a protocol when that conformance is added to the instance’s type in an extension.
//
//For example, this protocol, called TextRepresentable, can be implemented by any type that has a way to be represented as text. This might be a description of itself, or a text version of its current state:

protocol TextRepresentable {
    var textualDescription: String { get }
}

//The Dice class from above can be extended to adopt and conform to TextRepresentable:

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

//This extension adopts the new protocol in exactly the same way as if Dice had provided it in its original implementation. The protocol name is provided after the type name, separated by a colon, and an implementation of all requirements of the protocol is provided within the extension’s curly braces.

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

/*Conditionally Conforming to a Protocol*/

//A generic type may be able to satisfy the requirements of a protocol only under certain conditions, such as when the type’s generic parameter conforms to the protocol. You can make a generic type conditionally conform to a protocol by listing constraints when extending the type. Write these constraints after the name of the protocol you’re adopting by writing a generic where clause. For more about generic where clauses, see Generic Where Clauses.


//The following extension makes Array instances conform to the TextRepresentable protocol whenever they store elements of a type that conforms to TextRepresentable.

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)

//Proof:

//class MyElement {
//
//}
//
//let myArray = [MyElement(), MyElement()]
//print(myArray.textualDescription)
//Property 'textualDescription' requires that 'MyElement' conform to 'TextRepresentable'

/*Declaring Protocol Adoption with an Extension*/

//If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

//Instances of Hamster can now be used wherever TextRepresentable is the required type:

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

//NOTE
//
//Types don’t automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.

/*Collections of Protocol Types*/

//A protocol can be used as the type to be stored in a collection such as an array or a dictionary, as mentioned in Protocols as Types. This example creates an array of TextRepresentable things:

let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}

/*Protocol Inheritance*/
//A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits. The syntax for protocol inheritance is similar to the syntax for class inheritance, but with the option to list multiple inherited protocols, separated by commas:

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

//This example defines a new protocol, PrettyTextRepresentable, which inherits from TextRepresentable. Anything that adopts PrettyTextRepresentable must satisfy all of the requirements enforced by TextRepresentable, plus the additional requirements enforced by PrettyTextRepresentable. In this example, PrettyTextRepresentable adds a single requirement to provide a gettable property called prettyTextualDescription that returns a String.

//The SnakesAndLadders class can be extended to adopt and conform to PrettyTextRepresentable:

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

/*Class-Only Protocols*/
//You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol’s inheritance list.

protocol SomeInheritedProtocol {
    
}

protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // class-only protocol definition goes here
}
//
//In the example above, SomeClassOnlyProtocol can only be adopted by class types. It’s a compile-time error to write a structure or enumeration definition that tries to adopt SomeClassOnlyProtocol
//Proof:

class TestClassOnlyProtocol: SomeClassOnlyProtocol {
    
}
// It works...

//struct TestStructClassOnlyProtocol: SomeClassOnlyProtocol {
//    
//}

// It not works...
//error: non-class type 'TestStructClassOnlyProtocol' cannot conform to class protocol 'SomeClassOnlyProtocol'
//struct TestStructClassOnlyProtocol: SomeClassOnlyProtocol {
//^

//NOTE
//
//Use a class-only protocol when the behavior defined by that protocol’s requirements assumes or requires that a conforming type has reference semantics rather than value semantics.

/*Protocol Composition*/
//It can be useful to require a type to conform to multiple protocols at the same time. You can combine multiple protocols into a single requirement with a protocol composition. Protocol compositions behave as if you defined a temporary local protocol that has the combined requirements of all protocols in the composition. Protocol compositions don’t define any new protocol types.

//Protocol compositions have the form SomeProtocol & AnotherProtocol. You can list as many protocols as you need, separating them with ampersands (&). In addition to its list of protocols, a protocol composition can also contain one class type, which you can use to specify a required superclass.

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

//In this example, the Named protocol has a single requirement for a gettable String property called name. The Aged protocol has a single requirement for a gettable Int property called age. Both protocols are adopted by a structure called Person.
//
//The example also defines a wishHappyBirthday(to:) function. The type of the celebrator parameter is Named & Aged, which means “any type that conforms to both the Named and Aged protocols.” It doesn’t matter which specific type is passed to the function, as long as it conforms to both of the required protocols.
//
//The example then creates a new Person instance called birthdayPerson and passes this new instance to the wishHappyBirthday(to:) function. Because Person conforms to both protocols, this call is valid, and the wishHappyBirthday(to:) function can print its birthday greeting.
//

//Proof:

struct ConformsWithNamed: Named {
    var name: String
}

struct ConformsWithAged: Aged {
    var age: Int
}


let named = ConformsWithNamed(name: "named")
let aged = ConformsWithAged(age: 1)

//wishHappyBirthday(to: named)
//Argument type 'ConformsWithNamed' does not conform to expected type 'Aged & Named'

//Here’s an example that combines the Named protocol from the previous example with a Location class:


class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

//any type that’s a subclass of Location and that conforms to the Named protocol.”

//Passing birthdayPerson to the beginConcert(in:) function is invalid because Person isn’t a subclass of Location. Likewise, if you made a subclass of Location that didn’t conform to the Named protocol, calling beginConcert(in:) with an instance of that type is also invalid.
//Proof:

//beginConcert(in: birthdayPerson)
//argument type 'Person1' does not conform to expected type 'Location & Named'
//beginConcert(in: birthdayPerson)
//^~~~~~~~~~~~~~

class NotConformWithNamed: Location {
    
}
//let notConformWithNamed = NotConformWithNamed()
//beginConcert(in: NotConformWithNamed)
//error: argument type 'NotConformWithNamed.Type' does not conform to expected type 'Location & Named'
//beginConcert(in: NotConformWithNamed)
//^~~~~~~~~~~~~~~~~~~

/*Checking for Protocol Conformance*/
//You can use the is and as operators described in Type Casting to check for protocol conformance, and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:
//
//The is operator returns true if an instance conforms to a protocol and returns false if it doesn’t.
//The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance doesn’t conform to that protocol.
//The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast doesn’t succeed.

protocol HasArea {
    var area: Double { get }
}


class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//Whenever an object in the array conforms to the HasArea protocol, the optional value returned by the as? operator is unwrapped with optional binding into a constant called objectWithArea. The objectWithArea constant is known to be of type HasArea, and so its area property can be accessed and printed in a type-safe way.

//Note that the underlying objects aren’t changed by the casting process. They continue to be a Circle, a Country and an Animal. However, at the point that they’re stored in the objectWithArea constant, they’re only known to be of type HasArea, and so only their area property can be accessed.
