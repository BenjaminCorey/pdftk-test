class CreatePdfResponses < ActiveRecord::Migration
  def change
    create_table :pdf_responses do |t|
      t.text :file_path
      t.json :data

      t.timestamps null: false
    end
  end
end
