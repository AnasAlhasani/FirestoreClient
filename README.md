# FirestoreClient 🔥

<p align="justify">
    <img src="https://app.bitrise.io/app/e3bc37ec74219dc7/status.svg?token=QIzG7rPS8Vd1F2Bc8uDScw&branch=master" />
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" />
    <img src="https://img.shields.io/badge/Platforms-iOS-blue.svg?style=flat" />
    <a href="https://cocoapods.org/pods/FirestoreClient">
        <img alt="Cocoapods" src="https://img.shields.io/cocoapods/v/FirestoreClient">
    </a>
    <a href="https://codebeat.co/projects/github-com-anasalhasani-firestoreclient-master">
        <img alt="codebeat badge" src="https://codebeat.co/badges/392c2fcd-7cfa-4f10-90ae-aef00c98e0f7" />
    </a>
</p>

A generic based abstraction layer on top of Firestore.

## Used Libraries

- [**Firebase/Firestore**](https://firebase.google.com/docs/firestore): a scalable NoSQL cloud database to store and sync data for client and server-side development.
- [**Google/Promises**](https://github.com/google/promises): a modern framework that provides a synchronization construct for Swift to facilitate writing asynchronous code.
- [**Identity**](https://github.com/JohnSundell/Identity): a small library that makes it easy to create type-safe identifiers in Swift.

## Features

- Support Codable.
- Support Promises.
- Provide easy to use read and write operations.
- KeyPath based query builder.
- Type-safe identifiers.

## Usage

### Entity

Your model must be conformed to `Entity` protocol which conformed to `Codable`. 
For example:
```swift
struct Book: Entity {
    var id: ID = ""
    var title: String
    var author: String
    var releaseDate: Date?
    var pages: Int
}
```

Conform to `QueryKey` protocol to enable KeyPath query.

```swift
extension Book: QueryKey {
    static var keys: [PartialKeyPath<Book>: CodingKey] {
        return [
            \Self.id: CodingKeys.id,
            \Self.title: CodingKeys.title,
            \Self.author: CodingKeys.author,
            \Self.releaseDate: CodingKeys.releaseDate,
            \Self.pages: CodingKeys.pages
        ]
    }
}
```
### UseCase

The usecase is a protocol which do one specific thing.

```swift
protocol BooksUseCase {
    func loadBooks() -> Promise<[Book]>
    func loadBook(byID id: Book.ID) -> Promise<Book>
    func saveBook(_ book: Book) -> Promise<Void>
    func updateBook(_ book: Book) -> Promise<Void>
    func deleteBook(byID id: Book.ID) -> Promise<Void>
}
``` 

Concrete implmentation of the `BooksUseCase`.

```swift
final class DefaultBooksUseCase<Repository: AbstractRepository> where Repository.Value == Book {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}

extension DefaultBooksUseCase: BooksUseCase {
    func loadBooks() -> Promise<[Book]> {
        return repository.query {
            $0.filter(by: \.author, equal: "George R. R. Martin")
              .order(by: \.releaseDate)
              .limit(to: 5)
        }
    }
    
    func loadBook(byID id: Book.ID) -> Promise<Book> {
        return repository.fetch(byID: id)
    }
    
    func saveBook(_ book: Book) -> Promise<Void> {
        return repository.save(entity: book)
    }
    
    func updateBook(_ book: Book) -> Promise<Void> {
        return repository.update(entity: book)
    }
    
    func deleteBook(byID id: Book.ID) -> Promise<Void> {
        return repository.delete(byID: id)
    }
}
```
### UseCaseFactory 

It helps to hide the concrete implementation of use case.

```swift
protocol UseCaseFactory {
    func makeBooksUseCase() -> BooksUseCase
}

final class DefaultUseCaseFactory: UseCaseFactory {
    func makeBooksUseCase() -> BooksUseCase {
        let path = Path("books")
        let repository = FirestoreRepository<Book>(path: path)
        return DefaultBooksUseCase(repository: repository)
    }
}
```

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate FirestoreClient into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'FirestoreClient'
```

Then, run the following command:

```bash
$ pod install
```

## Author

Anas Alhasani

[![GitHub Follow](https://img.shields.io/github/followers/AnasAlhasani.svg?style=social&label=Follow)](https://github.com/AnasAlhasani)
