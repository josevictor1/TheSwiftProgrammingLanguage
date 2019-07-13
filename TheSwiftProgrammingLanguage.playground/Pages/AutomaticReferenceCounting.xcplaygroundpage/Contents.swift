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

class MyPerson {
    var name: String
    weak var apartment: MyApartment?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person with name \(name) was deallocated")
    }
}


class MyApartment {
    var street: String
    weak var person: MyPerson?
    
    init(street: String) {
        self.street = street
    }
    
    deinit {
        print("Apartment on street\(street) was dealocated")
    }
    
}

var myPerson: MyPerson? = MyPerson(name: "Person1")
var unit4A: MyApartment? = MyApartment(street: "Street1")

myPerson?.apartment = unit4A
unit4A?.person = myPerson

unit4A = nil
myPerson = nil

// Lets
