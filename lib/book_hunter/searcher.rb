module BookHunter
  class Searcher

    attr_reader :category
    def initialize(message, commands)
      @category_text = commands[:find]
      @category = process_category(message)
    end

    def find_book
      return nil unless @category.present?
      books     = Book.where(category: @category)
      book_rand = rand(books.count)
      books.find_by(book_rand)
    end

    def process_category(message)
      name = extract_category(message)
      Category.find_by(name: name)
    end

    private

    def extract_category(message)
      message.gsub(@category_text,"")
    end
  end
end
