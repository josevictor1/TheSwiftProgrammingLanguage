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

increment(&stepSize)
//Simultaneous accesses to 0x11f183050, but modification requires exclusive access.
//Previous access (a modification) started at  (0x11f184441).

// We have conflicting access with in-out parameters when we try to access the same memory location twice. In this case, the function will have write access to all in-out parameters after evaluating non-in-out parameters. Long-term access will prevail in the entire duration of that functions call.
