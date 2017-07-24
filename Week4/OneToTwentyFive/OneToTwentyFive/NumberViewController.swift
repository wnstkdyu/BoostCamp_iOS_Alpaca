//
//  NumberViewController.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet var pressToStartBtn: UIButton!
    @IBOutlet var timeLabel: UILabel!
    
    var numberArray = [8, 18, 4, 2, 5, 22, 15, 16, 11, 7, 25, 1, 23, 10, 12, 6, 13, 9, 21, 19, 3, 17, 24, 20, 14]
    var sortedNumberArray = [Int]()
    
    
    // MARK: Function
    @IBAction func homeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressStartButton(_ sender: Any) {
        pressToStartBtn.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in numberButtonCollection {
            button.addTarget(self, action: #selector(gameLogic), for: .touchDown)
        }
        
        distributeNumber()
        sortedNumberArray = numberArray.sorted{ $0 < $1 }
    }
    
    func distributeNumber() {
        for index in numberArray.indices {
            numberButtonCollection[index].setTitle("\(numberArray[index])", for: .normal)
        }
    }
    
    func gameLogic() {
        print(sortedNumberArray)
        let selectedIndex: Int = whichButtonSelected(buttonArray: numberButtonCollection)
        guard let selectedNumber: Int = (numberButtonCollection[selectedIndex].titleLabel?.text as NSString?)?.integerValue else {
            assertionFailure("Cannot downcast")
            return
        }
        
        guard sortedNumberArray.first == selectedNumber else {
            print("Wrong order")
            return
        }
        sortedNumberArray.removeFirst()
        
        let selectedBtn = numberButtonCollection[selectedIndex]
        selectedBtn.isEnabled = false
        selectedBtn.backgroundColor = UIColor.white
        
        // 클리어 조건 검사
        if sortedNumberArray.count == 0 {
            print("Clear!")
            showClearAlert()
            
            return
        }
    }
    
    func whichButtonSelected(buttonArray: [UIButton]) -> Int {
        var selectedIndex: Int = 0
        for index in buttonArray.indices {
            if buttonArray[index].isHighlighted == true {
                selectedIndex = index
            }
        }
        
        return selectedIndex
    }
    
    func showClearAlert() {
        let title = "Clear!"
        let message = "Enter your name"
        let clearAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        clearAlert.addTextField(configurationHandler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        clearAlert.addAction(cancelAction)
        clearAlert.addAction(okayAction)
        
        present(clearAlert, animated: true, completion: nil)
    }
}