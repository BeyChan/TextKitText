//
//  ViewController.swift
//  TextKit基本使用
//
//  Created by Melody Chan on 16/7/13.
//  Copyright © 2016年 canlife. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentLabel: MCLabel!
    @IBOutlet weak var customTextView: MCTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.text = "百度一下,你就不知道 http://www.baidu.com"
        customTextView.text = "百度一下,你就不知道 http://www.baidu.com"
    }

}

