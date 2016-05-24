module BookHunter
  class User < ActiveRecord::Base
    has_many :offers
    has_many :books, through: :offers
  end
end
