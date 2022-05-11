class JuniorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @juniors = policy_scope(Junior)
  end

  def show
    redirect_to junior_signup_step2_path(current_user.junior) if current_user.adherent.prenom.nil?
    @junior = Junior.find(params[:id])
    authorize @junior
    AdherentSingleUpdateFileStatusJob.perform_now current_user.adherent
    @data_chiffre_affaire = data_chiffre_affaire_mensuel
    @data_nombre_etudes = data_nombre_etude_statut
    @data_jeh_rem_adherent = data_jeh_rem_adherent
  end

  def new
    @junior = Junior.new
    authorize @junior
  end

  def create
    @junior = Junior.new(junior_params)
    authorize @junior
    if @junior.save
      @user = User.new(email: "admin@#{@junior.nom.delete(' ').downcase}.fr", password: "adminadmin", password_confirmation: "adminadmin",
                       junior_id: @junior.id, admin: false)
      @user.save
      userparam = Userparam.create(user: @user)
      adherent = Adherent.create(user: @user, prenom: 'Admin', nom: 'EJC')
      membre_request = MembreRequest.create(junior_id: @junior.id, user_id: user.id, status: 'approved')
      membre = Membre.create(membre_request_id: membre_request.id, admin: true)

      @configuration = JuniorConfiguration.create(junior_id: @junior.id)
      @configuration.update(logo_params)
      flash[:success] = "Junior successfully created"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @junior = Junior.find(params[:id])
    authorize @junior
  end

  def update
    @junior = Junior.find(params[:id])
    authorize @junior
    if @junior.update(junior_params)
      flash[:success] = "Junior was successfully updated"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    @junior = Junior.find(params[:id])
    authorize @junior
    if @junior.destroy
      flash[:success] = 'Junior was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to juniors_url
  end

  def update_mode
    @junior = Junior.find(params[:junior_id])
    authorize @junior
    if cookies.encrypted[:mode_affichage] == "membre" && current_user.membre
      cookies.encrypted.permanent[:navbar_type] = "membre"
    elsif cookies.encrypted[:mode_affichage] == "adherent"
      cookies.encrypted.permanent[:navbar_type] = "adherent"
    elsif cookies.encrypted[:mode_affichage] == "administrateur" && current_user.admin
      cookies.encrypted.permanent[:navbar_type] = "administrateur"
    end
    cookies.delete :mode_affichage
    redirect_to junior_path(current_user.junior)
  end

  private

  def junior_params
    params.require(:junior).permit(:nom, :codeje)
  end

  def logo_params
    params.require(:junior).permit(:logo)
  end

  def data_chiffre_affaire_mensuel
    hash = { "January" => "Janvier", "February" => "Février", "March" => "Mars",
             "April" => "Avril", "May" => "Mai", "June" => "Juin",
             "July" => "Juillet", "August" => "Aout", "September" => "Septembre",
             "October" => "Octobre", "November" => "Novembre", "December" => "Décembre" }
    config_mois = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    mois_fr = config_mois.map { |mois| hash[mois.months.ago.to_date.strftime('%B')] }

    mois_annees = config_mois.map do |mois|
      [mois.months.ago.to_date.strftime('%m').to_i, mois.months.ago.to_date.strftime('%Y').to_i]
    end

    ca_par_mois = mois_annees.map do |mois_an|
      etudes_mois = { total: @junior.etudes.where("EXTRACT(MONTH FROM date_signature) = ? AND EXTRACT(YEAR FROM date_debut) = ?",
                                                  mois_an[0], mois_an[1]),
                      negocier: @junior.etudes.where("EXTRACT(MONTH FROM date_signature) = ? AND EXTRACT(YEAR FROM date_debut) = ? AND statut = 'En négociation'",
                                                     mois_an[0], mois_an[1]),
                      signe: @junior.etudes.where("EXTRACT(MONTH FROM date_signature) = ? AND EXTRACT(YEAR FROM date_signature) = ? AND statut = 'Signé'",
                                                  mois_an[0], mois_an[1]) }
      etudes_mois.map do |_key, etudes_type|
        ca_mois = etudes_type.map do |etude_type|
          ca_etude_type = etude_type.phases.map do |phase|
            phase.frais + phase.nombre_intervenant * phase.jeh_par_intervenant * phase.remuneration_par_jeh
          end
          ca_etude_type.inject(0, :+)
        end
      end
    end
    total = ca_par_mois.map { |ca_mois| ca_mois[0].empty? ? 0 : ca_mois[0][0] }
    negocie = ca_par_mois.map { |ca_mois| ca_mois[1].empty? ? 0 : ca_mois[1][0] }
    signe = ca_par_mois.map { |ca_mois| ca_mois[2].empty? ? 0 : ca_mois[2][0] }

    return { label: mois_fr, ca_signer: signe, ca_negocier: negocie, ca_tout: total }
  end

  def data_nombre_etude_statut
    signer = @junior.etudes.where("EXTRACT(YEAR FROM date_signature) = ? AND statut = 'Signé'", Date.today.year)
    negocier = @junior.etudes.where("EXTRACT(YEAR FROM date_signature) = ? AND statut = 'En négociation'",
                                    Date.today.year)
    { signer: signer.count, negocier: negocier.count }
  end

  def data_jeh_rem_adherent
    etudes_signees = @junior.etudes.where("EXTRACT(YEAR FROM date_signature) = ? AND statut = 'Signé'", Date.today.year)
    hashes = []
    etudes_signees.map do |etude|
      etude.phases.each do |phase|
        jeh = phase.jeh_par_intervenant * phase.nombre_intervenant
        iea = phase.indemnisation_par_jeh * jeh
        hashes.push << { jeh: jeh, iea: iea }
      end
    end
    result = { jeh: 0, iea: 0 }
    hashes.each do |hash|
      result[:jeh] += hash[:jeh]
      result[:iea] += hash[:iea]
    end
    return result
  end
end

# ["En négociation", "Signé", "Terminé", "Avorté", "Stand by"]
