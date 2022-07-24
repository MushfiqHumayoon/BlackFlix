//
//  CollectionViewCell.swift
//  BlackFlix
//
//  Created by Mushfiq Humayoon on 23/07/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!

    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    private var cellViewModel: CollectionViewCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(viewModel: CollectionViewCellViewModel) {
        cellViewModel = viewModel
        guard let name = viewModel.name.value, let posterImage = viewModel.posterImage.value else { return }
        let image = UIImage(named: posterImage)
        itemName.text = name
        imageView.image = image
        if itemName.maxNumberOfLines > 1 {
            imageViewHeightConstraint.constant -= (itemName.frame.height * CGFloat(itemName.maxNumberOfLines)) - 8
        } else {
            imageViewHeightConstraint.constant = 0
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        removeObservers()
    }
    private func removeObservers() {
        guard let cellViewModel = cellViewModel else { return }
        cellViewModel.name.removeObserver()
        cellViewModel.posterImage.removeObserver()
    }
}
