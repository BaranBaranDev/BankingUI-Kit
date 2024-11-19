//
//  HomeCell.swift
//  ProgramaticUI
//
//  Created by Baran Baran on 12.11.2024.
//
import UIKit

final class HomeCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseID: String = "HomeCell"
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var redLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true // Corner radius'i düzgün yapabilmek için
        
        // UI elemanlarını ekle ve yerleşimini yap
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(balanceLabel)
        contentView.addSubview(redLineView)
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)  
        }
        
        redLineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(8)
        }
    }
    
    // MARK: - Configure
    public func configure(balance: String) {
        let formattedBalance = formatBalance(balance)
        balanceLabel.attributedText = formattedBalance
    }
    
    private func formatBalance(_ balance: String) -> NSAttributedString {
        let fullText = "Balance: \(balance)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // "Balance:" kısmını kalın yap
        if let range = fullText.range(of: "Balance:") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: nsRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
        }
        
        // Bakiye kısmını daha küçük ve soluk yap
        if let range = fullText.range(of: balance) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: nsRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: nsRange)
        }
        
        return attributedString
    }
}
