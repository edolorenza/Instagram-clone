//
//  CommentController.swift
//  instagram-clone
//
//  Created by Edo Lorenza on 05/05/21.
//

import UIKit

class CommentController: UICollectionViewController {
    //MARK: - Properties
     private let reuseIdentifier = "CommentCell"
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    //MARK: -Helpers
    func configureCollectionView() {
        navigationItem.title = "Comment"
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    //MARK: - API
    
    
}

//MARK: - UICOllectionViewDataSource
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }


}
