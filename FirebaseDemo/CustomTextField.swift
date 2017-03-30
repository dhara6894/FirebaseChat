//
//  CustomTextField.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 30/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 45)
    
    var btnSend: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeholder = "Type message here..."
        backgroundColor = .white
        borderStyle = .none
        autocorrectionType = .no
        rightViewMode = .always
        addRightSendButton()
        self.font = UIFont(name: "Times New Roman", size: 20)
//        var frameset = CGRect()
//        frameset.size.height = 100
//        self.frame = frameset
    }
    
    private func addRightSendButton() {
        let textFieldFrame = CGRect(x: 0, y: 0, width: 45, height: self.frame.size.height)
        let rView = UIView(frame: textFieldFrame)
        
        btnSend = UIButton(type: .custom)
        btnSend.frame = textFieldFrame
        btnSend.adjustsImageWhenHighlighted = false
        btnSend.setImage(UIImage(named: "img_btn_send"), for: .normal)
        
        rView.addSubview(btnSend)
        
        rightView = rView
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
