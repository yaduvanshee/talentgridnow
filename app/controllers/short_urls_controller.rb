class ShortUrlsController < ApplicationController
  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.find_by(original_url: short_url_params[:original_url])
    if @short_url.blank?
      @short_url = ShortUrl.new(short_url_params)
      if @short_url.save
        flash[:notice] = "Short URL created"
        redirect_to short_url_path(@short_url)
        return
      end

      flash.now[:alert] = @short_url.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    else
      flash[:alert] = "Short URL already exists"
      redirect_to short_url_path(@short_url) and return
    end
  end

  def show
    @short_url = ShortUrl.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Short URL not found"
    redirect_to new_short_url_path
  end

  def redirect
    @short_url = ShortUrl.find_by!(slug: params[:slug])
    if @short_url.can_be_visited?
      @short_url.increment_visits!
      redirect_to @short_url.original_url, allow_other_host: true
    else
      render plain: "Short URL visit limit reached", status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render plain: "Short URL not found", status: :not_found
  end

  private

  def short_url_params
    params.require(:short_url).permit(:original_url, :restrict_visit_count)
  end
end
