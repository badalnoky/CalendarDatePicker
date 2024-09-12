Pod::Spec.new do |s|
  s.name             = 'CalendarDatePicker'
  s.version          = '1.0.0'
  s.summary          = 'Graphic style DatePicker but you can detect taps on any date.'

  s.description      = <<-DESC
  'Graphic style DatePicker but you can detect taps on any date. In the default graphic style date picker you cant detect if the user taps on the initially selected date. This component can and it is very similar both in functionality and in UI.'
                       DESC

  s.homepage         = 'https://github.com/badalnoky/CalendarDatePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'badalnoky' => 'dalnoky.bertalan.andras@gmail.com' }
  s.source           = { :git => 'https://github.com/badalnoky/CalendarDatePicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '17.0'
  s.osx.deployment_target = '14.0'

  s.source_files = 'CalendarDatePicker/Classes/**/*'
  s.swift_version = '5.0'
  s.platforms = {
    "ios": "17.0",
    "osx": "14.0"
  }
end
