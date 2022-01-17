//
//  AnimalCell.swift
//  CombineDemoAnimals
//
//  Created by monish-pt4649 on 17/01/22.
//

import Combine
import UIKit

class AnimalCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var actionPublisher = PassthroughSubject<Action, Never>()
    
    private var animal: Animal!
    
    @IBAction func didTapShowEmojiButton() {
        actionPublisher.send(.showEmoji(animal))
    }
    
    @IBAction func didTapMakeNoiseButton() {
        actionPublisher.send(.makeNoise(animal))
    }
    
    func populate(with animal: Animal) {
        self.animal = animal
        nameLabel.text = animal.name
    }
}

extension AnimalCell {
    enum Action {
        case showEmoji(Animal)
        case makeNoise(Animal)
    }
}
