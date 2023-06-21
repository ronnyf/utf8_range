// swift-tools-version:5.7

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
		.package(url: "git@github.corp.ebay.com:eBayMobile/abseil-cpp.git", branch: "ebay/release"),
		.package(url: "git@github.corp.ebay.com:eBayMobile/googletest.git", branch: "ebay/release"),
	],
	targets: [
		.target(
			name: "utf8_range",
			path: "utf8_range_src",
			sources: [
				"naive.c",
				"range-avx2.c",
				"range-neon.c",
				"range-sse.c",
				"range2-sse.c",
				"range2-neon.c",
			],
			publicHeadersPath: "."
		),
		.target(
			name: "utf8_validity",
			dependencies: [
				.product(name: "strings", package: "abseil-cpp"),
				.product(name: "string_view", package: "abseil-cpp"),
			],
			path: "utf8_validity_src",
			exclude: [
			],
			sources: [
				"utf8_validity.cc"
			],
			publicHeadersPath: "."
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
	],
	cLanguageStandard: .gnu11,
	cxxLanguageStandard: .gnucxx20
)
