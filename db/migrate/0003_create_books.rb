class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string  :author
      t.string  :title
      t.string  :origin_name
    end
  end
end
