//
//  TattoListTableViewCell.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit
import Kingfisher

class PostListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var postDescription: UILabel!
    
    override func prepareForReuse() {
        postImageView.image = nil
        containerView.transform = .identity
        postDescription.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    private func setupAppearance() {
        tintColor = .black
        containerView.layer.cornerRadius = 8
        postImageView.layer.cornerRadius = 8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowRadius = 5
        postImageView.kf.indicatorType = .activity
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isTouched: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isTouched: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isTouched: false)
    }
    
    private func animate(isTouched: Bool) {
        let transform = isTouched ? CGAffineTransform.init(scaleX: 0.97, y: 0.97) : .identity
        UIView.animate(withDuration: 0.2) {
            self.containerView.transform = transform
        }
    }
    
    func configure(with displayModel: PostListCellDisplayModel) {
        postDescription.text = displayModel.text
        postImageView.kf.setImage(with: displayModel.imageURL, options: [.transition(.fade(0.3))])
    }
}
