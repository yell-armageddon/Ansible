class CreateRevs < ActiveRecord::Migration
  def change
    create_table :revs do |t|

      t.timestamps
    end
  end
end
