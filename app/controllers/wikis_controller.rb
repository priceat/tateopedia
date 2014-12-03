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
    @colspan = @user.upgraded? ? 4 : 2
  end

  def collaborations_index
    @collaborations = current_user.collaborations
    @wikis = current_user.wikis.where(collaboration: true)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
     if user_signed_in?
      render :new
    else 
      flash[:error] = "You need to be signed up to do that!"
      redirect_to new_user_registration_path
    end
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    @wiki.updater = current_user.email

    if @wiki.save
      flash[:notice] = "Wiki, wiki... New Wiki ya'll"
      redirect_to wikis_my_index_path
    else
      flash[:error] = "Ain't No Wiki. Try Again!"
      render :new
    end
  end


  def edit
    @wiki = Wiki.find(params[:id])
    @wiki_updater = current_user
    @collaborators = @wiki.collaborators
    @new_collaborator = Collaborator.new
    collaborator_ids = @wiki.collaborators.pluck(:user_id)
    @collaborator_users = User.where.not(id: collaborator_ids).not(current_user.id)
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private, :collaboration, :updater))
      @wiki.update(updater: current_user.email)
      remove_collaborators
      flash[:notice] = "Your Wiki is Funkier"
      redirect_to @wiki
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

def remove_collaborators
  if params[:wiki][:private] == '0'
    @wiki.collaborators.destroy_all
  end
end

 def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaboration, :user_id)
 end

 def set_user
  @user = current_user
 end

end