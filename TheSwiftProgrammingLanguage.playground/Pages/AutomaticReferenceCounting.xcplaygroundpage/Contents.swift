// Thigs that I don't know about: Automatic Reference Counting

// The Automatic Reference Counting is a swift memory management tool, kind of garbage colector. The diference between a garbage colector is n the way how the process work. The garbage collector works like a separate process trigger by memory. The ARC works integratet with the swift compliller process. That means that while your program is excutring the ARC is watching it. At the first opportunity when the object life cycle ends, the ARC will perform it's job, deallocating the object.

// But ... it's not so simple. Some times objects are related to another objects, and this obectcs retain a reference(a pointer pointing to a specific adress at the memory) to an object that cold be dealocated.

// Ok we have some kind of troubles here:
// 1 - How ARC knows that an object could be dealocated ?
// 2 - How the ARC will perform to dealocate this object ?

// 1 - The object is not in use. If this object is an screen(ViewController)... you alredy pop or dismiss it. If this object is a data class you already turn his reference nil.

// After that you thought OK dude... but I can visulize this situation without an example!

// We have some situations that we need to threat in deallocation:

//1 - We have 2 objects with the same life time
//2 - We have 2 objects one have the life time longer then other
//3 - I forget the third... its a GAP!.

// OK but... if the system don't deallocate the object from memory? Is that a problem?
// Yes, If the memory staty allocated it's stay full... leak of memory...

// What is the name of that situation: retain cycle!

// THere's a cyclic retention ...
// WTF ?
// The objects refer to each other and than... we have a cycle... But what about the rentention...
// good point... the retention is because the system can't deallocate the object...

// Oh the  examples... lets see then ...

// We have some situations... Each Pearson has an Apartment but not each Apartment have a Person...

//class MyPerson {
//    var name: String
//    var apartment: MyApartment?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Person with name \(name) was deallocated")
//    }
//}
//
//
//class MyApartment {
//    var street: String
//    var person: MyPerson?
//
//    init(street: String) {
//        self.street = street
//    }
//
//    deinit {
//        print("Apartment on street\(street) was dealocated")
//    }
//
//}
//
//var myPerson: MyPerson? = MyPerson(name: "Person1")
//var myAppartment: MyApartment? = MyApartment(street: "Street1")
//
//myPerson?.apartment = myAppartment
//myAppartment?.person = myPerson
//
//myPerson = nil
//myAppartment = nil

//bWhen we set nil the deinitializer was not called... than the objects was not deallocated.
// What we can do ?

// there are some points that we need to undestand her: strong, weak and unowned reference...

// strong: reference that holds strongly the object in the memory
// weak: reference that holds weakly the object in the memory, make that reference optional
// unowned: retain the reference of the object but not strongly... the objects can be deallocated
// There's a GAP here... how this types really work in the memory... the correct definition to them ...

// About the way that strong reference works:


//class MyPerson {
//    var name: String
//    var apartment: MyApartment?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Person with name \(name) was deallocated")
//    }
//}
//
//
//class MyApartment {
//    var street: String
//    unowned var person: MyPerson?
//
//    init(street: String) {
//        self.street = street
//    }
//
//    deinit {
//        print("Apartment on street\(street) was dealocated")
//    }
//
//}
//
//var myPerson: MyPerson? = MyPerson(name: "Person1")
//var unit4A: MyApartment? = MyApartment(street: "Street1")
//
//myPerson?.apartment = unit4A
//unit4A?.person = myPerson
//
//myPerson = nil
//unit4A = nil


// Did we solve the reference problem with the reference? Yes, if we set nil first in myPerson... but if we chose unit4A ... this will not work... but why?

// According to the documentation reference you should use unowned when the object that holds the reference has a life time greater or equal than the referenced object
//unowned: Not having an owner.

// If we set just myPerson nil after unit4A we get:

// Person with name Person1 was deallocated
// Apartment on streetStreet1 was dealocated

// It happens because the reference to MyApartment is strong then when the object unit4A is setted nil just the reference var unit4A (strong)-> Apartament turns nil... var unit4A (strong)-> nil

// I thimk unowed do your rule to  to this result... then lets try set the reference to person as weak

//class MyPerson {
//    var name: String
//    var apartment: MyApartment?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Person with name \(name) was deallocated")
//    }
//}
//
//
//class MyApartment {
//    var street: String
//    weak var person: MyPerson?
//
//    init(street: String) {
//        self.street = street
//    }
//
//    deinit {
//        print("Apartment on street\(street) was dealocated")
//    }
//
//}
//
//var myPerson: MyPerson? = MyPerson(name: "Person1")
//var unit4A: MyApartment? = MyApartment(street: "Street1")
//
//myPerson?.apartment = unit4A
//unit4A?.person = myPerson
//
//unit4A = nil
//myPerson = nil

