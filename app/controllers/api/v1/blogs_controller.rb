class Api::V1::BlogsController < ApplicationController
  before_action :authenticate_with_token!, only: [:index, :create, :update, :show, :destroy]

  def index
    user = current_user
    blogs = user.blogs
    json_response "Blog List", true, { blogs: blogs }, :ok
  end

  def create
    @blog = Blog.new blog_params
    @blog[:user_id] = current_user.id
    if @blog.save
      json_response "Blog save", true, { blog: @blog }, :ok
    else
      json_response "Blog not save", false, {}, :unprocessable_entity
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.user_id == current_user.id
      if @blog.update(blog_params)
        json_response "Blog Update Successfully", true, { blog: @blog }, :ok
      else
        json_response "Blog not Updates", false, {}, :unprocessable_entity
      end
    else
      json_response "You have not right access", false, {}, :unprocessable_entity
    end
  end

  def show
    @blog = Blog.find(params[:id])
    if @blog.user_id == current_user.id
      json_response "Blog show", false, { blog: @blog }, :ok
    else
      json_response "You have not right access", false, {}, :unprocessable_entity
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    if @blog.user_id == current_user.id
      if @blog.destroy
        json_response "Blog destroy successfully", true, {}, :ok
      else
        json_response "Blog not destroy", false, {}, :unprocessable_entity
      end
    else
      json_response "You have not right access", false, {}, :unprocessable_entity
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end

end
