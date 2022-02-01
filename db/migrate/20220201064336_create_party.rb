class CreateParty < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.datetime :date
      t.datetime :start_time
      t.string :movie_title
      t.string :movie_runtime

      t.timestamps 
    end
  end
end
