//
//  ViewController.swift
//  PinterestLayout
//
//  Created by Mohtasim Abrar Samin on 20/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        $0.backgroundColor = .clear
        let layout = PinterestLayout()
        layout.delegate = self
        layout.numberOfColumns = 2
        $0.collectionViewLayout = layout
        
        return $0
    }(UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init()))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError()
        }
        cell.backgroundColor = .random()
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let val = arc4random_uniform(4) + 1
        return CGFloat(100 * val)
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
