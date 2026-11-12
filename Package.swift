// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
   name: "LoggerKit",

   platforms: [
       .iOS(.v15),
       .macOS(.v15),
       .macCatalyst(.v15),
       .tvOS(.v15),
       .visionOS(.v1),
       .watchOS(.v9)
   ],

   products: [
       .library(
           name: "LoggerKit",
           targets: ["LoggerKit"]
       )
   ],

   targets: [
       .target(
           name: "LoggerKit"
       ),

       .testTarget(
           name: "LoggerKitTests",
           dependencies: ["LoggerKit"]
       )
   ],

   swiftLanguageModes: [.v6]
)
