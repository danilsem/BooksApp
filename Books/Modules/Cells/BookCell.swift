//
//  BookCell.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import UIKit
import SDWebImage

class BookCell: UITableViewCell {

    static let nib = UINib(nibName: "BookCell", bundle: nil)
    static let identifier = "BookCell"
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    private var viewModel: BookViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: BookViewModel) {
        self.viewModel = viewModel
        
        bookTitle.text = "\(viewModel.title)"
        bookDescription.text = "\(viewModel.description)"
        bookImage.sd_setImage(
            with: URL(string: viewModel.imageUrl),
            placeholderImage: UIImage(named: "placeholder"),
            options: [.transformAnimatedImage]
        )
        
        bookmarkButton.setImage(
            viewModel.isFavorite ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark"),
            for: .normal
        )
    }
    
    @IBAction func didTapBookmarkButton(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        
        viewModel.swapFovoriteState()
        
        if viewModel.isFavorite {
            bookmarkButton.setImage(
                UIImage(systemName: "bookmark.fill"),
                for: .normal
            )
        }
        else {
            bookmarkButton.setImage(
                UIImage(systemName: "bookmark"),
                for: .normal
            )
        }
    }
}
