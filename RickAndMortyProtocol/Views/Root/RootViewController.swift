//
//  ViewController.swift
//  RickAndMortyProtocol
//
//  Created by Kerem on 5.03.2023.
//

import UIKit


protocol RickAndMortyControllerProtocol {
   func reloadData()
}

class RootViewController: UIViewController {

    private var tableView =  UITableView()
    private let labelTitle : UILabel = UILabel()

    private let viewModel: RootViewModel

    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.view = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        view.addSubview(tableView)
        navigationItem.title = "Rick And Morty"
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        tableView.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.pin(to: view)
    }


}

extension RootViewController : RickAndMortyControllerProtocol{

    func reloadData() {
        tableView.reloadData()
    }
}


extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rickAndMortyResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! RickAndMortyTableViewCell
        cell.set(character: viewModel.rickAndMortyResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = DetailViewController(viewModel: DetailViewModel(rickAndMortyService: viewModel.rickAndMortyService))
        
        viewModel.didSelectItem(at: indexPath)
        destinationVC.chosenIndex = viewModel.id
        navigationController?.pushViewController(destinationVC, animated: true)
    }

}
