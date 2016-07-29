class ChangeScans < ActiveRecord::Migration[5.0]
  def change
    change_table :scans do |t|
      t.remove :old_optimization_score
      t.remove :new_optimization_score
      t.integer :commit
      t.string :event
      t.string :result
      t.string :server_name
    end
  end
end
