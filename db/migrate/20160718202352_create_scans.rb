class CreateScans < ActiveRecord::Migration[5.0]
  def change
    create_table :scans do |t|
      t.integer :new_optimization_score
      t.integer :old_optimization_score

      t.timestamps
    end
  end
end
