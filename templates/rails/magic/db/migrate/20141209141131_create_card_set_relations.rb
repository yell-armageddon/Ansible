class CreateCardSetRelations < ActiveRecord::Migration
  def change
    create_table :card_set_relations do |t|

      t.timestamps
    end
  end
end
