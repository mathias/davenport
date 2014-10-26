Sequel.migration do
  change do
    create_table(:urls) do
      uuid         :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      timestamptz  :updated_at
      String :title, text: true
      String :url, text: true
      index :url, unique: true
    end
  end
end
