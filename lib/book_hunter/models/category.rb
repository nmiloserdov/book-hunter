module BookHunter
  class Category < ActiveRecord::Base
    validates :name, presence: true

    has_and_belongs_to_many :books, dependent: :destroy

    validates :name, presence: true

    def increase_rang
      return unless self
      rang = self.rang + 1
      self.rang = rang
    end
  end
end
