class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
			t.string  :name
			t.string  :filling
			t.string  :coating
			t.decimal :price, :precision => 8, :scale => 2
			t.text    :description
			t.text    :other
      t.timestamps null: false
    end
  end
end

