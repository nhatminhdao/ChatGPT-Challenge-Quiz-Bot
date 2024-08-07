class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :quiz_id
      t.text :content
      t.text :role

      t.timestamps
    end
  end
end
