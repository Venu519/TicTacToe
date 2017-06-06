//
//  ViewController.swift
//  TicTacToe
//
//  Created by Venugopal Reddy Devarapally on 05/06/17.
//  Copyright © 2017 venu. All rights reserved.
//

import UIKit
private let maxGrid = 10
private let minGrid = 3

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picketControl: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TicTacToe"
        picketControl.dataSource = self
        picketControl.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startTheGame(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        controller.gameNumber = CGFloat(minGrid)+CGFloat(picketControl.selectedRow(inComponent: 0))
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxGrid - minGrid + 1
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(minGrid+row)
//    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = String(minGrid+row)
        return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
}

