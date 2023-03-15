//
//  DetailViewController.swift
//  RickAndMortyProtocol
//
//  Created by Kerem on 12.03.2023.
//

import UIKit
import Kingfisher

protocol DetailViewControllerProtocol {
}

class DetailViewController: UIViewController {

    var imageView = UIImageView()
    var nameLabel = UILabel()

    var chosenIndex = 0

    private let viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.view = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Second"
        
        viewModel.viewDidLoad(id: chosenIndex)
        makeSubViews()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let detail = viewModel.rickAndMortyDetail else { return  }
        
        nameLabel.text = "Name: \(detail.name)"
        imageView.kf.setImage(with: URL(string: detail.image))
    }

}

extension DetailViewController {
    func makeSubViews() {
        view.addSubview(nameLabel)
        view.addSubview(imageView)
        setImageConstraints()
        setNameLabelConstraints()
    }
    
    func setImageConstraints(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        }
    
    func setNameLabelConstraints(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
    }
}

extension DetailViewController: DetailViewControllerProtocol {



}
