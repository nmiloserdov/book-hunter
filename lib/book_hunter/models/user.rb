module BookHunter
  class User < ActiveRecord::Base
    has_many :offers
    has_many :books, through: :offers

    def increase_handling
      return unless self.telegram_id
      count = self.handling_count.to_i + 1
      self.handling_count = count
      self.save
    end
  end
end
