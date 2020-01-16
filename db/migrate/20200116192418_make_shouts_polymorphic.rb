class MakeShoutsPolymorphic < ActiveRecord::Migration[6.0]
  class Shout < ApplicationRecord
    belongs_to :content, polymorphic: true
  end

  class TextShout < ApplicationRecord; end

  def change
    change_table(:shouts) do |t|
      t.string :content_type
      t.integer :content_id
      t.index [:content_type, :content_id]
    end

    reversible do |direction|
      Shout.reset_column_information
      Shout.find_each do |shout|
        direction.up do
          text_shout = TextShout.create(body: shout.body)
          shout.update(content_id: text_shout.id, content_type: "TextShout")
        end
        direction.down do
          shout.update(body: shout.content.body)
        end
      end
    end

    remove_column :shouts, :body, :string
  end
end
