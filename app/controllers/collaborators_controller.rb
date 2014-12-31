class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: [:show, :edit, :update, :destroy]
  before_action :set_wiki, only: [:new, :create, :index, :destroy]

  def index
    @collaborators = @wiki.collaborators

  end

  def show
    @collaborators = @wiki.collaborators
  end

  def new
    @new_collaborator = Collaborator.new
    collaborator_ids = @wiki.collaborators.pluck(:user_id)
    @collaborator_users = User.where.not(id: collaborator_ids).not(current_user.id)
  end


  def edit
    @collaborators = @wiki.collaborators
  end

  def create
    @collaborator = @wiki.collaborators.build(collaborator_params)

    respond_to do |format|
       if @collaborator.save
         @user = @collaborator.user
         @user.update(member: true)
         @wiki.update(collaboration: true)
        format.html { redirect_to wiki_path(@wiki), notice: 'Collaborator was successfully added.' }
        format.json { render :edit, status: :created, location: @collaborator }
       else
        format.html { render :new }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
       end
    end
  end


  def update
      if @collaborator.update(collaborator_params)
        flash[:notice] = 'Collaborator was successfully updated.' 
        redirect_to @collaborator
      else
        flash[:error] = "No can do. Try Again!"
        render :edit
      end
  end


  def destroy
    @collaborator.destroy
    respond_to do |format|
      format.html { redirect_to edit_wiki_path(@wiki), notice: 'Collaborator was successfully removed.' }
      format.json { head :no_content }
     
    end
  end

  private
    
  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
  end

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
