//
//  SpecialNameLabel.swift
//  Pictures
//
//  Created by Миша on 21.06.2022.
//

import UIKit

class SpecialNameLabel: UILabel {
    
    init(text: String){
        super.init(frame: .zero)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        font = UIFont.systemFont(ofSize: 14)
        textColor = .gray
    }
}
