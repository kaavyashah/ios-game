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
    //positions for all squares
    var topLeft = [30, 275]
    var topMiddle = [140, 275]
    var topRight = [250, 275]
    var middleLeft = [30, 385]
    var middleMiddle = [140, 385]
    var middleRight = [250, 385]
    var bottomLeft = [30, 495]
    var bottomMiddle = [140, 495]
    var bottomRight = [250, 495]
    
    //hue difference value, if time allows
    var difference = 0.5;
    
    //how to know if the game should end
    var gameOver = false;
    
    //where the touch occurs
    var touchPoint : (Double, Double) = (0.0, 0.0)
    
    //dictionary mapping from string to UIColor
    var colorVals: [String: UIColor] = ["tLColor": UIColor(red: 0, green: 0, blue: 0, alpha: 1), "tMColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1), "tRColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1), "mLColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1), "mMColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1), "mRColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1), "bLColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1), "bMColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1), "bRColor" : UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
    
    //timer values
    var timer = Timer()
    var seconds = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        // Do any additional setup after loading the view.
    }
    
    //shows the timer values
    @objc func timerUpdate(){
        seconds -= 1
        timerLabel.text = String(seconds)
    }
    
    //generates a random UIColor
    func randomColor()->UIColor{
        let randomRed:CGFloat = CGFloat(arc4random_uniform(256))
        let randomGreen:CGFloat = CGFloat(arc4random_uniform(256))
        let randomBlue:CGFloat = CGFloat(arc4random_uniform(256))
        return UIColor(red: randomRed/255, green: randomGreen/255, blue: randomBlue/255, alpha: 1.0)
    }
    
    //colors all blocks, and assigns a different color to randomly selectred block
    func fillColors(offset: String) {
        let allColor = randomColor()
        for i in colorVals.keys {
            colorVals[i] = allColor
        }
        var newColor = randomColor()
        while (newColor == allColor) {
            newColor = randomColor()
        }
        colorVals[offset] = newColor
    }
    
    //called to start a new round
    func startNewRound() {
        //determines random index for the randomly colored block
        let randomIndex = Int(arc4random_uniform(UInt32(colorVals.count)))
        
        //finds the name of the randomly colored block
        let offsetColor = Array(colorVals.keys)[randomIndex]
        
        //colors all blocks
        fillColors(offset: offsetColor)
        
        //starts the timer
        timer = Timer.scheduledTimer(timeInterval: 1,target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        
        showGrid()
    }
    
    //displays the block grid
    func showGrid() {
        createBlock(xPos: topLeft[0], yPos: topLeft[1], color: colorVals["tLColor"]!)
        createBlock(xPos: topMiddle[0], yPos: topMiddle[1], color: colorVals["tMColor"]!)
        createBlock(xPos: topRight[0], yPos: topRight[1], color: colorVals["tRColor"]!)
        
        createBlock(xPos: middleLeft[0], yPos: middleLeft[1], color: colorVals["mLColor"]!)
        createBlock(xPos: middleMiddle[0], yPos: middleMiddle[1], color: colorVals["mMColor"]!)
        createBlock(xPos: middleRight[0], yPos: middleRight[1], color: colorVals["mRColor"]!)
        
        createBlock(xPos: bottomLeft[0], yPos: bottomLeft[1], color: colorVals["bLColor"]!)
        createBlock(xPos: bottomMiddle[0], yPos: bottomMiddle[1], color: colorVals["bMColor"]!)
        createBlock(xPos: bottomRight[0], yPos: bottomRight[1], color: colorVals["bRColor"]!)
    }
    
    //creates one individual block
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
    
    //finds the point that has been touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first!
        let location = touch.location(in: view)
        print(location.x, location.y)
        touchPoint = (Double(location.x), Double(location.y))
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
