class AddTranslationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table(:translations, id: false, primary_key: :key) do |t|
      t.string :key
      t.string :en
      t.string :es
      t.string :ht
    end
  end
end
