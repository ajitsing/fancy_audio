# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fancy_audio/version'

Gem::Specification.new do |s|
  s.name                        =   'fancy_audio'
  s.version                     =   FancyAudio::VERSION
  s.date                        =   '2015-07-25'
  s.summary                     =   'Gem to add an album cover to the audio'
  s.description                 =   s.summary
  s.authors                     =   ['Ajit Singh']
  s.email                       =   'jeetsingh.ajit@gamil.com'
  s.license                     =   'MIT'
  s.homepage                    =   'http://www.singhajit.com/fancyaudio-gem-to-add-album-cover-to-audio-file/'

  s.files                       =   `git ls-files -z`.split("\x0")
  s.executables                 =   s.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  s.test_files                  =   s.files.grep(%r{^(test|spec|features)/})
  s.require_paths               =   ["lib"]

  s.add_dependency                  'ruby-mp3info', '~> 0.8.5'
  s.add_development_dependency      "bundler", "~> 1.5"
  s.add_development_dependency      "rake"
  s.add_development_dependency      "rspec"
end
