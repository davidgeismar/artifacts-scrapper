class CreateTableSale < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.jsonb :details
    end
  end
end
