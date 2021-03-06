require 'swagger_helper'

describe 'Favourites', type: :request do
  path '/favourites' do
    get 'Show favourite cities for user' do
      tags 'Favourites'
      security [basic: []]

      parameter name: :Authorization, in: :header,
        type: :string, required: true,
        description: 'Authorization token'

      response '200', 'show favourite cities' do
        before { FactoryBot.create :user }
        let(:Authorization) do
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Basic #{::Base64.strict_encode64('bogus:bogus')}" }
        run_test!
      end
    end

    post 'add city to favourites' do
      tags 'Favourites'
      consumes 'application/json'
      security [basic: []]

      parameter name: :Authorization, in: :header,
        type: :string, required: true,
        description: 'Authorization token'

      parameter name: :favourite, in: :body, schema: {
        type: :object,
        properties: {
          favourite: {
            type: :object,
            properties: {
              city_id: { type: :integer },
            },
            required: ['city_id']
          }
        },
        required: ['favourite']
      }

      response '200', 'add city to user favourites' do
        before { FactoryBot.create :user }
        let(:Authorization) do
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        let(:favourite) do
          FactoryBot.create :city
          { favourite: { city_id: City.maximum(:id) } }
        end
        run_test!
      end

      response '400', 'missing required parameters' do
        before { FactoryBot.create :user }
        let(:Authorization) do
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        let(:favourite) { {} }
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Basic #{::Base64.strict_encode64('bogus:bogus')}" }
        let(:favourite) { {} }
        run_test!
      end

      response '422', 'wrong city id' do
        before { FactoryBot.create :user }
        let(:Authorization) do
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        let(:favourite) { { favourite: { city_id: 1 } } }
        run_test!
      end
    end
  end
  path '/favourite/{city_id}' do
    delete 'remove city from favourites' do
      tags 'Favourites'
      consumes 'application/json'
      security [basic: []]

      parameter name: :Authorization, in: :header,
        type: :string, required: true,
        description: 'Authorization token'

      parameter name: :city_id, in: :path,
        type: :integer,
        require: true,
        description: 'ID of city which should be removed from favourites list'

      response '200', 'remove city from user favourites' do
        before do
          city = FactoryBot.create(:city)
          user = FactoryBot.create :user
          user.cities << city
        end
        let(:Authorization) do
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        let(:city_id) { City.maximum(:id) }
        run_test!
      end

      response '422', 'wrong city id' do
        before { FactoryBot.create :user }
        let(:Authorization) do
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        let(:city_id) { 1 }
        run_test!
      end
    end
  end
end
