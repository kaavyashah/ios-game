//
//  GamePlayViewController.swift
//  codeology game
//
//  Created by Kaavya Shah on 10/4/18.
//  Copyright © 2018 Kaavya Shah. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    
    @IBOutlet weak var timerLabel:UILabel!
    var topLeft = [30, 275]
    var topMiddle = [140, 275]
    var topRight = [250, 275]
    var middleLeft = [30, 385]
    var middleMiddle = [140, 385]
    var middleRight = [250, 385]
    var bottomLeft = [30, 495]
    var bottomMiddle = [140, 495]
    var bottomRight = [250, 495]

    var tLColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var tMColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var tRColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var mLColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var mMColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var mRColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var bLColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var bMColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    var bRColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
    
    var timer = Timer()
    var seconds = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1,target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        showGrid()

        // Do any additional setup after loading the view.
    }
    @objc func timerUpdate(){
        seconds -= 1
        timerLabel.text = String(seconds)
    }
    
    func randomSquare() {
        
    }
    
    func showGrid() {
        createBlock(xPos: topLeft[0], yPos: topLeft[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
        createBlock(xPos: topMiddle[0], yPos: topMiddle[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
        createBlock(xPos: topRight[0], yPos: topRight[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
        
        createBlock(xPos: middleLeft[0], yPos: middleLeft[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
        createBlock(xPos: middleMiddle[0], yPos: middleMiddle[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
        createBlock(xPos: middleRight[0], yPos: middleRight[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
        
        createBlock(xPos: bottomLeft[0], yPos: bottomLeft[1], color: UIColor(red: 1, green: 0.456, blue: 0.232, alpha: 1))
        createBlock(xPos: bottomMiddle[0], yPos: bottomMiddle[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
        createBlock(xPos: bottomRight[0], yPos: bottomRight[1], color: UIColor(red: 1, green: 0.556, blue: 0.232, alpha: 1))
    }
    
    func createBlock(xPos: Int, yPos: Int, color: UIColor) {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: xPos, y: yPos, width: 100, height: 100), cornerRadius: 15).cgPath
        layer.fillColor = color.cgColor
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
