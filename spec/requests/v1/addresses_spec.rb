# controller :addresses do
#   delete "addresses/:id", action: :destroy
# end

require 'swagger_helper'

describe 'Addresses API', type: :request, openapi_spec: 'v1/swagger.yaml' do
  let(:user) { create(:user) }
  let(:Authorization) { create(:authentication, user:).generate_token_for(:authorization) }

  before do
    self.class.tags 'Addresses'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
    self.class.security [ authorization_header: [] ]
  end

  path '/v1/addresses' do
    get 'Get authentications list' do
      response 200, 'ok' do
        before { create_list(:address, 2, user:) }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    post 'Create a new address' do
      parameter name: :address, in: :body,
                schema: { '$ref' => '#/components/schemas/address' }

      response 201, 'created' do
        let(:address) { { address: attributes_for(:address) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:address) { { address: { name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:address) { attributes_for(:address) }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end

  path '/v1/addresses/{id}' do
    get 'Get address data' do
      parameter name: :id, in: :path, type: :string

      response 200, 'ok' do
        let(:id) { create(:address, user:).id }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { build(:address, user:).id }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    put 'Update address data' do
      parameter name: :id, in: :path, type: :string
      parameter name: :address, in: :body,
                schema: { '$ref' => '#/components/schemas/address' }

      response 200, 'ok'  do
        let(:id) { create(:address, user:).id }
        let(:address) { { address: build(:address) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { create(:address, user:).id }
        let(:address) { { address: build(:address) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }
        let(:address) { { address: build(:address) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:id) { create(:address, user:).id }
        let(:address) { { address: { name: nil, street: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    delete 'Delete address' do
      parameter name: :id, in: :path, type: :string

      response 204, 'no content' do
        let(:id) { create(:address, user:).id }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { create(:address, user:).id }

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
