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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myImage:UIImage = UIImage(named: "sample.jpg")! //画像の設定
        
        let myImageView = UIImageView(image: UIImage.ResizeUIImage(myImage, width: self.view.frame.width, height: self.view.frame.height)) // リサイズされたUIImageを指定して、UIImageViewを作る.
                
        myImageView.alpha = 0.35 //透過率
        
        self.view.addSubview(myImageView) //viewにUIImageViewを追加
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

