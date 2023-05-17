json.extract! coin, :id, :identity, :symbol, :name, :status, :created_at, :updated_at
json.url coin_url(coin, format: :json)
