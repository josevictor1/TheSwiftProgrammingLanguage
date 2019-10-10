// Memory Safety

// Structure
// Understanding Conflicting Access to Memory
// Characteristics of Memory Access
// Conflicting Access to In-Out Parameters
// Conflicting Access to self in Methods
// Conflicting Access to Properties


// Basically, the memory safety  is focused in the permission type to handle a resource, and this resoucre is memory of course...

// The most part of the problems are caused by acess/permission conflict.
// We have some special situations that occurs conflicts:
// - two process try to access the same resouce with the same level
// - memory location access (if it computed var, enum, struct)

// We have some types of permission
// - long-term // can write before or after the permission gived
// - instantaneous // can overlap

// In fact the memory safety is resumed in what permission you have over a resource: memory. This define a race condition.
// Synchronous
// In general, the compiler won't allows you to get a memory access conflict. When it occurs we'll get an error.
// Asynchronous
// In synchronous we have the thread sanitizer.

// When this will occurs:

// - Inout methods acessing the same instance:

//struct Counter {
//    var count: Int
//
//    mutating func counting(counter: inout Int) {
//        count += counter
//    }
//}
//
//
//var myCounter = Counter(count: 3)
//myCounter.counting(counter: &myCounter.count)
//error: MemorySafety.xcplaygroundpage:34:1: error: overlapping accesses to 'myCounter', but modification requires exclusive access; consider copying to a local variable
//myCounter.counting(counter: &myCounter.count)
//^~~~~~~~~
// This happens why myCounter try  to write in count, but count is his own variable. It gains the write access over the counter in the begin of the function and requires write access over count to... when it occurss we have an access conflict

// Is almost the same thing that happens here

ImagePresenter.showImage(with: "https://docs.swift.org/swift-book/_images/memory_increment_2x.png")


//GAPS:
// - What is about memory safety ?
//Memory safety is about access memory location without access conflicts. The access conflicts occurs when some diferent codes try to access (read/write) the same location... and the sometimes change this location (write) simutaneously
// Memory safety is about multiple access in the memory location. Swift look after you in the most part of the cases given different permission acess to acessed location mamory. This way we have memory safety.
// - Which are the environment caracteristics that colaborate to this happens?
//diferent codes try to access (read/write) the same location... and the sometimes change this location (write) simutaneously
// - Just happens in this sitiuation ?
// could happen in overlap in long-term acess
// - Why this just happens with global variables?
// It no just about global variables ... is about inout parammeters too...

// There some context that we can have problems with memory safety: access permition, location of access and time of access.

// When we have conflicting access with in-out parameters ?

var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}
//
//increment(&stepSize)
//Simultaneous accesses to 0x11f183050, but modification requires exclusive access.
//Previous access (a modification) started at  (0x11f184441).

// We have conflicting access with in-out parameters when we try to access the same memory location twice. In this case, the function will have write access to all in-out parameters after evaluating non-in-out parameters. Long-term access will prevail in the entire duration of that functions call.

// One way to solve this problem is making a copy of stepSize

var copyOfStepSize = stepSize
increment(&copyOfStepSize)

//Update the orinal
stepSize = copyOfStepSize

// It's happening why the read permission overs before the function gains the write permission, so there isn't conflict.

// We can face another situation related to in-out parameters. When we have a single variable as an argument for a function that has two parameters, a conflict happens.

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)
// balance(&playerOneScore, &playerOneScore) Error!
// This conflict occurs because the compiler try to give wirte access to times... whe access playerOneScore by x and y.
// we are trying to acess the same location at the same time

//Conflicting Access To Self Method

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria) // OK

//That's ok. The compiler gives write access to inout parameter and the accessed parameter is maria. Inside the method, the oscar is accessed by self-reference, and it's ok because we are accessing it for the first time. There's no conflict on the overlap.

//oscar.shareHealth(with: &oscar)
//The editor:
//Inout arguments are not allowed to alias each other
//Overlapping accesses to 'oscar', but modification requires exclusive access; consider copying to a local variable

//The compiler:
//error: MemorySafety.xcplaygroundpage:130:25: error: inout arguments are not allowed to alias each other
//oscar.shareHealth(with: &oscar)
//                        ^~~~~~
//
//MemorySafety.xcplaygroundpage:130:1: note: previous aliasing argument
//oscar.shareHealth(with: &oscar)
//^~~~~

//As the editor show us, by write(modification). That way, we get an error because write(modification) requires exclusive access. When we pass oscar as a parameter to share health method, we are trying to get write access two times: when we use inout parameter and when we access self inside the method.

//Conflicting Access to Properties

//Types like structures, and enumerations are made up of individual constituent values, such as the properties of a structure or the elements of a tuple. Because they are value type mutaiting any piece of the value mutates the whole value. Then if we try to access structure propertie with write access, we will obtain the access to the entire propertie.

struct Circle {
    var radius: Int
    var circunference: Int
}

var circle = Circle(radius: 12, circunference: 10)

//balance(&circle.radius, &circle.circunference)//Error
// When it try to overlapping we get a access conflict

// But there some situations that we can overlapping safety. To do that is necessary prove to the compiler that is everything ok.
// Situations:
// You're acessing only stored properties of an instance, not computed properties or class properties.
// The structure is the value of a local variable, not a global variable.
// The structure is either not captured by any closures or it's captured only by nonescaping closures.

//Ex:

func someFunction() {
    var circle = Circle(radius: 12, circunference: 10)
    balance(&circle.radius, &circle.circunference)
}

someFunction()
