// swift-tools-version:5.6

// Package.swift
//
// Copyright (c) 2014 - 2018 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/main/LICENSE.txt
//

import PackageDescription

let package = Package(
  name: "utf8_range",
  platforms: [
	  .iOS(.v12),
	  .macOS(.v10_13),
	  .macCatalyst(.v13),
	  .watchOS(.v5),
	  .tvOS(.v11)
  ],
  products: [
    .library(
        name: "utf8_range",
        targets: ["utf8_range"]
	),
	.library(
        name: "utf8_validity",
        targets: ["utf8_validity"]
	)
  ],
  dependencies: [
	.package(url: "https://github.com/ronnyf/abseil-cpp.git", branch: "release/webrtc"),
	.package(url: "https://github.com/ronnyf/googletest.git", branch: "release/webrtc"),
  ],
  targets: [
    .target(
        name: "utf8_range",
		path: "./",
		sources: [
			"utf8_range_src/"
		],
		publicHeadersPath: "utf8_range_include"
    ),
	.target(
		name: "utf8_validity",
		dependencies: [
			.product(name: "libabsl", package: "abseil-cpp")
		],
		path: "./",
		exclude: [
		],
		sources: [
			"utf8_validity_src/"
		],
		publicHeadersPath: "utf8_validity_include"
	),
//	.target(
//		name: "utf8_lemire",
//		path: "./",
//		sources: [
//			"lemire-avx2.c",
//			"lemire-neon.c",
//			"lemire-sse.c",
//		],
//		publicHeadersPath: "./"
//	),
	.testTarget(
		name: "utf8_validity_test",
		dependencies: [
			"utf8_validity",
			.product(name: "googletest", package: "googletest"),
			
		],
		path: "./",
		sources: [
			"utf8_validity_test.cc"
		],
		cSettings: [
			.headerSearchPath("./")
		]
	)
  ],
  cLanguageStandard: .c11,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx20
)
