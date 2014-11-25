class WikisController < ApplicationController
  
  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    
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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
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
    params.require(:wiki).permit(:title, :body, :private)
  end

end