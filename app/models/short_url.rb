class ShortUrl < ApplicationRecord
  before_validation :generate_slug, on: :create

  validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :slug, presence: true, uniqueness: true

  def increment_visits!
    self.class.where(id: id).update_all("visits_count = visits_count + 1")
    reload
  end

  def can_be_visited?
    return true if restrict_visit_count.nil?

    visits_count < restrict_visit_count
  end

  private

  def generate_slug
    return if slug.present?

    6.times do
      candidate = SecureRandom.base58(6)
      unless self.class.exists?(slug: candidate)
        self.slug = candidate
        break
      end
    end
    self.slug ||= SecureRandom.hex(4)
  end
end
