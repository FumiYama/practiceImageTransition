//
//  ViewController.swift
//  practiceImageTransition
//
//  Created by Fumiya Yamanaka on 2016/01/01.
//  Copyright © 2016年 Fumiya Yamanaka. All rights reserved.
//

import UIKit


extension UIImage {
    
    // Resizeのクラスメソッドを作る.
    class func ResizeUIImage(image : UIImage,width : CGFloat, height : CGFloat)-> UIImage!{
        
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        // コンテキストに画像を描画する.
        image.drawInRect(CGRectMake(0, 0, width, height))
        
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

class ViewController: UIViewController {
    
    var myImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ラスタライズ化の初期化値.
        let initRasterizeValue : CGFloat = 1.0
        
        // スライダーの設定
        let ts_transitionSlider = UISlider()
        ts_transitionSlider.layer.position = CGPointMake(self.view.frame.midX/2, self.view.frame.maxY-50)
        ts_transitionSlider.layer.zPosition = 1
        ts_transitionSlider.minimumValue = 0.0
        ts_transitionSlider.maximumValue = 1.0
        ts_transitionSlider.value = Float(1.0 - initRasterizeValue)
        ts_transitionSlider.addTarget(self, action: "onTransitionValueChanged:", forControlEvents: UIControlEvents.ValueChanged)

        self.view.addSubview(ts_transitionSlider)
        
        let gs_gradationSlider = UISlider()
        gs_gradationSlider.layer.position = CGPointMake(self.view.frame.midX*3/2, self.view.frame.maxY-50)
        gs_gradationSlider.layer.zPosition = 1
        gs_gradationSlider.minimumValue = 0.1
        gs_gradationSlider.maximumValue = 1.0
        gs_gradationSlider.value = Float(1.0 - initRasterizeValue)
        gs_gradationSlider.addTarget(self, action: "onGradiationValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(gs_gradationSlider)
        
        
        
        let myImage:UIImage = UIImage(named: "sample.jpg")! //UIImaegを作る。画像の設定
        
        myImageView = UIImageView(image: UIImage.ResizeUIImage(myImage, width: self.view.frame.width, height: self.view.frame.height)) // リサイズされたUIImageを指定して、UIImageViewを作る.
        if myImageView != nil {
            
            myImageView.alpha = 0 //透過率

            // ラスタライズ化する.
            myImageView!.layer.shouldRasterize = true
            
            // 値の初期化.
            myImageView!.layer.rasterizationScale = initRasterizeValue
            self.view.addSubview(myImageView) //viewにUIImageViewを追加
        }
    }
    
    // slider の値が変わった時に呼ばれるメソッド
    func onTransitionValueChanged(slider: UISlider) {
        if (myImageView != nil) {
            myImageView.alpha = CGFloat(slider.value)
        }
    }
    
    func onGradiationValueChanged(slider: UISlider) {
        if (myImageView != nil) {
            myImageView!.layer.rasterizationScale = CGFloat(1 - slider.value)
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

