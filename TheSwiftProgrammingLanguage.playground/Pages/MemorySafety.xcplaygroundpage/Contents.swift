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
// Memory safety is about multiple access in the memory location. Swift look after you in the most part of the cases given different permission acess to acessed location mamory. This way we have memory safety.
// - Which are the environment caracteristics that colaborate to this happens?
// - Just happens in this sitiuation ?
// - Why this just happens with global variables?




