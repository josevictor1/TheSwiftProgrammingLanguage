//Initialization

//Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.

//Initializers

//Initializers are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, written using the init keyword:

//init() {
//    // perform some initialization here
//}

//The example below defines a new structure called Fahrenheit to store temperatures expressed in the Fahrenheit scale. The Fahrenheit structure has one stored property, temperature, which is of type Double:


struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"
//The structure defines a single initializer, init, with no parameters, which initializes the stored temperature with a value of 32.0 (the freezing point of water in degrees Fahrenheit).


//Default Property Values

//You can set the initial value of a stored property from within an initializer, as shown above. Alternatively, specify a default property value as part of the property’s declaration. You specify a default property value by assigning an initial value to the property when it is defined.

//NOTE
//
//If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance, as described later in this chapter.

//You can write the Fahrenheit structure from above in a simpler form by providing a default value for its temperature property at the point that the property is declared:

//struct Fahrenheit {
//    var temperature = 32.0
//}

//Customizing Initialization

//You can customize the initialization process with input parameters and optional property types, or by assigning constant properties during initialization, as described in the following sections.

//Initialization Parameters

//You can provide initialization parameters as part of an initializer’s definition, to define the types and names of values that customize the initialization process. Initialization parameters have the same capabilities and syntax as function and method parameters.
//
//The following example defines a structure called Celsius, which stores temperatures expressed in degrees Celsius. The Celsius structure implements two custom initializers called init(fromFahrenheit:) and init(fromKelvin:), which initialize a new instance of the structure with a value from a different temperature scale:

//struct Celsius {
//    var temperatureInCelsius: Double
//    init(fromFahrenheit fahrenheit: Double) {
//        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//    }
//    init(fromKelvin kelvin: Double) {
//        temperatureInCelsius = kelvin - 273.15
//    }
//}
//let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//// boilingPointOfWater.temperatureInCelsius is 100.0
//let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//// freezingPointOfWater.temperatureInCelsius is 0.0

//The first initializer has a single initialization parameter with an argument label of fromFahrenheit and a parameter name of fahrenheit. The second initializer has a single initialization parameter with an argument label of fromKelvin and a parameter name of kelvin. Both initializers convert their single argument into the corresponding Celsius value and store this value in a property called temperatureInCelsius.

//Parameter Names and Argument Labels

//As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer’s body and an argument label for use when calling the initializer.

//However, initializers do not have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.

//The following example defines a structure called Color, with three constant properties called red, green, and blue. These properties store a value between 0.0 and 1.0 to indicate the amount of red, green, and blue in the color.

//Color provides an initializer with three appropriately named parameters of type Double for its red, green, and blue components. Color also provides a second initializer with a single white parameter, which is used to provide the same value for all three color components.

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

//Both initializers can be used to create a new Color instance, by providing named values for each initializer parameter:
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//Note that it is not possible to call these initializers without using argument labels. Argument labels must always be used in an initializer if they are defined, and omitting them is a compile-time error:
//
//let veryGreen = Color(0.0, 1.0, 0.0)
// this reports a compile-time error - argument labels are required

//Initializer Parameters Without Argument Labels

//If you do not want to use an argument label for an initializer parameter, write an underscore (_) instead of an explicit argument label for that parameter to override the default behavior.

//Here’s an expanded version of the Celsius example from Initialization Parameters above, with an additional initializer to create a new Celsius instance from a Double value that is already in the Celsius scale:


struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius is 37.0

//The first initializer has a single initialization parameter with an argument label of fromFahrenheit and a parameter name of fahrenheit. The second initializer has a single initialization parameter with an argument label of fromKelvin and a parameter name of kelvin. Both initializers convert their single argument into the corresponding Celsius value and store this value in a property called temperatureInCelsius.


//Parameter Names and Argument Labels

//As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer’s body and an argument label for use when calling the initializer.
//
//However, initializers do not have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.
//
//The following example defines a structure called Color, with three constant properties called red, green, and blue. These properties store a value between 0.0 and 1.0 to indicate the amount of red, green, and blue in the color.
//
//Color provides an initializer with three appropriately named parameters of type Double for its red, green, and blue components. Color also provides a second initializer with a single white parameter, which is used to provide the same value for all three color components.

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

//Both initializers can be used to create a new Color instance, by providing named values for each initializer parameter:

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//Note that it is not possible to call these initializers without using argument labels. Argument labels must always be used in an initializer if they are defined, and omitting them is a compile-time error:

//let veryGreen = Color(0.0, 1.0, 0.0)
// this reports a compile-time error - argument labels are required
//Missing argument labels 'red:green:blue:' in call

//Initializer Parameters Without Argument Labels

//If you do not want to use an argument label for an initializer parameter, write an underscore (_) instead of an explicit argument label for that parameter to override the default behavior.

//We could put initializers inside extensions... cool!
//extension Celsius {
//    init(_ celsius: Double) {
//        temperatureInCelsius = celsius
//    }
//}

struct Celsius1 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius1(37.0)
// bodyTemperature.temperatureInCelsius is 37.0

//The initializer call Celsius(37.0) is clear in its intent without the need for an argument label. It is therefore appropriate to write this initializer as init(_ celsius: Double) so that it can be called by providing an unnamed Double value.

//Optional Property Types

//If your custom type has a stored property that is logically allowed to have “no value”—perhaps because its value cannot be set during initialization, or because it is allowed to have “no value” at some later point—declare the property with an optional type. Properties of optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization.
//
//The following example defines a class called SurveyQuestion, with an optional String property called response:

