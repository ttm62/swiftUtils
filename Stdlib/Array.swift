import Foundation

// MARK: Stack - LIFO
public
extension Array {
    mutating
    func push(newElement: Element) {
        self.append(newElement)
    }
    
    mutating
    func pop() -> Element? {
        return self.removeLast()
    }
    
    func peekAtStack() -> Element? {
        return self.last
    }
}

// MARK: Queue - FIFO
public
extension Array {
    mutating
    func enqueue(newElement: Element) {
        self.append(newElement)
    }
    
    mutating
    func dequeue() -> Element? {
        return self.removeFirst()
    }
    
    func peekAtQueue() -> Element? {
        return self.first
    }
}

// do {

//     func addRecent(value: Int) {
//         x = x.reversed()
//         if x.count >= 3 {
//             x.dequeue()
//         }
//         x.enqueue(newElement: value)
//         x = x.reversed()
//     }

//     var x: [Int] = []

//     addRecent(value: 8)
//     print(x)
//     addRecent(value: 9)
//     print(x)
//     addRecent(value: 0)
//     print(x)
//     addRecent(value: 3)
//     print(x)
//     addRecent(value: 2)
//     print(x)
//     addRecent(value: 1)
//     print(x)
// }