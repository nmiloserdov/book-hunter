module BookHunter

  class Categories

    def initialize
      @categories = %w(фэнтези ужасы приключения трилейр)

    end

    def to_message
      message = ""
      @categories.each do |name|
        message += "  #{name} \n"
      end
      message
    end
  end
end
