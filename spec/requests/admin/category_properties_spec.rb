require 'swagger_helper'

describe 'Category Properties API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:category) { create(:category) }
  let(:category_id) { category.id }
  let(:Authorization) do
    create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
  end
  let(:authorization_without_abilities) do
    create(:admin_authentication_without_abilities).generate_token_for(:authorization)
  end

  before do
    self.class.tags 'Category Properties'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/categories/{category_id}/properties' do
    get 'Get category properties list' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string

      response 200, 'ok' do
        before do
          create(:category_property, category:)
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

      response 404, 'not found' do
        let(:category_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    post 'Create new category property' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string
      parameter name: :category_property, in: :body,
                schema: { '$ref' => '#/components/schemas/category_property' }

      response 201, 'created' do
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:category_id) { Faker::Internet.uuid }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:category_property) { { category_property: { name: nil, uri_name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end

  path '/admin/categories/{category_id}/properties/{property_id}' do
    get 'Get category property' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string
      parameter name: :property_id, in: :path, type: :string

      response 200, 'ok' do
        let(:property_id) { create(:category_property, category:).id }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:property_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:property_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:property_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    put 'Update category property' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string
      parameter name: :property_id, in: :path, type: :string
      parameter name: :category_property, in: :body,
                schema: { '$ref' => '#/components/schemas/category_property' }

      response 200, 'ok' do
        let(:property_id) { create(:category_property, category:).id }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:property_id) { Faker::Internet.uuid }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:property_id) { Faker::Internet.uuid }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:property_id) { Faker::Internet.uuid }
        let(:category_property) { { category_property: attributes_for(:category_property) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:property_id) { create(:category_property, category:).id }
        let(:category_property) { { category_property: { name: nil, uri_name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    delete 'Delete category property' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string
      parameter name: :property_id, in: :path, type: :string

      response 204, 'no content' do
        let(:property_id) { create(:category_property, category:).id }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:property_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:property_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:property_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
