require 'swagger_helper'

describe 'User API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  before do
    self.class.tags 'User'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/user' do
    get 'Get authenticated user data' do
      security [ authorization_header: [] ]

      response 200, 'ok' do
        let(:Authorization) do
          create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
