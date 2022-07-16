class EtudesController < ApplicationController
  before_action :authenticate_user!

  def index
    @etudes = policy_scope(Etude)
  end

  def show
    @etude = Etude.find(params[:id])
    @junior = @etude.junior
    @new_client = Client.new
    @phases = @etude.phases.order("date_debut ASC")
    @document_etudes = @etude.document_etudes.order("date_signature ASC")
    @etapes = order_by_date(@phases, @document_etudes)
    @new_phase = Phase.new
    authorize @etude
  end

  def new
    @junior = Junior.find(junior_id_params)
    @etude = Etude.new
    authorize @etude
    @new_reference = new_ref_calculation
  end

  def create
    @junior = Junior.find(junior_id_params)
    @etude = Etude.new(etude_params)
    @etude.junior = @junior
    authorize @etude
    if @etude.save
      flash[:success] = "Object successfully created"
      redirect_to junior_etude_path(@junior, @etude)
    else
      flash[:error] = "Something went wrong"
      render junior_etude_path(@junior, @etude)
    end
  end

  def update
    @etude = Etude.find(params[:id])
    @junior = Junior.find(junior_id_params)
    authorize @etude
    if etude_params[:client] == "remove"
      @etude.update(client: nil)
      redirect_to junior_etude_path(@junior, @etude)
    elsif @etude.update(etude_params)
      flash[:success] = "Etude was successfully updated"
      redirect_to junior_etude_path(@junior, @etude)
    else
      flash[:error] = "Something went wrong"
      render junior_etude_path(@junior, @etude)
    end
  end

  def destroy
    @etude = Etude.find(params[:id])
    authorize @etude
    if @etude.destroy
      flash[:success] = 'Etude was successfully deleted.'
      redirect_to etudes_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to etudes_url
    end
  end

  private

  def etude_params
    params.require(:etude).permit!
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def new_ref_calculation
    if @etudes.nil?
      Date.today.strftime("%y") + "001"
    elsif @etudes.order(:ref_etude).last
      @etudes.order(:ref_etude).last.ref_etude.to_i + 1
    else
      Date.today.strftime("%y") + "001"
    end
  end

  def order_by_date(phases, docs)
    etapes = phases + docs
    resultat = []
    etapes.each do |etape|
      date = nil
      case etape.class.to_s
      when "Phase"
        etape.date_debut.nil? ? date = etape.created_at : date = etape.date_debut
      when "DocumentEtude"
        etape.date_signature.nil? ? date = etape.created_at : date = etape.date_signature
      end
      resultat << { date: date, etape: etape }
    end
    return resultat.sort_by! { |etape| etape[:date] }
  end
end
