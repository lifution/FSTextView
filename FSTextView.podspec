Pod::Spec.new do |s|
	s.name 			= "FSTextView"
	s.version 	= "1.7"
	s.summary 	= "Subclass of UITextView with Placeholder."
	s.license 	= { :type => "MIT", :file => "LICENSE" }
	s.homepage 	= "https://github.com/lifution"
	s.author 		= { "lifusheng" => "lifution@icloud.com" }
	s.source 		= { 
		:git => 'git@github.com:lifution/FSTextView.git', 
		:tag => s.version.to_s 
	}
	s.requires_arc = true
  s.source_files = 'FSTextView/**/*'
  s.ios.deployment_target = '6.0'
end
