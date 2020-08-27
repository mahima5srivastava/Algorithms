import UIKit

struct Connections {
    var values: [Int] = []
    init(n: Int) {
        values = Array(sequence(first: 0, next: { (val) -> Int? in
            if val < n {
                return val + 1
            }
            return nil
        }))
    }
    mutating func union(a: Int, b: Int) {
        let rootInfoA = getRootAndWeight(of: a)
        let rootInfoB = getRootAndWeight(of: b)
        if rootInfoA.weight > rootInfoB.weight {
            values[b] = rootInfoA.root
        } else {
            values[a] = rootInfoB.root
        }
    }
    func isConnected(a: Int, b: Int) -> Bool {
        let rootA = getRootAndWeight(of: a).root
        let rootB = getRootAndWeight(of: b).root
        return rootA == rootB
    }
    private func getRootAndWeight(of val: Int) -> (root: Int, weight: Int ){
        var index = val
        var weight = 0
        while values[index] != index {
            index = values[index]
            weight += 1
        }
        return (index, weight)
    }
}
var connections = Connections(n: 9)
print(connections.values)
connections.union(a: 1, b: 2)
connections.union(a: 3, b: 4)
connections.union(a: 5, b: 6)
connections.union(a: 7, b: 8)
connections.union(a: 7, b: 9)
connections.union(a: 5, b: 0)
connections.union(a: 1, b: 9)
print(connections.isConnected(a: 1, b: 9))
print(connections.isConnected(a: 6, b: 0))
print(connections.isConnected(a: 3, b: 4))
print(connections.isConnected(a: 1, b: 0))
