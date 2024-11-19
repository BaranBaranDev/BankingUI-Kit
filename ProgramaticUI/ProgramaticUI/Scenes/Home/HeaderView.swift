//
//  HeaderView.swift
//  ProgramaticUI
//
//  Created by Baran Baran on 14.11.2024.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - Properties
    private var text: String?
    private var color: UIColor
    
    // MARK: - UI Elements
    private lazy var textLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = text ?? "nil"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.lineBreakMode = .byClipping
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    
    
    // MARK: - İnitialization
    init(frame: CGRect = .zero, text: String = "", color: UIColor = .clear) {
        self.text = text
        self.color = color
        super.init(frame: frame)
        setup()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup(){
        self.backgroundColor = color
        textLabel.text = text
        addSubview(textLabel)
        
    }
    
    // MARK: - Layout
    private func layout(){
        textLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

