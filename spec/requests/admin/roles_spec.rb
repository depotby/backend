require 'swagger_helper'

# controller :roles do
#   post "roles/:id/abilities", action: :switch_ability
# end

describe 'Roles API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:Authorization) do
    create(:admin_authentication_with_all_abilities).generate_token_for(:authorization)
  end
  let(:authorization_without_abilities) do
    create(:admin_authentication_without_abilities).generate_token_for(:authorization)
  end

  before do
    self.class.tags 'Roles'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/roles' do
    get 'Get roles list' do
      security [ authorization_header: [] ]

      response 200, 'ok' do
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

    post 'Create new role' do
      security [ authorization_header: [] ]
      parameter name: :role, in: :body,
                schema: { '$ref' => '#/components/schemas/role' }

      response 201, 'created' do
        let(:role) { { role: attributes_for(:role) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:role) { { role: attributes_for(:role) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:role) { { role: attributes_for(:role) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:role) { { role: { name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end

  path '/admin/roles/{id}' do
    get 'Get role' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string

      response 200, 'ok' do
        let(:id) { create(:role_with_all_abilities).id }

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

    put 'Update role' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string
      parameter name: :role, in: :body,
                schema: { '$ref' => '#/components/schemas/role' }

      response 200, 'ok' do
        let(:id) { create(:role_with_all_abilities).id }
        let(:role) { { role: attributes_for(:role) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { Faker::Internet.uuid }
        let(:role) { { role: attributes_for(:role) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:id) { Faker::Internet.uuid }
        let(:role) { { role: attributes_for(:role) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }
        let(:role) { { role: attributes_for(:role) } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:id) { create(:role_without_abilities).id }
        let(:role) { { role: { name: nil } } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    delete 'Delete role' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string

      response 204, 'no content' do
        let(:id) { create(:role).id }

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

  path '/admin/roles/{id}/abilities' do
    post 'Switch role\'s ability' do
      security [ authorization_header: [] ]
      parameter name: :id, in: :path, type: :string
      parameter name: :role_ability, in: :body,
                schema: { '$ref' => '#/components/schemas/role_ability' }

      response 200, 'ok' do
        let(:id) { create(:role_without_abilities).id }
        let(:role_ability) { { ability: Ability.available.sample } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:Authorization) { nil }
        let(:id) { Faker::Internet.uuid }
        let(:role_ability) { { ability: Ability.available.sample } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 403, 'forbidden' do
        let(:Authorization) { authorization_without_abilities }
        let(:id) { Faker::Internet.uuid }
        let(:role_ability) { { ability: Ability.available.sample } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 404, 'not found' do
        let(:id) { Faker::Internet.uuid }
        let(:role_ability) { { ability: Ability.available.sample } }

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 422, 'unprocessable content' do
        let(:id) { create(:role_without_abilities).id }
        let(:role_ability) { { ability: 'SOME_NONEXISTEN_ABILITY:DELETE' } }

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
