//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by 木村　恒輝 on 2016/02/12.
//  Copyright (c) 2016年 木村　恒輝. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imageView1: UIImageView!//上
    @IBOutlet var imageView2: UIImageView!//真ん中
    @IBOutlet var imageView3: UIImageView!//下
    @IBOutlet var resultLabel: UILabel!//スコア表示
    
    
    var timer:NSTimer!//画像を動かすタイマー
    var score:Int = 1000//スコアの値
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()//スコアの保存するための変数
    
    let width: CGFloat = UIScreen.mainScreen().bounds.size.width//画面幅
    var positionX:[CGFloat] = [0.0, 0.0, 0.0]//画像の位置の配列
    var dx:[CGFloat] = [3.0, 0.5, -1.0]//画像の動かす幅の配列
    
    func start(){
        //結果ラベルを見えなくする
        resultLabel.hidden = true
        
        //タイマーを動かす
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: "up", userInfo: nil,repeats: true)
        timer.fire()
        
        
        
        
    }
    func up(){
        
        for i in 0..<3{
            //橋なら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i]*(-1)
            }
            positionX[i] += dx[i]
        }
        imageView1.center.x = positionX[0]
        imageView2.center.x = positionX[1]
        imageView3.center.x = positionX[2]
        
    }
    
    //ストップボタンを押されたら
    @IBAction func stop(){
        let highScore1: Int = defaults.integerForKey("score1")
        let highScore2: Int = defaults.integerForKey("score2")
        let highScore3: Int = defaults.integerForKey("score3")
        
        if timer.valid == true{
            timer.invalidate()//タイマーを止める
        }
        for i in 0..<3{
            score = score - abs(Int(width/2 - positionX[i]))*2//画像のずれたぶんだけスコアから引く
        }
        resultLabel.text = "Score: " + String(score)//スコア表示
        resultLabel.hidden = false
        
        if score > highScore1 {//一位更新
            defaults.setInteger(score, forKey: "score1")//スコア1で保存
            defaults.setInteger(highScore1, forKey: "score2")
            defaults.setInteger(highScore2, forKey: "score3")
        }else if score > highScore2 {//二位更新
            defaults.setInteger(score, forKey: "score2")
            defaults.setInteger(highScore2, forKey: "score3")
        }else if score > highScore3 {//三位更新
            defaults.setInteger(score, forKey: "score3")
        }
        
    }
    
    @IBAction func toTop(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func retry(){
        
        score = 1000//リセット
        positionX = [width/2, width/2, width/2]
        self.start()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]
        self.start()//start呼び出し
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}