//
//  HomeVC.swift
//  ProgramaticUI
//
//  Created by Baran Baran on 11.11.2024.
//

import UIKit
import SnapKit

final class HomeVC: UIViewController {
    
    // MARK: - Properties
    private var balanceArray: [String] = ["20000.00","100000.00"]
    
    // MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 40
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        cv.backgroundColor = .secondarySystemBackground
        
        return cv
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setup(){
        view.addSubview(collectionView)
        
        // Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseID)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.reuseID)
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        // Navigation bar görünümünü özelleştir
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Sola hizalanmış başlık için özel UILabel
        let titleLabel = UILabel()
        titleLabel.text = "Günaydın Baran"
        titleLabel.textColor = .secondarySystemBackground
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        
        // LeftBarButton'a boş bir alan ekle (sola hizalama)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let bellImage = UIImage(systemName: "bell.fill")
        let bellButton = UIBarButtonItem(
            image: bellImage,
            style: .plain,
            target: self,
            action: nil
        )
        bellButton.tintColor = .white

        navigationItem.rightBarButtonItem = bellButton
    }
}

// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeCell.reuseID, for: indexPath ) as? HomeCell else
        { return UICollectionViewCell()}
        
        cell.configure(balance: balanceArray[indexPath.item])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.reuseID, for: indexPath) as? HeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        return headerView
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: .widthScreen * 0.90, height: .widthScreen / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 200)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    
}




// MARK: - Preview
#Preview {
    UINavigationController(rootViewController: HomeVC())
}
