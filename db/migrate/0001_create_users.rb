class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :telegram_id
      t.string  :first_name
      t.string  :last_name
      t.string  :nickname
      t.string  :origin_name
      t.string  :country
      t.integer :handling_count, default: 0
    end
  end
end
