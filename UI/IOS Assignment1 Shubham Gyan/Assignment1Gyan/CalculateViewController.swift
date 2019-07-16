//
//  CalculateViewController.swift
//  Assignment1Gyan
//
//  Created by MCDA on 2019-07-16.
//  Copyright © 2019 MCDA. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var primecomposite: UISegmentedControl!
    @IBOutlet weak var evenodd: UISegmentedControl!
    @IBOutlet weak var getNumbertextbox: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func primecompositeIdentifier(_ sender: UISegmentedControl) {
    }
    @IBAction func evenoddIdentifier(_ sender: UISegmentedControl) {
    }
    @IBAction func naturalIdentifier(_ sender: UISegmentedControl) {
    }
    @IBAction func inputTextBox(_ sender: UITextInput) {
    }
    @IBAction func checkMe(_ sender: UIButton) {
        let num: Int? = Int(getNumbertextbox.text ?? "0")
        if(num != nil){
            if num! % 2 == 0 {
                evenodd.selectedSegmentIndex = 0
            } else {
                evenodd.selectedSegmentIndex = 1
            }
        }
        var counter: Int = 0
        for item in 1...(num!/2) {
            if num! % item == 0 {
                counter+=1
                if counter > 1 {
                    break
                }
            }
        }
        if counter > 1 {
            primecomposite.selectedSegmentIndex = 1
        } else {
            primecomposite.selectedSegmentIndex = 0
        }
    }
    @IBAction func checkButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
