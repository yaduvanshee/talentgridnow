require 'rails_helper'

RSpec.describe "ShortUrls", type: :request do
  describe "POST /short_urls" do
    context "with valid params" do
      let(:valid_attributes) { { original_url: "http://example.com" } }

      it "creates a new ShortUrl" do
        expect {
          post "/short_urls", params: { short_url: valid_attributes }
        }.to change(ShortUrl, :count).by(1)
      end

      it "redirects to the new short_url" do
        post "/short_urls", params: { short_url: valid_attributes }
        expect(response).to redirect_to(short_url_path(ShortUrl.last))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { original_url: "invalid-url" } }

      it "does not create a new ShortUrl" do
        expect {
          post "/short_urls", params: { short_url: invalid_attributes }
        }.not_to change(ShortUrl, :count)
      end

      it "renders the new template with flash alert" do
        post "/short_urls", params: { short_url: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to include("Original URL")

        expect(flash[:alert]).to eq("Original url is invalid")
      end
    end

    context "when short URL already exists" do
      let!(:existing_short_url) { ShortUrl.create(original_url: "http://example.com") }

      it "does not create a new ShortUrl and redirects to existing one" do
        expect {
          post "/short_urls", params: { short_url: { original_url: "http://example.com" } }
        }.not_to change(ShortUrl, :count)

        expect(response).to redirect_to(short_url_path(existing_short_url))
        expect(flash[:alert]).to eq("Short URL already exists")
      end
    end
  end
end
