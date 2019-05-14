Pod::Spec.new do |s|
    s.name             = 'NNTabularViewController'
    s.version          = '1.0.0'
    s.summary          = 'A short description of NNTabularViewController.'
    s.homepage         = 'https://github.com/ChandlerNguyen/NNTabularViewController'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = 'Nang Nguyen'
    s.source           = { :git => 'https://github.com/ChandlerNguyen/NNTabularViewController.git', :tag => s.version.to_s }

    s.swift_version = '5.0'
    s.ios.deployment_target = '9.0'

    s.source_files = 'NNTabularViewController/**/*'

    s.frameworks = 'Foundation', 'UIKit'
    s.dependency 'NNScrollableSegmentedControl'
end
