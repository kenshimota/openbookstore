class CategoriesController < ResourceProtectedUpdateController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    query = params_search

    @categories = Category
      .where("name LIKE ?", "%#{query[:search]}%")
      .limit(query[:limit])
      .offset(query[:offset])

    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      show_error
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category, status: :created
    else
      show_error
    end
  end

  # DELETE /categories/1
  def destroy
    if @category.destroy
      render status: :no_content
    else
      show_error
    end
  end

  private
    # Show errors
    def show_error
      render json: { error: @category.errors.full_messages }, status: :unprocessable_entity
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
