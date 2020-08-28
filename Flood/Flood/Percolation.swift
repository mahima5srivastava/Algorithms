//
//  Percolation.swift
//  Flood
//
//  Created by MAHIMA on 27/08/20.
//  Copyright © 2020 MAHIMA. All rights reserved.
//

import Foundation

struct Connections {
    var values: [Int] = []
    var top = 0
    var bottom = 0
    init(n: Int) {
        self.top = (n * n)
        self.bottom = (n * n) + 1
        self.values = Array(sequence(first: 0, next: { (val) -> Int? in
            if val < (n * n) - 1 {
                return val + 1
            }
            return nil
        }))
        self.values.append(top)
        self.values.append(bottom)
        for i in 0..<n {
            union(a: top, b: i)
        }
        for i in (n * n - n)..<(n * n) {
            union(a: bottom, b: i)
        }
    }
    
    mutating func checkPercolation() -> Bool {
        return isConnected(a: top, b: bottom)
    }
    mutating func union(a: Int, b: Int) {
        let rootInfoA = getRootAndWeight(of: a)
        let rootInfoB = getRootAndWeight(of: b)
        if rootInfoA.weight > rootInfoB.weight {
        values[rootInfoB.root] = rootInfoA.root
        } else {
            values[rootInfoA.root] = rootInfoB.root
        }
    }
    mutating func isConnected(a: Int, b: Int) -> Bool {
        let rootA = getRootAndWeight(of: a).root
        let rootB = getRootAndWeight(of: b).root
        return rootA == rootB
    }
    private mutating func getRootAndWeight(of val: Int) -> (root: Int, weight: Int ){
        var index = val
        var weight = 0
        while values[index] != index {
            values[index] = values[values[index]]
            index = values[index]
            weight += 1
        }
        return (index, weight)
    }
}
