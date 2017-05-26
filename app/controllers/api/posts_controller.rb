class Api::PostsController < ApplicationController
  before_action :set_post, only: :show

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
    render partial: 'post', locals: {post: @post}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
