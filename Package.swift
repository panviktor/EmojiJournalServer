// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "EmojiJournalServer",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.8.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
        .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", from: "9.0.0"),
        .package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/Health.git", from: "1.0.0"),
        .package(name: "KituraOpenAPI", url: "https://github.com/IBM-Swift/Kitura-OpenAPI.git", from: "1.1.1"),
        .package(name: "SwiftKueryPostgreSQL", url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL", from: "2.1.1"),
        .package(name: "SwiftKueryORM", url: "https://github.com/IBM-Swift/Swift-Kuery-ORM", from: "0.6.0"),
        .package(name: "Kitura-CredentialsHTTP", url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", from: "2.1.3"),
    ],
    targets: [
        .target(
            name: "EmojiJournalServer",
            dependencies: [
                .target(name: "Application"),
                "Kitura",
                "HeliumLogger"]),
        .target(
            name: "Application",
            dependencies: [
                "Kitura",
                "CloudEnvironment",
                "SwiftMetrics",
                "Health",
                "KituraOpenAPI",
                "SwiftKueryPostgreSQL",
                "SwiftKueryORM",
                .product(name: "CredentialsHTTP", package: "Kitura-CredentialsHTTP"),
                
                ]),
        .testTarget(
            name: "ApplicationTests",
            dependencies: [
                .target(name: "Application"),
                "Kitura",
                "HeliumLogger"]),
    ]
)
