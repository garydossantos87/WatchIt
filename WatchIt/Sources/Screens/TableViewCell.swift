import UIKit

class TableViewCell: UITableViewCell {

   private var collectionView: UICollectionView?
   static let verticalPadding: CGFloat = 1.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = CGSize(width:80 , height:180)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.backgroundColor = .blue
        collectionView?.register(CollectionCell.self, forCellWithReuseIdentifier: "Cell")
        setupConstraints()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { preconditionFailure("Error") }
    
    // MARK: - Constraints
//
    func setupConstraints() {
        addSubview(collectionView ?? UICollectionView())
//        contentView.addSubview(collectionView)
//        addSubview(contentView)
//        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//
//        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
//
        let margins = contentView.layoutMarginsGuide
        guard let collectionView = collectionView else { return }

        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension TableViewCell {

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        collectionView?.delegate = dataSourceDelegate
        collectionView?.dataSource = dataSourceDelegate
        collectionView?.tag = row
        collectionView?.setContentOffset(collectionView?.contentOffset ?? .zero, animated:false) // Stops collection view if it was scrolling.
        collectionView?.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView?.contentOffset.x = newValue }
        get { return collectionView?.contentOffset.x ?? 0 }
    }
}

class CollectionCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .red
        
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { preconditionFailure("Error") }
}
