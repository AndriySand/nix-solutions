class PostsController < ApplicationController
  before_action :set_post, only: :show

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
