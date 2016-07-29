class ChangeScansCommits < ActiveRecord::Migration[5.0]
  def change
    change_table :scans do |t|
      t.remove :commit
      t.text   :commit
    end
  end
end
