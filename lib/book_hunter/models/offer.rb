module BookHunter
  class Offer < ActiveRecord::Base
    belongs_to :user
    belongs_to :book
    
    after_save :process_rangs
    validates :user_id, :book_id, presence: true

    private

    def process_rangs
      self.user.increase_handling
      self.book.categories.each do |category|
        category.increase_rang
        category.save
      end
    end
  end
end
