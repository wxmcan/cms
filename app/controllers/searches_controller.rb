class SearchesController < ApplicationController

  def index
  end

  def create
    q = params[:q].gsub(/\s+/, "")
    @results = Spina::Page.live.where("jsonb_extract_path_text(json_attributes, 'en_content') ILIKE ? OR jsonb_extract_path_text(json_attributes, 'zh-CN_content') ILIKE ?", "%#{q}%", "%#{q}%")

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('searches', partial: 'searches/search') }
    end

  end

end
