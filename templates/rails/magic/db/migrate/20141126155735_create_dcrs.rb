class CreateDcrs < ActiveRecord::Migration
  def change
    create_table :dcrs do |t|

      t.timestamps
    end
  end
end
