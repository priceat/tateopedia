class WikisController < ApplicationController
  before_action :set_user
  
  def index
    @wikis = Wiki.public.paginate(page: params[:page], per_page: 10)
  end

  def private_index
    @wikis = Wiki.private
    
    if current_user.upgraded?
      render wikis_private_index_path
    else 
      flash[:error] = "You aren't a baller. But you can upgrade here!"
      redirect_to edit_user_registration_path
    end
  end

  def my_index
    @wikis = current_user.wikis.all
    @collaborations = current_user.collaborations
    @colspan = @user.upgraded? ? 4 : 2
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = current_user.wikis.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)   
    if @wiki.save
      flash[:notice] = "Wiki, wiki... New Wiki ya'll"
      redirect_to wikis_path
    else
      flash[:error] = "Ain't No Wiki. Try Again!"
      render :new
    end
  end


  def edit
    @wiki = Wiki.find(params[:id])
     @users = User.all
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private, :collaboration))
      flash[:notice] = "Your Wiki is Funkier"
      redirect_to wikis_path
    else
      flash[:error] = "Not so fast. Nothing new"
      render :edit
    end
  end

  def destroy
     @wiki = Wiki.find(params[:id])
     title = @wiki.title
 
     if @wiki.destroy
       flash[:notice] = "\"#{title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash[:error] = "There was an error deleting the wiki."
       render :show
     end
  end


private

 def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaboration, :user_id)
 end

 def set_user
  @user = current_user
 end

end