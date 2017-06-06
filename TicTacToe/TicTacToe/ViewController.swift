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
    @IBOutlet weak var p1TextField: UITextField!
    @IBOutlet weak var p2TextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TicTacToe"
        picketControl.dataSource = self
        picketControl.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnView(_:)))
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tappedOnView(_ sender: UITapGestureRecognizer) {
        print("Please Help!")
        p1TextField.resignFirstResponder()
        p2TextField.resignFirstResponder()
    }
    
    @IBAction func startTheGame(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        controller.gameNumber = CGFloat(minGrid)+CGFloat(picketControl.selectedRow(inComponent: 0))
        if p1TextField.text != nil {
            controller.player1.playerName = p1TextField.text!
        }
        if p2TextField.text != nil {
            controller.player2.playerName = p2TextField.text!
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxGrid - minGrid + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = String(minGrid+row)
        return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
}

