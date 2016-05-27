module BookHunter

  class Messages
    def initialize(commands)
      @commands = commands
      @contacts = {
        email:  'nmiloserdov09@gmail.com',
        github: 'https://github.com/nmiloserdov' 
      }

      @messages = {
        greet:       "Привет _{{}}_, я бот который поможет вам "\
                     "случайно выбрать книгу для чтения. \n"\
                     "Введите #{@commands[:categories]} для того, "\
                     "что-бы вывести список доступных категорий книг. \n"\
                     "Введите #{@commands[:help]} - для помощи, \n" \
                     "Введите #{@commands[:find]} что-бы" \
                     "вывести случайную книгу. \n",

        categories:  "Категории:\n{{}}",

        book:        "*Ваша книга:* {{}}",

        undef:       "К сожалению, книга не найдена :(\n"\
                     "Воспользуйтесь поиском снова, для помощи "\
                     "наберите #{@commands[:help]}",

       undef_with:   "К сожалению, книга с категорией {{}} "\
                     "не найдена :(\n"\
                     "Воспользуйтесь поиском снова",

        contacts:    "Контакты:\n"\
                     "Почта: #{@contacts[:email]}\n"\
                     "github: #{@contacts[:github]}",
        error:       "*Упс*, такой команды нету :( \n",

        help:        "Помощь: \n"\
                     "#{@commands[:categories]} - список категорий \n"\
                     "#{@commands[:find]}  - подбрать книгу \n"\
                     "#{@commands[:contacts]} - связаться с разработчиком",
      }
    end

    def get_message(key, info=nil)
      message = @messages[key]
      return nil if message.nil?
      message = message.gsub('{{}}', info) if info
      message if (message =~ /{{}}/).nil?
    end

    def [](key, info=nil)
      message = get_message(key.to_sym, info) || nil
      message = create_user(key.to_sym, info)  if key == :greet
      message = build_book_message(key, info)     if key == :book
      message = build_category_message(key, info) if key == :categories
      message = build_unknow_message(key, info)   if key == :error
      message
    end

    def build_book_message(key, info)
      searcher = Searcher.new(info, COMMANDS)
      book = searcher.find_book
      if book.present?
        message = get_message(:book, book.build_title)
      end
      if message.nil?
        message = get_message(:undef_with, searcher.category)
        message = get_message(:undef) if message.nil?
      end
      message
    end

    def build_category_message(key, info)
      @categories = Categories.new
      categories = @categories.to_message
      get_message(:categories, categories)
    end

    def build_unknow_message(key,info)
      get_message(:error, info) + get_message(:help, info)
    end

    def create_user(key,message)
      user = User.find_by(telegram_id: message.from.id)
      unless user
        User.create(
          telegram_id: message.from.id,
          first_name: message.from.first_name,
          last_name:  message.from.last_name,
          nickname: message.from.username
        )
      end
      name = message.from.first_name if message.from.first_name
      name = message.from.username   if message.from.username && name.nil?
      get_message(key, name)
    end
  end
end
