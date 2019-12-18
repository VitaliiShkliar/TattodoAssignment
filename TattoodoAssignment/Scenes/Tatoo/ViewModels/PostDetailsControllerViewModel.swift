//
//  PostDetailsControllerViewModel.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//
import Foundation

protocol PostDetailsControllerViewModeling: class {
    var onAuthorInfoLoaded: ((ArtistInfoDisplayModel) -> Void)? { get set }
    var onLoadingStateChange: BoolCompletion? { get set }
    var onErrorMessageReceived: StringCompletion? { get set }
    var onCountsInfoLoaded: ((PostCounts) -> Void)? { get set }
    var imageURL: URL? { get }
    var postDescription: String { get }
    func getData()
}

class PostDetailsControllerViewModel: PostDetailsControllerViewModeling {
    
    // MARK: - Properties
    private let postListModel: PostListModel
    private let repository: PostsRepository
    var onAuthorInfoLoaded: ((ArtistInfoDisplayModel) -> Void)?
    var onLoadingStateChange: BoolCompletion?
    var onErrorMessageReceived: StringCompletion?
    var onCountsInfoLoaded: ((PostCounts) -> Void)?
    var imageURL: URL? { URL(string: postListModel.image.url) }
    var postDescription: String { postListModel.description }
    
    private var isLoading: Bool = false {
        didSet {
            onLoadingStateChange?(isLoading)
        }
    }
    
    // MARK: - Methods
    init(postsRepo: PostsRepository, postModel: PostListModel) {
        postListModel = postModel
        repository = postsRepo
    }
    
    func getData() {
        isLoading = true
        repository.getDatailsForPost(with: postListModel.id) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .failure(let error):
                self?.onErrorMessageReceived?(error.localizedDescription)
            case .success(let postDetails):
                guard let info = self?.getArtistInfoDisplayModel(for: postDetails.artist) else { return }
                self?.onAuthorInfoLoaded?(info)
                self?.onCountsInfoLoaded?(postDetails.counts)
            }
        }
    }
    
     func getArtistInfoDisplayModel(for artist: Artist) -> ArtistInfoDisplayModel {
        let url = URL(string: artist.imageUrl)
        return ArtistInfoDisplayModel(imageURL: url, name: artist.username)
    }
}
