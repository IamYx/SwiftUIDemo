//
//  Checker.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/11/24.
//

import UIKit

class Checker: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let squareSize = UIScreen.main.bounds.size.width / 8 - 40 / 8
        self.frame = CGRectMake(0, 0, squareSize, squareSize)
        self.layer.cornerRadius = squareSize / 2
        self.layer.borderWidth = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
