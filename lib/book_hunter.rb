require 'yaml'

module BookHunter

  @root ||= File.expand_path File.dirname __dir__
  @secrets = YAML.load_file([@root,'config','secrets.yml'].join("/"))
  TOKEN = @secrets.values.first

  COMMANDS = { 
    start:      "/start",
    categories: "/categories",
    find:       "/find",
    contacts:   "/contacts",
    help:       "/help"
  }

  def self.start
    Telegram::Bot::Client.run(TOKEN) do |bot|
      @messages = Messages.new(COMMANDS)
      @category = Categories.new
      bot.listen do |message|
        case message.text
        when COMMANDS[:start]
          bot.api.sendMessage(chat_id: message.chat.id,
                              text: @messages[:greet, message.from.first_name], 
                              parse_mode: :markdown)
        when COMMANDS[:categories]
          # TODO
          category_message = @category.to_message
          bot.api.sendMessage(chat_id: message.chat.id,
                              text: @messages[:categories, category_message])
        when /#{COMMANDS[:find]}/
          searcher = Searcher.new(message.text)
          # TODO active record
          book = searcher.find_book
          bot.api.sendMessage(chat_id: message.chat.id,
                              text: @messages[:book, book])
        when COMMANDS[:contacts]
          bot.api.sendMessage(chat_id: message.chat.id,
                              text: @messages[:contacts], parse_mode: :markdown)
        when COMMANDS[:help]
          bot.api.sendMessage(chat_id: message.chat.id,
                              text: @messages[:help], parse_mode: :markdown)
        else
          bot.api.sendMessage(chat_id: message.chat.id,
                              text: @messages[:error] + @messages[:help],
                              parse_mode: :markdown)
        end
      end
    end
  end
end