struct Objective {
    var description: String?
    
    init(description: String) {
        self.description = description
    }
}


//class SurveyQuestion {
//    var text: String
//    var response: String?
//    init(text: String) {
//        self.text = text
//    }
//    func ask() {
//        print(text)
//    }
//}
//let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
//cheeseQuestion.ask()
//// Prints "Do you like cheese?"
//cheeseQuestion.response = "Yes, I do like cheese."

//The response to a survey question cannot be known until it is asked, and so the response property is declared with a type of String?, or “optional String”. It is automatically assigned a default value of nil, meaning “no string yet”, when a new instance of SurveyQuestion is initialized.

//Assigning Constant Properties During Initialization

//You can assign a value to a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.

//NOTE

//For class instances, a constant property can be modified during initialization only by the class that introduces it. It cannot be modified by a subclass.

//You can revise the SurveyQuestion example from above to use a constant property rather than a variable property for the text property of the question, to indicate that the question does not change once an instance of SurveyQuestion is created. Even though the text property is now a constant, it can still be set within the class’s initializer:

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"

//Default Initializers

//Swift provides a default initializer for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.
//
//This example defines a class called ShoppingListItem, which encapsulates the name, quantity, and purchase state of an item in a shopping list:

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

//Because all properties of the ShoppingListItem class have default values, and because it is a base class with no superclass, ShoppingListItem automatically gains a default initializer implementation that creates a new instance with all of its properties set to their default values. (The name property is an optional String property, and so it automatically receives a default value of nil, even though this value is not written in the code.) The example above uses the default initializer for the ShoppingListItem class to create a new instance of the class with initializer syntax, written as ShoppingListItem(), and assigns this new instance to a variable called item.

// Memberwise Initializers for Structure Types

//Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.
//
//The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.
//
//The example below defines a structure called Size with two properties called width and height. Both properties are inferred to be of type Double by assigning a default value of 0.0.
//
//The Size structure automatically receives an init(width:height:) memberwise initializer, which you can use to initialize a new Size instance:

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

// Why this name? Whe Memberwise Initializer?
// The answer is: The deafault initializars, usually, have just parentheses. The meberwise initializer receive arguments, and this arguments are values for it's properties.

//According to Stackoverflow(https://stackoverflow.com/questions/38001021/why-it-is-called-the-memberwise-initialiser): Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.

//We are talking about structs:
//
//When creating a struct you can use the default initializer (the pair of parentheses) if all properties have a default value.
//
//If you just declare the properties without a default value, the compiler creates an implicit memberwise initializer – which you have to use – to make sure to assign a default value to each property in a very convenient way

//When you call a memberwise initializer, you can omit values for any properties that have default values. In the example above, the Size structure has a default value for both its height and width properties. You can omit either property or both properties, and the initializer uses the default value for anything you omit—for example:
//OBS: Maybe it's not corretc any more... I made a test and YOU CAN'T OMIT EITHER PROPERTY

struct MySize {
    var width = 2.0, height = 2.0
}

//let mySize = MySize(height: 2.0)
//error: Initializers.xcplaygroundpage:237:14: error: cannot invoke initializer for type 'MySize' with an argument list of type '(height: Double)'
//let mySize = MySize(height: 2.0)
//    ^
//
//    Initializers.xcplaygroundpage:237:14: note: overloads for 'MySize' exist with these partially matching parameter lists: (width: Double, height: Double), ()
//let mySize = MySize(height: 2.0)

//Answer for that: It's just works on swift 5.1 https://stackoverflow.com/questions/56586158/struct-memberwise-initialization-omitting-values-for-properties-that-have-defa

let zeroByTwo = Size(width:2.0, height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"
// WTF ?? Apparently you can't omit just one property
//error: Initializers.xcplaygroundpage:232:17: error: cannot invoke initializer for type 'Size' with an argument list of type '(height: Double)'
//let zeroByTwo = Size(height: 2.0)
//    ^
//
//    Initializers.xcplaygroundpage:232:17: note: overloads for 'Size' exist with these partially matching parameter lists: (width: Double, height: Double), ()
//let zeroByTwo = Size(height: 2.0)
//^

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"

//Initializer Delegation for Value Types

//Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.

//The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, as described in Inheritance. This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization. These responsibilities are described in Class Inheritance and Initialization below.

//For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.

//Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type. This constraint prevents a situation in which additional essential setup provided in a more complex initializer is accidentally circumvented by someone using one of the automatic initializers.


//NOTE
//
//If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation. For more information, see Extensions.

//Proof:

struct Vertex {
    var x = 1, y = 0
}

extension Vertex {
    init(y: Int) {
        self.y = y
    }
}

// Custom init
let firstVertex = Vertex(y: 2)
// Orignial meberwise init
let secondVertex = Vertex(x: 1, y: 3)
// Default init
let thirdVertex = Vertex()

// If we modify the initializer directly on the struct:

struct Edge {
    var v0 = Vertex(y: 1), v1 = Vertex(x: 1, y: 0)
    
    init(v1: Vertex) {
        self.v1 = v1
    }
}
// Custom init
let firstEdge = Edge(v1: Vertex(y: 5))
// Original meberwise init
//let secondEdge = Edge(v0: Vertex(x: 3, y: 4), v1: Vertex(x: 7, y: 10))
// error: Initializers.xcplaygroundpage:309:27: error: extra argument 'v0' in call
//let secondEdge = Edge(v0: Vertex(x: 3, y: 4), v1: Vertex(x: 7, y: 10))
//^~~~~~~~~~~~~~~~~~
// As expected it fails :)
