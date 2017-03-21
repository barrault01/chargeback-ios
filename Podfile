# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ChargeBack' do

  use_frameworks!
  pod 'NibDesignable', '3.0.0'
  pod 'PKHUD'

end

target 'ChargeBackDemo' do

  use_frameworks!
  pod 'ChargeBack' , :path => '.'

  # Pods for ChargeBackDemo

  target 'ChargeBackDemoTests' do
    inherit! :search_paths
  end

  target 'ChargeBackDemoUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
