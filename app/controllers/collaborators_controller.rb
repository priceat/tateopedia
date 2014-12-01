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
    @users = User.not(current_user.id)
    @collaborator = @wiki.collaborators.new
  end


  def edit
    @collaborators = @wiki.collaborators
  end

  def create
    @collaborator = @wiki.collaborators.build(collaborator_params)

        if @collaborator.save
          @user = @collaborator.user(params[:user_id])
          @wiki = @collaborator.wiki(params[:wiki_id])
          @user.update(member: true)
          @wiki.update(collaboration: true)
        flash[:notice] = 'Collaborator was successfully created.'
        redirect_to @wiki
      else
        flash[:error] = "No can do. Try Again!"
        render :new
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
      flash[:notice] = 'Collaborator was successfully destroyed.'
      redirect_to @wiki
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
