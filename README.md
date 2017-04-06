[![Build Status](https://www.bitrise.io/app/e69001a14e898755.svg?token=0UQPNSuNc9fyaSw78Bfnzw&branch=master)](https://www.bitrise.io/app/e69001a14e898755)
[![Git license](https://img.shields.io/badge/license-MIT-lightgrey.svg)]()

Tested with Xcode 8.3.

ChargeBack
=============
 
## Disclamer 
 
The organization of the project is based on this [article](http://qualitycoding.org/rearrange-project-test-code/). 

The lib files are in the Folder ChargeBack separte in 3 other folders: ChargeBackAPI (reponsible for API Request), Flow (that represent the app flow), ThirdParty (files from external part).

Inside Flow and ChargeBackAPI folder the code is separate in feature componante and each feature contain all files use inside this feature including test files.

## Installation
 

### CocoaPods

Add my private repository: 

	pod repo add antoine git@bitbucket.org:ant_one/my-private-cocoapods-repository.git

Add this to your Podfile: 

    source 'git@bitbucket.org:ant_one/my-private-cocoapods-repository.git'
    source 'https://github.com/CocoaPods/Specs.git'

And

`pod 'ChargeBack'`

### Carthage
Not supported for the moment


## Usage
1. Import ChargeBack framework on your project

        import ChargeBack
 
2. Call this where you want to call the charge back
 
  		let vc = //some view controller where will be present the charge back
        ChargeBackInstance.presentChargeBack(viewController: vc) 

