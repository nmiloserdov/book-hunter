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
                     "случайно выбрать книгу по категории. \n"\
                     "Введите #{@commands[:categories]} для того, "\
                     "что-бы вывести список категорий книг. \n"\
                     "Введите #{@commands[:help]} - для помощи, \n" \
                     "Введите #{@commands[:find]} *категория* что-бы вывести случайную книгу. \n" \
                     "Например: #{@commands[:find]} *детектив*",

        categories:  "Категории:\n{{}}",

        book:        "Ваша книга: {{}}",

        contacts:    "Контакты:\n"\
                     "Почта: #{@contacts[:email]}\n"\
                     "github: #{@contacts[:github]}",
        error:       "*Упс*, такой команды нету :( \n",

        help:        "Помощь: \n"\
                     "#{@commands[:categories]} - список категорий \n"\
                     "#{@commands[:find]} *категория* - подбрать книгу \n"\
                     "#{@commands[:contacts]} - связаться с разработчиком",
      }
    end

    def get_message(key, info)
      message = @messages[key]
      return nil if message.nil?
      message = message.gsub('{{}}', info) if info
      message if (message =~ /{{}}/).nil?
    end

    def [](key, info=nil)
      get_message(key.to_sym, info) || nil
    end
  end
end
