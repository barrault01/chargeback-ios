[![Build Status](https://www.bitrise.io/app/e69001a14e898755.svg?token=0UQPNSuNc9fyaSw78Bfnzw&branch=master)](https://www.bitrise.io/app/e69001a14e898755)

[![Git license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/ant_one/my-private-cocoapods-repository/src/master/LICENSE)


ChargeBack
=============

## Installation

### CocoaPods

Add this to your Podfile: 

`source 'git@bitbucket.org:ant_one/my-private-cocoapods-repository.git'`

And

`pod 'ChargeBack'`

### Carthage
Not supported for the moment

### Manual


## Usage

1. Call this inside
  ``` swift
  		let vc = //some new controller where will be present the charge back
  	
     	ChargeBackInstance.loadChargeBack(viewController: vc)
  ```
