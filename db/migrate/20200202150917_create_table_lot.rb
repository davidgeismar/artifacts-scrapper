class CreateTableLot < ActiveRecord::Migration[5.2]
  def change
    create_table :lots do |t|
      t.string :origin
      t.jsonb :details
    end
  end
end
