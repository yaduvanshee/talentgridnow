require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  it "is model exists" do
    expect(ShortUrl.new).to be_a(ShortUrl)
  end

  it "is valid with valid attributes" do
    short_url = ShortUrl.new(original_url: "http://example.com")
    expect(short_url).to be_valid
  end

  it "through error for duplicate slug" do
    short_url1 = ShortUrl.create(original_url: "http://example.com")
    short_url2 = ShortUrl.new(original_url: "http://another-example.com", slug: short_url1.slug)
    expect(short_url2).not_to be_valid
    expect(short_url2.errors[:slug]).to include("has already been taken")
  end

  it "generates a slug on creation" do
    short_url = ShortUrl.create(original_url: "http://example.com")
    expect(short_url.slug).to be_present
    expect(short_url.slug.length).to eq(6).or eq(8)
  end

  it "increments visits count" do
    short_url = ShortUrl.create(original_url: "http://example.com")
    expect(short_url.visits_count).to eq(0)
    short_url.increment_visits!
    expect(short_url.visits_count).to eq(1)
  end
end
