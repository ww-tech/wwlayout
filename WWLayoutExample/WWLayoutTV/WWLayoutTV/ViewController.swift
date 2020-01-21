//
//  ViewController.swift
//  WWLayoutTV
//
//  Created by Steven Grosmark on 1/7/20.
//  Copyright © 2020 WW International. All rights reserved.
//

import UIKit
import WWLayout

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        let matrixGreen = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        
        let label = UILabel()
        label.text = "Bonsoir, Elliot"
        label.font = UIFont.monospacedSystemFont(ofSize: 48, weight: .medium)
        label.textColor = matrixGreen
        
        view.addSubview(label)
        label.layout.center(in: .superview)
        
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitleColor(matrixGreen, for: .normal)
        button.setTitle("ⓘ", for: .normal)
        button.layer.cornerRadius = 11
        button.layer.masksToBounds = true
        
        view.addSubview(button)
        button.layout
            .centerX(to: .superview)
        .size(80)
            .bottom(to: .safeArea, offset: -30)
    }

}
