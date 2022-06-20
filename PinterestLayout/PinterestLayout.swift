//
//  PinterestLayout.swift
//  PinterestLayout
//
//  Created by Mohtasim Abrar Samin on 20/6/22.
//

import UIKit

protocol PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    var photoHeight: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class PinterestLayout: UICollectionViewLayout {
    
    var delegate: PinterestLayoutDelegate?
    var numberOfColumns = 1
    
    private var cache = [PinterestLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    override class var layoutAttributesClass: AnyClass {
        return PinterestLayoutAttributes.self
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        if cache.isEmpty {
            
            let columnWidth = (width - 45) / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth + CGFloat(( column + 1 ) * 15 ))
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = NSIndexPath(item: item, section: 0)
                let photoHeightGiven = delegate?.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)
                let height = photoHeightGiven! + 60.0
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = frame
                attributes.photoHeight = photoHeightGiven!
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height + 15.0
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
    
}
