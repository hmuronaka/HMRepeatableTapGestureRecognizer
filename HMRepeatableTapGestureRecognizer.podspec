Pod::Spec.new do |spec|
  spec.name         = 'HMRepeatableTapGestureRecognizer'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/hmuronaka/HMRepeatableTapGestureRecognizer'
  spec.authors      = { 'Hiroaki Muronaka' => 'capriccio27@gmail.com' }
  spec.summary      = 'HMTargetActionList'
  spec.source       = { :git => 'https://github.com/hmuronaka/HMRepeatableTapGestureRecognizer.git', :tag => '0.0.1' }
  spec.source_files = 'HMRepeatableTapGestureRecognizer/Class/**/*.{h,m}'
  spec.requires_arc = true
  spec.dependency "HMTargetActionList", git: 'https://github.com/hmuronaka/HMRepeatableTapGestureRecognizer.git'
end

