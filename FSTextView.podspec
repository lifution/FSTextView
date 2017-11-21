Pod::Spec.new do |s|
	s.name = "FSTextView"
	s.version = "1.5"
	s.summary = "Subclass of UITextView with Placeholder"
	s.license = { :type => "MIT", :file => "LICENSE" }
	s.homepage = "https://github.com/lifution/FSTextView"
	s.author = { "Steven" => "https://github.com/lifution" }
	s.source = { :git => "https://github.com/lifution/FSTextView.git", :tag => "1.4" }
	s.requires_arc = true
	s.platform = :ios, "6.0"
	s.source_files = "FSTextView/*", "*.{h,m}"
end
