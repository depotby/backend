require 'swagger_helper'

describe 'Authentications API', type: :request, openapi_spec: 'admin/swagger.yaml' do
  let(:user) { create(:employee_with_all_abilities) }

  before do
    self.class.tags 'Authentications'
    self.class.consumes 'application/json'
    self.class.produces 'application/json'
  end

  path '/admin/authentications' do
    get 'Get authentications list' do
      security [ authorization_header: [] ]

      response 200, 'ok' do
        before { create(:admin_authentication_with_all_abilities, user:) }

        let(:Authorization) do
          create(:admin_authentication_with_all_abilities, user:).generate_token_for(:authorization)
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

    post 'Create new authentication' do
      parameter name: :new_authentication, in: :body,
                schema: { '$ref' => '#/components/schemas/new_authentication' }

      response 201, 'created' do
        let(:new_authentication) do
          { user: { email: user.email, password: user.password } }
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:new_authentication) do
          { user: { email: nil, password: nil } }
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end

    delete 'Delete authentication' do
      security [ authorization_header: [] ]

      response 204, 'no content' do
        let(:Authorization) do
          create(:admin_authentication_with_all_abilities, user:).generate_token_for(:authorization)
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

  path '/admin/authentications/refresh' do
    post 'Refresh authentication' do
      parameter name: :refresh_authentication, in: :body,
                schema: { '$ref' => '#/components/schemas/refresh_authentication' }

      response 201, 'created' do
        let(:refresh_authentication) do
          token = create(:admin_authentication_with_all_abilities, user:)
                    .generate_token_for(:refresh)

          { token: }
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end

      response 401, 'unauthorized' do
        let(:refresh_authentication) do
          { token: nil }
        end

        after { |example| write_response_example(example, response) }

        run_test!
      end
    end
  end
end