// Same result... about my suposition maybe it's correct according to this results
//Lets try something new... lets change the roles... make then both unowned and weak

//class MyPerson {
//    var name: String
//    unowned var apartment: MyApartment?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("Person with name \(name) was deallocated")
//    }
//}
//
//
//class MyApartment {
//    var street: String
//    unowned var person: MyPerson?
//
//    init(street: String) {
//        self.street = street
//    }
//
//    deinit {
//        print("Apartment on street\(street) was dealocated")
//    }
//
//}
//
//var myPerson: MyPerson? = MyPerson(name: "Person1")
//var unit4A: MyApartment? = MyApartment(street: "Street1")
//
//myPerson?.apartment = unit4A
//unit4A?.person = myPerson
//
//unit4A = nil
//myPerson = nil

// Lets try with weak in both references

class Person {
    
    let name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
        print("The Person's instance with name \(name) was allocated")
    }
    
    deinit {
        print("The Person's instance with name \(name) was deallocated")
    }
}

class Apartment {
    
    let unit4A: String
    weak var tenant: Person?
    
    init(unit4A: String) {
        self.unit4A = unit4A
        print("The Apartment's instace with name \(unit4A) was allocated")
    }
    
    deinit {
        print("The Apartment's instance with name \(unit4A) was deallocated")
    }
    
}

var apartment: Apartment? = Apartment(unit4A: "San Jose")
var person: Person? = Person(name: "Steve")

person?.apartment = apartment
apartment?.tenant = person

//The Apartment's instace with name San Jose was allocated
//The Person's instance with name Steve was allocated

//Until here... everthing is ok!
// with strong reference:
//person = nil
//apartment = nil

// Its not ok :( . Here we have a strong retain cycle between two objects instance.
// Let's go upstairs solve this.

// Let's try some different approachs:

//weak

//person = nil
//apartment = nil

//The Apartment's instace with name San Jose was allocated
//The Person's instance with name Steve was allocated
//The Apartment's instance with name San Jose was deallocated
//The Person's instance with name Steve was deallocated

// We solve the reference cycle here... but .. why?
// Considering the reference counting, person didn't have any strong reference when we declare the variable tenant as being a weak reference, and so don't increasing the person counting reference. Then the object(person) could be deallocated.

// Here we have some situation, we've assigned nil to person before apartment. What will happen if we change the order?

apartment = nil

// Why apartment wasn't deallocated? The strong reference cycle still exist?

// No the strong reference cycle was broked, but the reference to apartment still being strong. How the strong reference still there the apartment can't be dealocated until it's reference counter reachs zero.

// When person is assingned nil we have apartment deallocation.

person = nil

//M A G I C ...
//The Apartment's instace with name San Jose was allocated
//The Person's instance with name Steve was allocated
//The Person's instance with name Steve was deallocated
//The Apartment's instance with name San Jose was deallocated


// unowned

//Unowned here works in the same way. But we need to rember that: unwoned don't consider the reference as optional... than if we use this in the app we could have a crash. It's happens because the system try to use the resource without check it this really still existing. Than when it access that nill object in the memory it get nil! Segmentation fault :( .
// We use unowned when the refered instance have the same life time or longer than the referrer.

class Client {
    let name: String
    var creditCard: CreditCard?
    
    init(name: String) {
        self.name = name
        print("The Client with name \(self.name) was allocated")
    }
    
    deinit {
        print("The Client with name \(self.name) was deallocated")
    }
}


class CreditCard {
    let number: Int
    unowned var client: Client?
    
    init(number: Int) {
        self.number = number
        print("The CreditCard with number \(self.number) was allocated")
    }
    
    deinit {
        print("The CreditCard with number \(number) was deallocated")
    }
}

var client: Client? = Client(name: "Teste")
client?.creditCard = CreditCard(number: 1234566543333)

//client = nil // the referenced object needs to have equal or longer life cycle
//print(creditCard?.client)

//Playground execution failed:
//
//error: Execution was interrupted, reason: signal SIGABRT.
//The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
client = nil
// There is unsafe unowned... we can use this by adding the unsafe word under parenteses unowned(unsafe).

// Scenarios:
//  1 - nil - nil
//  2 - nil - not nil
//  3 - not nil - not nil

//Soution by scenarios:
// 1 - use weak on one instance
// 2 - use unowned on one instance
// 3 - combine unowned with implicitly unwrapped optional property on the other class.

class City {
    let name: String
    unowned let country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

class Country {
    let name: String
    var city: City!
    
    init(name: String, cityName: String) {
        self.name = name
        self.city = City(name: cityName, country: self)
    }
}

let country = Country(name: "Teste", cityName: "Teste Capital")

