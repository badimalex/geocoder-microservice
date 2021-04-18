RSpec.describe GeocoderRoutes, type: :routes do
  describe 'GET /search' do
    context 'missing parameters' do
      it 'returns an error' do
        get '/search', city: ''

        expect(last_response.status).to eq(422)

        expect(response_body['errors']).to include(
          {
            'detail' => 'В запросе отсутствуют необходимые параметры',
          }
        )
      end
    end

    context 'when city not exist' do
      it 'returns not found' do
        get '/search', city: 'Not exist'
        expect(last_response.status).to eq(404)
      end
    end

    context 'when city exist' do
      it 'returns coordinates' do
        get '/search', city: 'City 17'

        expect(last_response.status).to eq(200)
      end
    end
  end
end
