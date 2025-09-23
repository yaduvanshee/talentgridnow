require 'swagger_helper'

RSpec.describe 'api/v1/short_urls', type: :request do
  path '/api/v1/short_urls' do
    post('create short url') do
      tags 'ShortUrls'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :short_url, in: :body, schema: {
        type: :object,
        properties: {
          original_url: { type: :string }
        },
        required: ['original_url']
      }

      response(201, 'created') do
        let(:short_url) { { original_url: 'https://example.com' } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:short_url) { { original_url: '' } }
        run_test!
      end
    end
  end
end