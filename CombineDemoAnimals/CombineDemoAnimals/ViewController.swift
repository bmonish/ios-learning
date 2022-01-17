//
//  ViewController.swift
//  reactive-todo
//
//  Created by monish-pt4649 on 17/01/22.
//

import Combine
import UIKit

class AnimalsViewController: UITableViewController {
    
    var animals = [Animal]()
    
    var tokens = Set<AnyCancellable>()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAnimals()
    }
    
    var getAnimalsToken: AnyCancellable?
    func getAnimals() {
        getAnimalsToken = NetworkingService.getAnimals()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("Publisher stopped observing")
                        
                    case .failure(let error):
                        print("This is any error passed to our future", error)
                    }
                },
                receiveValue: { [weak self] (animals) in
                    self?.animals = animals
                    self?.tableView.reloadData()
                }
            )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        
        let animalCell = cell as? AnimalCell
        let animal = animals[indexPath.row]
        
        animalCell?.actionPublisher.sink(receiveValue: { [weak self] action in
            switch action {
            case .showEmoji(let animal):
                self?.showEmoji(for: animal)
                
            case .makeNoise(let animal):
                self?.makeNoise(for: animal)
            }
        }).store(in: &tokens)
        
        animalCell?.populate(with: animal)
        
        return cell
    }
    
    func showEmoji(for animal: Animal) {
        AlertService.showAlert(with: animal.emoji, in: self)
    }
    
    func makeNoise(for animal: Animal) {
        AlertService.showAlert(with: animal.noise, in: self)
    }
}

