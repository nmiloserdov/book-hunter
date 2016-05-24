module BookHunter
  class Offer < ActiveRecord::Base
    belongs_to :user
    belongs_to :book
  end
end
