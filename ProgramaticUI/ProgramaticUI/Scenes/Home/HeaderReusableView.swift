
import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    static let reuseID: String = "HeaderCollectionReusableView" // Header view için reuse ID'si
    
    // MARK: - UI Elements
    // Başlık etiketi (titleLabel)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    // Kaydırılabilir görselleri eklemek için ScrollView
    private lazy var imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true // Sayfalama aktif
        scrollView.showsHorizontalScrollIndicator = false // Yatay kaydırma göstergesini gizle
        scrollView.delegate = self // Kaydırma işlemleri için delegate
        return scrollView
    }()
    
    // Sayfa kontrolü için PageControl
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2  // 2 sayfa (sarı ve mavi)
        pageControl.currentPage = 0    // İlk sayfa seçili
        return pageControl
    }()
    
    // MARK: - Initialization
    // Header view başlatma
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layout()  
    }
    
    // Bu init kullanılmıyor, ancak gereklidir
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    // UI elemanlarının yerleşimini düzenleme
    private func layout() {
        addSubview(imageScrollView) // ScrollView'u ekle
        addSubview(pageControl)     // PageControl'u ekle
        
        // ScrollView'un yerleşimi
        imageScrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview() // Üst, sol ve sağ kenarlara sıfırdan hizala
            make.height.equalTo(200)  // ScrollView'un yüksekliği
        }
        
        // PageControl'un yerleşimi
        pageControl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)  // PageControl'u sol kenara 10 birim uzaklıkla yerleştir
            make.bottom.equalToSuperview().offset(-10)  // PageControl'u alt kenara 10 birim uzaklıkla yerleştir
        }
        
        // ScrollView'a görselleri ekleyelim
        let firstHeader: UIView = HeaderView(text: "Son 7 Gün Hesaap Hareketlerini İncele")
        let secondHeader: UIView = HeaderView(text: "Kampanyalardan Haberdar Olmak İçin Tıkla")

        let views: [UIView] = [firstHeader,secondHeader]
        for i in 0..<2 {
            let headerViews = views[i]
            headerViews.frame = CGRect(x: CGFloat(i) * bounds.width, y: 0, width: bounds.width, height: 200) // Görselin konumunu ayarla
            imageScrollView.addSubview(headerViews)  // ScrollView'a ekle
        }
        
        // ScrollView'un contentSize'ını ayarla
        imageScrollView.contentSize = CGSize(width: bounds.width * 2, height: 200)  // İçeriğin boyutunu belirle
    }
    
    // MARK: - Configure
    // Başlık metnini ayarlama
    public func configure(text titleText: String) {
        titleLabel.text = titleText // titleLabel'a başlık metnini ata
    }
}


// MARK: - UIScrollViewDelegate
extension HeaderCollectionReusableView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / bounds.width) // Geçerli sayfayı hesapla
        pageControl.currentPage = page // PageControl'daki aktif sayfayı güncelle
    }
}



