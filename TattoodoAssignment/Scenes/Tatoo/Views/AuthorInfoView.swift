//
//  AuthorInfoView.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit
import Kingfisher

class AuthorInfoView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
       CGSize(width: bounds.width, height: 70)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AuthorInfoView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.pinToSuperview()
        imageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        super.layoutSubviews()
    }
    
    func configure(with artistDisplayModel: ArtistInfoDisplayModel) {
        nameLabel.text = artistDisplayModel.name
        imageView.kf.setImage(with: artistDisplayModel.imageURL,
                              options: [.transition(.fade(0.3))])
    }
}
