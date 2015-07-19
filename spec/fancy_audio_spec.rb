require 'spec_helper'

describe :FancyAudio do

  before(:each) do
   remove_pictures_from_songs
  end

  it 'should add image to the song' do
    current_dir = File.expand_path File.dirname __FILE__
    image_file = current_dir + '/resources/song1.jpg'
    audio_file = current_dir + '/resources/song1.mp3'

    add_image audio_file, image_file
    assert_audio_has_image audio_file
  end

  it 'should handle gracefully when file is not present' do
    current_dir = File.expand_path File.dirname __FILE__
    unavailable_audio_file = current_dir + '/resources/unavailable_song.mp3'
    unavailable_image_file = current_dir + '/resources/unavailable_image.jpg'

    image_file = current_dir + '/resources/song1.jpg'
    audio_file = current_dir + '/resources/song1.mp3'

    add_image unavailable_audio_file, image_file
    add_image audio_file, unavailable_image_file

    assert_audio_does_not_have_image audio_file
  end

  it 'should add image to the song smartly' do
    dir = File.expand_path File.dirname(__dir__) + '/spec/resources'
    audio_file = dir + '/song1.mp3'

    add_image_smartly dir
    assert_audio_has_image audio_file
  end

  it 'should add image to the song in the current directory' do
    dir = File.expand_path File.dirname(__dir__) + '/spec/resources'
    audio_file = dir + '/song1.mp3'
    Dir.chdir dir do
      add_image_smartly
      assert_audio_has_image audio_file
    end
  end
end

