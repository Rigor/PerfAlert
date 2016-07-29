class EnableHStore < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'hstore'
    change_table :scans do |t|
      t.remove :commit
      t.hstore :commit
    end
  end
end
