//
//  ViewController.swift
//  WarCards
//
//  Created by Eram on 17/03/2018.
//  Copyright © 2018 Eram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let gameViewSegueID = "showGameView"
    @IBAction func startGameAction(_ sender: Any) {
        performSegue(withIdentifier: gameViewSegueID, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

