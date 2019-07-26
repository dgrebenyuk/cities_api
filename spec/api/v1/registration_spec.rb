require 'swagger_helper'

describe 'Registration', type: :request do
  path '/users' do
    post 'Register new user' do
      tags 'Registration'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: ['email', 'password']
      }

      response '201', 'User registered' do
        let(:user) { { user: { email: 'johndoe@example.com', password: 'password1' } } }
        run_test!
      end

      response '422', 'Registration failed' do
        let(:user) { { email: 'johndoe@example.com' } }
        run_test!
      end
    end
  end
end
