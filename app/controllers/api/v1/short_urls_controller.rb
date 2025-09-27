class Api::V1::ShortUrlsController < Api::V1::BaseController
  def create
    short_url = ShortUrl.find_by(original_url: short_url_params[:original_url]) || ShortUrl.create!(short_url_params)

    render json: {
      id: short_url.id,
      original_url: short_url.original_url,
      short_url: "#{request.base_url}/#{short_url.slug}",
      slug: short_url.slug,
      visits_count: short_url.visits_count,
      created_at: short_url.created_at
    }, status: :created
  end

  def short_url_params
    params.require(:short_url).permit(:original_url, :restrict_visit_count)
  end
end
