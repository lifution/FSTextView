Pod::Spec.new do |s|
	s.name = "FSTextView"
	s.version = "1.8"
	s.summary = "Subclass of UITextView with Placeholder."
	s.license = { :type => "MIT", :file => "LICENSE" }
	s.homepage = "https://github.com/lifution/FSTextView"
	s.author = { "fusheng" => "lifution@icloud.com" }
	s.source = { :git => "https://github.com/lifution/FSTextView.git", :tag => "1.8" }
	s.requires_arc = true
	s.platform = :ios, "6.0"
	s.source_files = "FSTextView/*", "*.{h,m}"
end