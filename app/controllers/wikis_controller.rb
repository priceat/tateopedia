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
    @collaborations = current_user.wiki_collaborations
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

    respond_to do |format|
    if @wiki.save
      format.html { redirect_to @wiki, notice: "Wiki, wiki... New Wiki ya'll" }
      format.json { render :show, status: :created, location: @wiki }
    else
      format.html { render :new }
      format.json { render json: @wiki.errors, status: :unprocessable_entity }
    
    end
    end
  end


  def edit
    @wiki = Wiki.find(params[:id])
    @wiki_updater = current_user.email
    @collaborators = @wiki.collaborators
    @new_collaborator = Collaborator.new
    collaborator_ids = @wiki.collaborators.pluck(:user_id) << current_user.id
    @collaborator_users = User.where.not(id: collaborator_ids)
  end

  def update
    @wiki = Wiki.find(params[:id])

    respond_to do |format|
      if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private, :collaboration, :updater))
        @wiki.update(updater: current_user.email)
        remove_collaborators
        format.html { redirect_to @wiki, notice: "Your Wiki is Funkier!" }
        format.json { render :show, status: :ok, location: @wiki }
      
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     @wiki = Wiki.find(params[:id])
 
     @wiki.destroy
      respond_to do |format|
      format.html { redirect_to wikis_url, notice: 'Wiki was successfully destroyed.' }
      format.json { head :no_content }

     end
  end


  private

  def remove_collaborators
    if params[:wiki][:private] == '0'
      @wiki.collaborators.destroy_all
    end
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :collaboration, :user_id, :updater)
  end

  def set_user
    @user = current_user
  end

end