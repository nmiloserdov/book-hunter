module BookHunter
  class BooksCountries < ActiveRecord::Base
    belongs_to :book
    belongs_to :country
    validate :book_id, :country_id
  end
end
