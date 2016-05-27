module BookHunter
  class Searcher

    attr_reader :category

    def initialize(message, commands)
      @find_command = commands[:find]
      @message = extract_category(message)
      @category = process_category
    end

    def find_book
      if @message.empty?
        random = rand(Book.count - 1) + 1
        return Book.find_by(id: random)
      elsif @category
        books     = @category.books
        book_rand = rand(books.count)
        books[book_rand]
      else
        nil
      end
    end

    def process_category
      name = extract_category(@message)
      Category.find_by(name: name)
    end

    private

    def extract_category(message)
      message.gsub(@find_command,"").strip.capitalize
    end
  end
end
