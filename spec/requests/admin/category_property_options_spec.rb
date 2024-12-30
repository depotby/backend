require 'swagger_helper'

describe 'Category Property Options API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:category) { create(:category) }
  let(:category_id) { category.id }
  let(:category_property) { create(:category_property, category:) }
  let(:property_id) { category_property.id }
  let(:Authorization) do
    create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
  end
  let(:authorization_without_abilities) do
    create(:admin_authentication_without_abilities).generate_token_for(:authorization)
  end

  before do
    self.class.tags 'Category Property Options'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/categories/{category_id}/properties/{property_id}/options' do
    post 'Create new category property option' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string
      parameter name: :property_id, in: :path, type: :string
      parameter name: :category_property_option, in: :body,
                schema: { '$ref' => '#/components/schemas/category_property_option' }

      response 201, 'created' do
        let(:category_property_option) do
          { category_property_option: attributes_for(:category_property_option) }
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:category_property_option) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:category_property_option) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:category_id) { Faker::Internet.uuid }
        let(:category_property_option) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:category_property_option) { { category_property_option: { variant: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end

  path '/admin/categories/{category_id}/properties/{property_id}/options/{option_id}' do
    put 'Update category property option' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string
      parameter name: :property_id, in: :path, type: :string
      parameter name: :option_id, in: :path, type: :string
      parameter name: :category_property_option, in: :body,
                schema: { '$ref' => '#/components/schemas/category_property_option' }

      response 200, 'ok' do
        let(:option_id) { create(:category_property_option, category_property:).id }
        let(:category_property_option) do
          { category_property_option: attributes_for(:category_property_option) }
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:option_id) { Faker::Internet.uuid }
        let(:category_property_option) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:option_id) { Faker::Internet.uuid }
        let(:category_property_option) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:option_id) { Faker::Internet.uuid }
        let(:category_property_option) { nil }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:option_id) { create(:category_property_option, category_property:).id }
        let(:category_property_option) { { category_property_option: { variant: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    delete 'Delete category property option' do
      security [ authorization_header: [] ]
      parameter name: :category_id, in: :path, type: :string
      parameter name: :property_id, in: :path, type: :string
      parameter name: :option_id, in: :path, type: :string

      response 204, 'no content' do
        let(:option_id) { create(:category_property_option, category_property:).id }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:option_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:option_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:option_id) { Faker::Internet.uuid }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
