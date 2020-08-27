import UIKit

var connections: [Int] = []
var counter = 0
func union(a: Int, b: Int) {
    while connections.count <= a {
        connections.append(0)
    }
    while connections.count <= b {
        connections.append(0)
    }
    let valA = connections[a]
    let valB = connections[b]
    counter += 1
    connections[a] = counter
    connections[b] = counter
    for i in 0..<connections.count  {
        if (connections[i] == valA && valA != 0) || (connections[i] == valB && valB != 0) {
            connections[i] = counter
        }
    }
}

func connected(a: Int, b: Int) -> Bool {
    return connections[a] == connections[b]
}
func connectionsCount() -> Int {
    var counter: [Int: Int] = [:]
    for i in connections {
         counter[i] = (counter[i] ?? 0) + 1
    }
    return counter.keys.count
}

union(a: 1,b: 2)
union(a: 3,b: 4)
union(a: 5,b: 6)
union(a: 7,b: 8)
union(a: 7,b: 9)
union(a: 9,b: 1)
union(a: 5, b: 0)
print(connected(a: 1, b: 9))
print(connected(a: 6, b: 0))
print(connected(a: 1, b: 0))
print(connected(a: 1, b: 9))
print(connections)
print(connectionsCount())

