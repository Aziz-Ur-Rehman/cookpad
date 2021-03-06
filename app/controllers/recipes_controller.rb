class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@recipes=Recipe.all.order("created_at DESC")
	end
	def show
		
	end
	def new
		@recipe = current_user.recipes.build
	end
	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created new recipe"
		else
			render 'new'
		end	
	end

	def edit
		
	end

	def update

		if @recipe.update(recipe_params)
			redirect_to @recipe, notice: "Recipe was successfully updated"
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path
	end

	def upvote
		@recipe.upvote_by current_user
		redirect_to :bacck
		
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image)
		
	end

	def find_recipe
		@recipe =Recipe.find(params[:id])
		
	end
end
