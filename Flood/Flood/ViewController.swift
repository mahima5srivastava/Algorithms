//
//  ViewController.swift
//  Flood
//
//  Created by MAHIMA on 27/08/20.
//  Copyright © 2020 MAHIMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var side: Int = 0
    @IBOutlet weak var board: UICollectionView!
    @IBOutlet weak var countTextField: UITextField!
    var connectedBoxes: Connections!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBoard()
    }

    func setupBoard() {
        board.register(UINib(nibName: "BoxCell", bundle: nil), forCellWithReuseIdentifier:"Box")
    }
    
    @IBAction func playAction(_ sender: Any) {
        guard let text = countTextField.text, let sideValue = Int(text) else {return}
        side = sideValue
        connectedBoxes = Connections(n: sideValue)
        board.reloadData()
        countTextField.resignFirstResponder()
        self.view.backgroundColor = UIColor.white
    }
    private func updateUIForPercolation() {
        self.view.backgroundColor = UIColor.blue
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return side * side
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = board.dequeueReusableCell(withReuseIdentifier: "Box", for: indexPath) as? BoxCell else {return UICollectionViewCell()}
        var pos: Position = .middle
        if indexPath.item < side {
            pos = .top
        } else if indexPath.item >= (side * side) - side {
            pos = .bottom
        }
        let box = Box(val: indexPath.item, state: .solid, position: pos)
        cell.setupCell(for: box)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(300/side)
        return CGSize(width: height, height: height)
    }
}
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let intVal = Int(text + string) else {return true}
        if string == "" {
            return true
        } else if intVal > 18 {
            return false 
        } else {
             return true
        }
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let adjacentBoxes = getBrokenNeighbours(from: getAdjacentValues(for: indexPath.item))
        guard let selectedBox = collectionView.cellForItem(at: indexPath) as? BoxCell else {return}
        if selectedBox.position == .top {
            selectedBox.state = .filled
            updateConnectedBoxes(for: selectedBox.value, neighbours: adjacentBoxes)
            checkPercolation()
            return
        }
        if isAdjacentFlooded(for: adjacentBoxes) {
           selectedBox.state = .filled
        } else {
           selectedBox.state = .broken
        }
        updateConnectedBoxes(for: selectedBox.value, neighbours: adjacentBoxes)
       checkPercolation()
    }
    func checkPercolation () {
        if connectedBoxes.checkPercolation() {
            updateUIForPercolation()
        }
    }
    func updateConnectedBoxes(for selectedBox: Int, neighbours: [Int]) {
        for neighbour in neighbours {
            connectedBoxes.union(a: selectedBox, b: neighbour)
        }
    }
    func isAdjacentFlooded(for values: [Int]) -> Bool {
        for value in values {
            if (board.cellForItem(at: IndexPath(item: value, section: 0)) as? BoxCell)?.state == .filled {
                return true
            }
        }
        return false
    }
    func getBrokenNeighbours(from values: [Int]) -> [Int] {
        var boxArr: [Int] = []
        for i in values {
            if let boxCell = board?.cellForItem(at: IndexPath(item: i, section: 0)) as? BoxCell, (boxCell.state == .broken ||  boxCell.state == .filled) {
                boxArr.append(i)
            }
        }
        return boxArr
    }
    func getAdjacentValues(for index: Int) -> [Int] {
        var values: [Int] = []
        if index - side >= 0 {
            values.append(index - side) //top
        }
        if index + side <= (side * side - 1) {
            values.append(index + side) //bottom
        }
        if index + 1 <= (side * side - 1) && (index + 1) % side != 0 {
            values.append(index + 1) //right
        }
        if index - 1 >= 0 && index % side != 0 {
            values.append(index - 1) //left
        }
        return values
    }
}
