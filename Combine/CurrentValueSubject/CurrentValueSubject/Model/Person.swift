import Foundation

struct Person {
    var firstName: String
    var lastName: String
    var occupation: String
}

extension Person {
   
    var message: String {
        "\(firstName) \(lastName) is a \(occupation)"
    }
    
    var isValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !occupation.isEmpty
    }
}
