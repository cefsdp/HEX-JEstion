class AdherentsController < ApplicationController
    before_action :authenticate_user!

    def edit
        @adherent = Adherent.find(params[:adherent_id])
        authorize @adherent
    end

    def update
        @adherent = Adherent.find(params[:id])
        authorize @adherent
        if @adherent.update(adherent_params)
          flash[:success] = "Object was successfully updated"
          redirect_to edit_user_registration_path
        else
          flash[:error] = "Something went wrong"
          render 'edit'
        end
    end
    
    private

    def adherent_params
    params.require(:adherent).permit(:id, :nom, :prenom, :telephone, :adresse_postale, :code_postale, :ville, :niveau_etude, :annee_diplome, :specialisation_etude)
    end
end
