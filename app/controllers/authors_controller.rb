class AuthorsController < ResourceProtectedUpdateController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  def index
    query = params_search

    @authors = Author
      .where("name LIKE ?", "%#{query[:search]}%")
      .limit(query[:limit])
      .offset(query[:offset])

    render json: @authors
  end

  # GET /authors/1
  def show
    render json: @author
  end

  # POST /authors
  def create
    @author = Author.new(author_params)
    if @author.save
      render status: :created, json: @author
    else
      show_error
    end
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      render status: :acepted, json: @author
    else
      show_error
    end
  end

  # DELETE /authors/1
  def destroy
    if @author.destroy
      render status: :no_content
    else
      show_error
    end
  end

  private
    # Show errors
    def show_error
      render json: { error: @author.errors.full_messages }, status: :unprocessable_entity
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name)
    end
end
