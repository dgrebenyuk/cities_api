require 'swagger_helper'

describe 'Authentication', type: :request do
  path '/auth' do
    post 'receive new token' do
      tags 'Authentication'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: true
      }

      response '200', 'user authentificated' do
        let(:user) do
          User.create email: 'johndoe@example.com', password: 'password1'
          { user: { email: 'johndoe@example.com', password: 'password1' } }
        end
        run_test!
      end

      response '401', 'invalid username or password' do
        let(:user) do
          { user: { email: 'johndoe@example.com', password: 'password1' } }
        end
        run_test!
      end

      response '422', 'missing required parameter' do
        let(:user) { { email: 'johndoe@example.com' } }
        run_test!
      end
    end
  end
end
