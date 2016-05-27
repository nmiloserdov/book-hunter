class AddCountryAssotiation < ActiveRecord::Migration
  def change 
    create_table :books_countries do |t|
      t.references :book
      t.references :country
    end
  end
end
