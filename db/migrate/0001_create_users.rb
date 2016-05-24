class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :telegram_id
      t.string  :first_name
      t.string  :last_name
      t.string  :nickname
    end
  end
end
