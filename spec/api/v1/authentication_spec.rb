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
            },
            required: ['email', 'password']
          }
        },
        required: ['user']
      }

      response '200', 'user authentificated' do
        before do
          User.create email: 'johndoe@example.com', password: 'password1'
        end
        let(:user) do
          { user: { email: 'johndoe@example.com', password: 'password1' } }
        end
        run_test!
      end

      response '400', 'missing required parameter' do
        let(:user) { { email: 'johndoe@example.com' } }
        run_test!
      end

      response '401', 'invalid username or password' do
        let(:user) do
          { user: { email: 'johndoe@example.com', password: 'password1' } }
        end
        run_test!
      end
    end
  end
end
