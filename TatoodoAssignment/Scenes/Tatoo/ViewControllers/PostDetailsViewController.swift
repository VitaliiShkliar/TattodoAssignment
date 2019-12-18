//
//  PostDetailsViewController.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit
import Kingfisher

class PostDetailsViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var authorView: AuthorInfoView!
    @IBOutlet private weak var countsView: CountsView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var viewModel: PostDetailsControllerViewModeling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wireViewModel()
        viewModel.getData()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
    }
    
    func wireViewModel() {
        imageView.kf.setImage(with: viewModel.imageURL)
        
        descriptionLabel.text = viewModel.postDescription
        
        viewModel.onAuthorInfoLoaded = { [weak self] model in
            self?.authorView.configure(with: model)
        }
        
        viewModel.onErrorMessageReceived = { [weak self] error in
            self?.alert(message: error)
        }
        
        viewModel.onCountsInfoLoaded = { [weak self] counts in
            self?.countsView.configure(with: counts)
        }
        
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        }
    }
}
