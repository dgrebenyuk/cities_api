require 'swagger_helper'

describe 'Cities', type: :request do
  path '/cities' do
    get 'Get list of all cities' do
      tags 'Cities'
      consumes 'application/json'

      parameter name: :featured, in: :query,
        type: :boolean,
        description: 'Show cities sorted by popularity.'

      response '200', 'sorted by popularity' do
        let(:featured) { true }
        run_test!
      end
    end

    post 'Create new city' do
      tags 'Cities'
      consumes 'application/json'
      produces 'application/json'
      security [basic: []]

      parameter name: :Authorization, in: :header,
        type: :string, required: true,
        description: 'Authorization token'

      parameter name: :city, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          population: { type: :integer }
        },
        required: ['name', 'description', 'population']
      }

      response '200', 'city created' do
        let(:Authorization) do
          FactoryBot.create :user
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        let(:city) do
          { city: { name: 'London', description: 'Test city', population: 8_000_000 } }
        end
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Basic #{::Base64.strict_encode64('bogus:bogus')}" }
        let(:city) do
          { city: { name: 'London', description: 'Test city', population: 8_000_000 } }
        end
        run_test!
      end

      response '422', 'missing required parameters' do
        let(:Authorization) do
          FactoryBot.create :user
          "Basic #{JsonWebToken.encode(sub: User.maximum(:id))}"
        end
        let(:city) { {} }
        run_test!
      end
    end
  end
end
