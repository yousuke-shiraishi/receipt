class PicturesController < ApplicationController
  before_action :login_validate, only: %i[new edit show]
  before_action :set_search
  before_action :set_picture, only: %i[edit show update destroy]
  include CarrierwaveBase64Uploader
  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all.order(updated_at: :desc)
  end

  def search
    unless params[:q].nil?
      params[:q]['search_word_cont_any'] = params[:q]['search_word_cont_any'].split(/[\p{blank}\s]+/)
    end
    @keyword = Picture.ransack(params[:q])
    @pictures = @keyword.result
  end


  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = current_user.pictures.build(gmap_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
    gon.picture = @picture.image.url
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(exchange_params)
    @picture.user_id = current_user.id
    PicturetoMailer.pictureto_mail(@picture.user).deliver
      if @picture.save
        redirect_to @picture, notice: 'Picture was successfully created.'
      else
        render :new
      end
  end

  def update
    @picture.update!(exchange_params)
    redirect_to @picture
  end

  def destroy
    if @picture.destroy
      redirect_to pictures_url, notice: 'Picture was successfully destroyed.'
    end
  end

  def confirm
    @favorites_pictures = current_user.favorite_pictures
  end

  def check
    @picture = current_user.pictures.build(picture_params)
    gon.picture = @picture.image.url
    render :new if @picture.invalid?
  end

  private

  def set_search
    @keyword = Picture.search(params[:q])
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:title, :user_id, :content, :image, :custom_image, :search_word, :q)
  end

  def exchange_params
    temp_picture_params = picture_params
    unless temp_picture_params[:custom_image].blank?
      temp_picture_params[:image] = base64_conversion(picture_params[:custom_image])
    end
    picture_params[:custom_image] = nil
    temp_picture_params
  end

  def login_validate
    if session[:user_id]
      begin
        @user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    redirect_to new_session_path unless @user
  end
end
