require 'yaml'

require 'active_record'
require "book_hunter/messages.rb"
require "book_hunter/searcher.rb"
require "book_hunter/categories.rb"

lib_path = File.dirname File.absolute_path(__FILE__)
Dir[lib_path + "/book_hunter/models/*.rb"].each { |file| require file  }

module BookHunter

  @root ||= File.expand_path File.dirname __dir__
  @secrets = YAML.load_file([@root,'config','secrets.yml'].join("/"))
  TOKEN = @secrets.dig("token")

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
        when message
        when COMMANDS[:start]
          send_message(bot, message, @messages[:greet, message])
        when COMMANDS[:categories]
          send_message(bot, message, @messages[:categories])
        when /#{COMMANDS[:find]}/
          send_message(bot, message, @messages[:book, message.text])
          user = User.find_by(telegram_id: message.from.id)
          user.increase_handling if user
        when COMMANDS[:contacts]
          send_message(bot, message, @messages[:contacts])
        when COMMANDS[:help]
          send_message(bot, message, @messages[:help])
        else
          send_message(bot, message, @messages[:error])
        end
      end
    end
  end

  def self.send_message(bot, message, client_message)
    bot.api.sendMessage(chat_id: message.chat.id,
      text: client_message, 
        parse_mode: :markdown)
  end

  def self.root
    @root ||= File.expand_path File.dirname __dir__
  end

  def self.db_connect
    db_config = YAML.load_file([@root,'db','database.yml'].join("/"))
    ActiveRecord::Base.establish_connection db_config.dig("production")
  end
end
