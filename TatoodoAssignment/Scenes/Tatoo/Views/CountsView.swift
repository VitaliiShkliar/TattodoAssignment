//
//  CountsView.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit

class CountsView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    @IBOutlet private weak var pinsCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: bounds.width, height: 36)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CountsView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.pinToSuperview()
    }
    
    func configure(with counts: PostCounts) {
        likesCountLabel.text = "\(counts.likes)"
        commentsCountLabel.text = "\(counts.comments)"
        pinsCountLabel.text = "\(counts.pins)"
    }
}
