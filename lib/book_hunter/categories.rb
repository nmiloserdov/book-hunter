module BookHunter

  class Categories

    def initialize
      @categories = %w(фэнтези ужасы приключения трилейр)

    end

    def to_message
      message = ""
      @categories = Category.all
      @categories.each do |category|
        message += "#{category.id}) #{category.name}\n"
      end
      message
    end
  end
end
