class GeocoderRoutes < Application
  get '/search' do
    geocoder_params = validate_with!(GeocoderParamsContract)

    coordinates = Geocoder.geocode(params[:city])

    content_type :json

    if coordinates.present?
      meta = {}
      meta[:lat], meta[:lon] = coordinates

      meta.to_json
    else
      status 404
    end
  end
end
