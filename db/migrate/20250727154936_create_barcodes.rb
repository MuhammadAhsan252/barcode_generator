class CreateBarcodes < ActiveRecord::Migration[8.0]
  def change
    create_table :barcodes do |t|
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
