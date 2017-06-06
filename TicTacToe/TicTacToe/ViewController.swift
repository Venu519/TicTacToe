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
        self.edgesForExtendedLayout = []
        self.title = "TicTacToe"
        picketControl.dataSource = self
        picketControl.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnView(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
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
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 64{
                let offset = (self.view.frame.size.height - p2TextField.frame.origin.y - p2TextField.frame.size.height) - keyboardSize.height
                self.view.frame.origin.y -= offset
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let offset = (self.view.frame.size.height - p2TextField.frame.origin.y - p2TextField.frame.size.height) - keyboardSize.height
            if self.view.frame.origin.y != 64{
                self.view.frame.origin.y += offset
            }
        }
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

