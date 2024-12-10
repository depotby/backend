require 'swagger_helper'

describe 'User API', type: :request, openapi_spec: 'v1/swagger.yaml' do
  before do
    self.class.tags 'User'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/v1/user' do
    get 'Get authenticated user data' do
      security [ authorization_header: [] ]

      response 200, 'ok' do
        let(:Authorization) { create(:authentication).generate_token_for(:authorization) }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    post 'Creates a user' do
      parameter name: :new_user, in: :body, schema: { '$ref' => '#/components/schemas/new_user' }

      response 201, 'created' do
        let(:new_user) do
          user = attributes_for(:user)

          { user: { first_name: user[:first_name], last_name: user[:last_name], email: user[:email],
                    password: user[:password], password_confirmation: user[:password] } }
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:new_user) { { user: { first_name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
