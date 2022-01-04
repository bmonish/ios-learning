import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class TextFieldViewController : UIViewController, UITextFieldDelegate {

    var label : UILabel = UILabel()
    var textField : UITextField!

    // Publisher
    var textMessage = CurrentValueSubject<String, Never>("Hello World")
    
    // Set to Store subscriptions
    var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {

        // setup UI with textField and label
        let view = UIView()
        view.backgroundColor = .white

        textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = textMessage.value
        view.addSubview(textField)

        label = UILabel()
        view.addSubview(label)

        // Instead of doing things
        //label.text = textMessage.value
        
        // we can use Combine: assign(to,on)
        // Creating a subscriber and storing it in subscriptions
        textMessage
            .compactMap({  $0 })
            .map({ "You typed: \($0)" })
            .assign(to: \.text, on: label)
            .store(in: &subscriptions)

        self.view = view

        // set Autolayout constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
        ])

        
        //update label whenever textValue changes
        textField.addTarget(self, action: #selector(updateText), for: .editingChanged)
    }

    @objc func updateText() {
        print("updating")
        // Updating the publishers value which then passes it to the subscription as data stream
        self.textMessage.value = textField.text ?? ""
    }
}

let controller = TextFieldViewController()

PlaygroundPage.current.liveView = controller
