# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ChargeBack' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'NibDesignable', '3.0.0'
  pod 'PKHUD'
  pod 'SwiftLint'

  target 'ChargeBackTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'ChargeBackDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ChargeBackDemo
  pod 'ChargeBack' , :path => '.'

  target 'ChargeBackDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
