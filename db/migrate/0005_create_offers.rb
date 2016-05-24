class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :user
      t.references :book
      t.boolean    :read
    end
  end
end
