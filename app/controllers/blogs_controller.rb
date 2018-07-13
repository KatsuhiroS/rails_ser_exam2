class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy, :show]
  before_action :logged_in?, only: [:new, :edit, :show, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

      if @blog.save
        ContactMailer.contact_mail(@blog).deliver
        redirect_to blogs_path
      else
        render 'new'
      end

  end

  def confirm
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end



  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path
  end

  def logged_in?
    unless current_user.present?
      redirect_to new_session_path
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

end
