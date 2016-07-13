//
//  MCLabel.swift
//  TextKit基本使用
//
//  Created by Melody Chan on 16/7/13.
//  Copyright © 2016年 canlife. All rights reserved.
//

import UIKit

class MCLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //MARK: - 懒加载
    //用于存储内容 textStorage中有layoutManager
    private lazy var textStorage = NSTextStorage()
    //用于管理布局 layoutManager中有textContainer
    private lazy var layoutManager = NSLayoutManager()
    //指定绘制容器
    private lazy var textContainer = NSTextContainer()

    override var text: String?{
        didSet{
            //1.修改textStorage存储的内容
            textStorage.setAttributedString(NSAttributedString(string: text!))
            
            textStorage.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(20), range: NSMakeRange(0, text!.characters.count))
            self.checkUrlRegex()
            
            //2.通知layoutManager重新布局
            setNeedsDisplay()
            
        }
    }
    //如果是UILabel调用setNeedsDisplay() 系统会触发drawTextInRect方法
    override func drawTextInRect(rect: CGRect) {
        //重绘
        
        /**
         绘制字形 类似UIView
         - parameter <TglyphsToShow: 绘制范围
         - parameter atPoint:        绘制起点
         */
        
        layoutManager.drawGlyphsForGlyphRange(NSMakeRange(0, text!.characters.count), atPoint: CGPointZero)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSystemInfo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSystemInfo()
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        //3.指定区域
        textContainer.size = self.bounds.size
    }
 
    
    func setupSystemInfo(){
        //1.将layoutManager加入到textStorage
        textStorage.addLayoutManager(layoutManager)
        //2.将textContainer加入到layoutManager
        layoutManager.addTextContainer(textContainer)
        
    }
    
    
    func checkUrlRegex(){
        
        do{
            //创建正则表达式对象
            let detector = try NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingType.Link.rawValue))
            let result = detector.matchesInString(textStorage.string, options: NSMatchingOptions(rawValue:0), range: NSMakeRange(0, textStorage.string.characters.count))
            for res in result{
                let str = (textStorage.string as NSString).substringWithRange(res.range)
                let tempStr = NSMutableAttributedString(string: str)
                tempStr.addAttributes([NSForegroundColorAttributeName: UIColor.orangeColor(),NSFontAttributeName:UIFont.systemFontOfSize(20)], range: NSMakeRange(0, str.characters.count))
                textStorage.replaceCharactersInRange(res.range, withAttributedString: tempStr)
                
            }
        }catch{
            print(error)
        }
    }

}
