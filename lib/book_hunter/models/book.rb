module BookHunter
  class Book < ActiveRecord::Base
    has_and_belongs_to_many :categories
    has_many :offers
    has_many :users, through: :offers
  end
end
