module FancyAudio
  module PrettyPrinter
    def colorize(text, color_code)
    "#{color_code}#{text}\e[0m"
    end

    def red(text); colorize(text, "\e[31m"); end
    def green(text); colorize(text, "\e[32m"); end
    def yellow(text); colorize(text, "\e[1m\e[33m");  end

    def print_info(msg)
      STDOUT.write yellow(msg)
    end

    def print_error(msg)
      STDOUT.write red(msg)
    end

    def print_success(msg)
      STDOUT.write green(msg)
    end
  end
end
