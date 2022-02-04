class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.integer :host_id, foreign_key: true
      t.integer :movie_id
      t.integer :length
      t.time :start_time
      t.date :date

      t.timestamps
    end
  end
end
