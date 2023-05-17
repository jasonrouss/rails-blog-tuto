class BlogPostsController < ApplicationController
    before_action :authenticate_user! , except: [:index, :show ,:search ]
    before_action :set_blog_post, only: [:show, :edit,:update,:destroy] 
    # except: [:index, :new, :create] 
    def index
        @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
        @pagy, @blog_posts = pagy(@blog_posts, items: 5)
    rescue Pagy::OverflowError
        redirect_to root_path(page: 1)
        # params[:page] = 1
        # retry
    end
    def show
    end
   
    def new
        @blog_post = BlogPost.new
       
    end
    def create 
        @blog_post = BlogPost.new(blog_post_params)

        if @blog_post.save
            redirect_to @blog_post
        else 
            render :new , status: :unprocessable_entity
        end
    end
    def edit
       
    end
    def update
       
        if @blog_post.update(blog_post_params)
            redirect_to @blog_post
        else
            render :edit, status: :unprocessable_entity
        end
    end  
    def destroy
       
        @blog_post.destroy
        redirect_to root_path
    end  
    def search
        @query = params[:query]
        @posts = BlogPost.where("LOWER(title) LIKE ?", "%#{params[:query].downcase}%")
    end
      
    private
    def blog_post_params
        params.require(:blog_post).permit(:title, :content,:cover_image , :published_at)
    end
 
    def set_blog_post
        @blog_post = user_signed_in? ?  BlogPost.find(params[:id])  : BlogPost.published.find(params[:id])
        
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path 
    end
   

end