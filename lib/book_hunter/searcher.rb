module BookHunter
  class Searcher

    attr_reader :category
    def initialize(message)
      @category_text = '/найти'
      @category = extract_category(message)
    end

    def find_book
      book = "Чак Паланик, Бойцовский Клуб"
    end

    private

    def extract_category(message)
      category = message.gsub(@category_text,"")
    end
  end
end
