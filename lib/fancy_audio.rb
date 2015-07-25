require 'mp3info'
require_relative 'fancy_audio/pretty_printer'

module FancyAudio
  module Operations
    include FancyAudio::PrettyPrinter

    IMAGE_NOT_FOUND = 'File Not Found'

    def add_image(audio_file, image)
      return unless files_present(audio_file, image)

      image_file = File.new(image, 'rb')
      Mp3Info.open(audio_file) do |audio|
        audio.tag2.remove_pictures
        audio.tag2.add_picture(image_file.read)
      end
    end

    def add_image_to_all(dir = `pwd`.chop, image)
      audio_files = Dir[dir + "/*.mp3"]

      audio_files.each do |audio_file|
        add_image(audio_file, image)
      end
      print_info "done!"
    end

    def add_image_smartly(dir = `pwd`.chop)
      unavialble_images = []
      changed_audio_files = {}
      audio_files = Dir[dir + "/*.mp3"]

      audio_files.each do |audio_file|
        file_name_without_ext = dir + "/#{File.basename(audio_file, '.mp3')}"
        image_file = get_image_file(file_name_without_ext)

        if(image_file == IMAGE_NOT_FOUND)
          unavialble_images << audio_file
        else
          add_image(audio_file, image_file)
          changed_audio_files[audio_file] = image_file
        end
      end

      print_modified_files changed_audio_files
      print "\n\n"
      print_unmodified_files unavialble_images
      print_info "No audio files found!!" if audio_files.empty?
    end

    private
    def files_present(audio_file, image_file)
      audio_file_exists = File.exist?(audio_file)
      image_file_exists = File.exist?(image_file)

      if !audio_file_exists
        print_error "#{audio_file} does not exists!\n"
      elsif !image_file_exists
        print_error "#{image_file} does not exists!\n"
      end

      audio_file_exists && image_file_exists
    end

    def print_modified_files(files)
      return if files.empty?
      print_info("Modified Audio Files\n")
      files.each {|audio, image| print_success(audio + " + #{image}\n")}
    end

    def print_unmodified_files(files)
      return if files.empty?
      print_info("Unmodified Audio Files - May be image is not present for these audios\n")
      print_info("Convertor only supports .jpeg, .jpg and .png image files\n")
      files.each {|image| print_error(image+"\n")}
    end

    def get_image_file(file)
      return (file + ".jpeg") if File.exist?(file + ".jpeg")
      return (file + ".jpg") if File.exist?(file + ".jpg")
      return (file + ".png") if File.exist?(file + ".png")

      IMAGE_NOT_FOUND
    end
  end
end

