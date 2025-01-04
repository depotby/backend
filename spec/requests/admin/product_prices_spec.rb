require 'swagger_helper'

describe 'Product Prices API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:Authorization) do
    create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
  end
  let(:authorization_without_abilities) do
    create(:admin_authentication_without_abilities).generate_token_for(:authorization)
  end
  let(:product) { create(:product) }
  let(:id) { product.id }

  before do
    self.class.tags 'Product Prices'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/products/{id}/prices' do
    post 'Set new product price' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string
      parameter name: :product_price, in: :body,
                schema: { '$ref' => '#/components/schemas/product_price' }

      response 200, 'ok' do
        let(:product_price) { { product_price: { amount: product.latest_product_price.amount } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 201, 'created' do
        let(:product_price) { attributes_for(:product_price) }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:product_price) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:product_price) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }
        let(:product_price) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:product_price) { { product_price: { amount: -1 } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
