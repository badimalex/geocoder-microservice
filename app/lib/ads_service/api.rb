module AdsService
  module Api

    def update_coordinates(id, coordinates)
      lat, lon = coordinates
      payload = {
        id: id,
        lat: lat,
        lon: lat
      }

      response = connection.post('update_coordinates', payload.to_query)

      response.body if response.success?
    end

  end
end
