module BookHunter
  class Book < ActiveRecord::Base
    has_and_belongs_to_many :categories
    has_many :offers
    has_many :users, through: :offers
    has_and_belongs_to_many :countries

    validate :origin_name, :title
    validate :title
    validate :author

    def build_title
      title  = "[\"#{self.title}\"](http://google.com/search?q=#{self.title}, #{self.author}) \n"
      title += "Автор: _#{self.author}_ \n"
      title += "Категоия: _#{self.categories.first.name}_\n" if self.categories
      title += "Страна: _#{self.countries.first.name}_" if self.countries
    end

    private

  end
end
