require 'swagger_helper'

describe 'Products API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:Authorization) do
    create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
  end
  let(:authorization_without_abilities) do
    create(:admin_authentication_without_abilities).generate_token_for(:authorization)
  end
  let(:category) { create(:category) }

  before do
    self.class.tags 'Products'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/products' do
    get 'Get products list' do
      security [ authorization_header: [] ]

      response 200, 'ok' do
        before do
          create(:product)
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

    post 'Create new product' do
      security [ authorization_header: [] ]
      parameter name: :product, in: :body,
                schema: { '$ref' => '#/components/schemas/product' }

      response 201, 'created' do
        let(:product) { { product: attributes_for(:product).merge({ category_id: category.id }) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:product) { { product: attributes_for(:product) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:product) { { product: attributes_for(:product) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:product) { { product: { name: nil, uri_name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end

  path '/admin/products/{id}' do
    get 'Get product' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string

      response 200, 'ok' do
        let(:id) { create(:product).id }

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

    put 'Update product' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string
      parameter name: :product, in: :body,
                schema: { '$ref' => '#/components/schemas/product' }

      response 200, 'ok' do
        let(:id) { create(:product).id }
        let(:product) { { product: attributes_for(:product) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { Faker::Internet.uuid }
        let(:product) { { product: attributes_for(:product) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:id) { Faker::Internet.uuid }
        let(:product) { { product: attributes_for(:product) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }
        let(:product) { { product: attributes_for(:product) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:id) { create(:product).id }
        let(:product) { { product: { name: nil, uri_name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    delete 'Delete product' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string

      response 204, 'no content' do
        let(:id) { create(:product).id }

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
