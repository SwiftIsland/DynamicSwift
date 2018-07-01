import Foundation

struct Topic {
    let name: String
    let mentors: [Mentor]
}

struct Mentor {
    let name: String
    let picture: URL
}

struct Companion {
    enum Race {
        case cat
        case dog
    }

    let name: String
    let age: Int
    let race: Race
    let picture: URL
}

class Animal {
    let age: Int

    init(age: Int) {
        self.age = age
    }
}

class Pet: Animal {
    let name: String
    let picture: URL

    init(name: String, age: Int, picture: URL) {
        self.name = name
        self.picture = picture
        super.init(age: age)
    }
}

class Dog: Pet {
    enum Breed {
        case pug
        case poodle
        case bulldog
    }

    let breed: Breed

    init(name: String, age: Int, picture: URL, breed: Breed) {
        self.breed = breed
        super.init(name: name, age: age, picture: picture)
    }
}

class Cat: Pet {
    let numberOfLivesLeft: Int

    init(name: String, age: Int, picture: URL, numberOfLivesLeft: Int) {
        self.numberOfLivesLeft = numberOfLivesLeft
        super.init(name: name, age: age, picture: picture)
    }
}
