//
//  GamePlayViewController.swift
//  codeology game
//
//  Created by Kaavya Shah on 10/4/18.
//  Copyright © 2018 Kaavya Shah. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBlock(xPos: 30, yPos: 275)
        createBlock(xPos: 140, yPos: 275)
        createBlock(xPos: 250, yPos: 275)
        
        createBlock(xPos: 30, yPos: 385)
        createBlock(xPos: 140, yPos: 385)
        createBlock(xPos: 250, yPos: 385)
        
        createBlock(xPos: 30, yPos: 495)
        createBlock(xPos: 140, yPos: 495)
        createBlock(xPos: 250, yPos: 495)



        // Do any additional setup after loading the view.
    }
    
    func createBlock(xPos: Int, yPos: Int) {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: xPos, y: yPos, width: 100, height: 100), cornerRadius: 15).cgPath
        layer.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            var location = touch.location(in: view)
            print(location.x, location.y)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
