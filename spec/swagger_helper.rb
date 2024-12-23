# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.1.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      servers: [
        {
          url: '{defaultHost}',
          variables: {
            defaultHost: {
              default: 'http://localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          new_user: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  first_name: { type: :string, example: Faker::Name.first_name },
                  last_name: { type: :string, example: Faker::Name.last_name },
                  middle_name: { type: :string, example: Faker::Name.middle_name },
                  email: { type: :string, example: Faker::Internet.email },
                  password: { type: :string, example: 'S0meH4Rd-p4ssw0rd!' },
                  password_confirmation: { type: :string, example: 'S0meH4Rd-p4ssw0rd!' }
                },
                required: %i[first_name last_name email password password_confirmation]
              }
            },
            required: %i[user]
          },
          update_user: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  first_name: { type: :string, example: Faker::Name.first_name },
                  last_name: { type: :string, example: Faker::Name.last_name },
                  middle_name: { type: :string, example: Faker::Name.middle_name }
                }
              }
            },
            required: %i[user]
          },
          new_authentication: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  email: { type: :string, example: Faker::Internet.email },
                  password: { type: :string, example: Faker::Internet.password }
                },
                required: %i[email password]
              }
            },
            required: %i[user]
          },
          refresh_authentication: {
            type: :object,
            properties: {
              token: { type: :string }
            },
            required: %i[token]
          },
          address: {
            type: :object,
            properties: {
              address: {
                type: :object,
                properties: {
                  name: { type: :string, example: Faker::Address.community },
                  region: { type: :string, example: Faker::Address.state },
                  city: { type: :string, example: Faker::Address.city },
                  zip: { type: :string, example: Faker::Address.zip },
                  street: { type: :string, example: Faker::Address.street_name },
                  building: { type: :string, example: Faker::Address.building_number },
                  building_section: { type: :string, example: '58' },
                  apartment: { type: :string, example: '12' }
                },
                required: %i[name region city zip street building]
              }
            },
            required: %i[address]
          }
        },
        securitySchemes: {
          authorization_header: {
            type: :http,
            scheme: :bearer,
            in: :header,
            name: 'Authorization'
          }
        }
      }
    },
    'admin/swagger.yaml' => {
      openapi: '3.1.1',
      info: {
        title: 'API Admin',
        version: 'v1'
      },
      servers: [
        {
          url: '{defaultHost}',
          variables: {
            defaultHost: {
              default: 'http://localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          new_authentication: {
            type: :object,
            properties: {
              user: {
                type: :object,
                properties: {
                  email: { type: :string, example: Faker::Internet.email },
                  password: { type: :string, example: Faker::Internet.password }
                },
                required: %i[email password]
              }
            },
            required: %i[user]
          },
          refresh_authentication: {
            type: :object,
            properties: {
              token: { type: :string }
            },
            required: %i[token]
          },
          role: {
            type: :object,
            properties: {
              role: {
                type: :object,
                properties: {
                  name: { type: :string, example: Faker::Company.department }
                },
                required: %i[name]
              }
            },
            required: %i[role]
          },
          role_ability: {
            type: :object,
            properties: {
              ability: { type: :string, example: Ability.available.first, enum: Ability.available }
            },
            required: %i[ability]
          },
          category: {
            type: :object,
            properties: {
              category: {
                type: :object,
                properties: {
                  name: { type: :string, example: Faker::Commerce.department },
                  uri_name: { type: :string, example: Faker::Commerce.department.parameterize }
                },
                required: %i[name uri_name]
              }
            },
            required: %i[category]
          }
        },
        securitySchemes: {
          authorization_header: {
            type: :http,
            scheme: :bearer,
            in: :header,
            name: 'Authorization'
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end

def write_response_example(example, response)
  return if !response || response.body.empty?

  example.metadata[:response][:content] = {
    'application/json' => {
      examples: {
        example: {
          value: JSON.parse(response.body, symbolize_names: true)
        }
      }
    }
  }
end
