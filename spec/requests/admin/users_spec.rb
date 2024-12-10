require 'swagger_helper'

describe 'Users API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:Authorization) do
    create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
  end
  let(:authorization_without_abilities) do
    create(:admin_authentication_without_abilities).generate_token_for(:authorization)
  end

  before do
    self.class.tags 'Users'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/users' do
    get 'Get users list' do
      security [ authorization_header: [] ]
      parameter name: :order_param, in: :query, type: :string, required: false,
                description: 'Param name to order by',
                enum: { email: 'email', first_name: 'first name', last_name: 'last name',
                        account_type: 'type of account', created_at: 'date of creating',
                        updated_at: 'date of last update' }
      parameter name: :order_direction, in: :query, type: :string, required: false,
                description: 'Order direction',
                enum: { asc: 'ascending order', desc: 'descending order' }

      response 200, 'ok' do
        before { create(:user) }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end

  path '/admin/users/{id}' do
    get 'Get user' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string

      response 200, 'ok' do
        let(:id) { create(:employee_with_all_abilities).id }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
