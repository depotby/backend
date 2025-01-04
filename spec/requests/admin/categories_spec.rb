require 'swagger_helper'

describe 'Categories API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:Authorization) do
    create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
  end
  let(:authorization_without_abilities) do
    create(:admin_authentication_without_abilities).generate_token_for(:authorization)
  end

  before do
    self.class.tags 'Categories'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/categories' do
    get 'Get categories list' do
      security [ authorization_header: [] ]
      parameter name: :order_param, in: :query, type: :string, required: false,
                description: 'Param name to order by',
                enum: { name: 'name' }
      parameter name: :order_direction, in: :query, type: :string, required: false,
                description: 'Order direction',
                enum: { asc: 'ascending order', desc: 'descending order' }

      response 200, 'ok' do
        before do
          create(:category)
        end

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

    post 'Create new category' do
      security [ authorization_header: [] ]
      parameter name: :category, in: :body,
                schema: { '$ref' => '#/components/schemas/category' }

      response 201, 'created' do
        let(:category) { { category: attributes_for(:category) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:category) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:category) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:category) { { category: { name: nil, uri_name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end

  path '/admin/categories/{id}' do
    get 'Get category' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string

      response 200, 'ok' do
        let(:id) { create(:category).id }

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

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    put 'Update category' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string
      parameter name: :category, in: :body,
                schema: { '$ref' => '#/components/schemas/category' }

      response 200, 'ok' do
        let(:id) { create(:category).id }
        let(:category) { { category: attributes_for(:category) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { Faker::Internet.uuid }
        let(:category) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:id) { Faker::Internet.uuid }
        let(:category) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }
        let(:category) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:id) { create(:category).id }
        let(:category) { { category: { name: nil, uri_name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    delete 'Delete category' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string

      response 204, 'no content' do
        let(:id) { create(:category).id }

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

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
