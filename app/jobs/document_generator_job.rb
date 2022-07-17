require "open-uri"
require 'rexml/document'
require 'rexml/text'

class DocumentGeneratorJob < ApplicationJob
  queue_as :default

  def perform(objectdocument, type_doc)
    treatment_info = getting_document_and_data_info(objectdocument, type_doc)
    document = treatment_info[:document]
    tempfile_type = treatment_info[:document_type]
    tempfile_url = treatment_info[:document_url]
    objects_data = preparing_data(objectdocument)
    changes_to_do = getting_changes_to_do(type_doc, objects_data, objectdocument)
    tempfile_name = downloading_document_from_db(tempfile_url, tempfile_type)
    pages_to_change = getting_document_content(tempfile_name, tempfile_type)
    changing_document_content(pages_to_change, changes_to_do, tempfile_name, tempfile_type)
    save_generated_document(objectdocument, tempfile_name, tempfile_type)
    File.delete("app/assets/docs/#{tempfile_name}.#{tempfile_type}")
  end

  private

  #=======================================================================================================================

  def getting_document_and_data_info(objectdocument, _type_doc)
    document = ConfigDocEtude.find_by(nom: objectdocument.nom).document_type
    document_url = document.url
    document_type = document.filename.extension_without_delimiter
    return { document: document, document_url: document_url, document_type: document_type }
  end

  #=======================================================================================================================

  def preparing_data(objectdocument)
    result = []
    case objectdocument.class.to_s
    when "DocumentAdhesion"
      adherent = objectdocument.adherent
      user = adherent.user
    when "DocumentAdherent"
      adherent = objectdocument.adherent
      user = adherent.user
    when "DocumentEtude"
      etude = objectdocument.etude
      client = etude.client
      junior = etude.junior
    when "DocumentPhase"
      phase = objectdocument.phase
      etude = phase.etude
      client = etude.client
      junior = etude.junior
    when "DocumentPostulant"
      postulant = objectdocument.postulant
      adherent = postulant.adherent
      user = adherent.user
      phase = postulant.phase
      etude = phase.etude
      client = etude.client
      junior = etude.junior
    when "DocumentIntervenant"
      intervenant = objectdocument.intervenant
      adherent = intervenant.user.adherent
      user = adherent.user
      phase = intervenant.phase
      etude = phase.etude
      client = etude.client
      junior = etude.junior
    end
    return { user: user, adherent: adherent, postulant: postulant, junior: junior, etude: etude,
             client: client, phase: phase, intervenant: intervenant }
  end

  #=======================================================================================================================

  def getting_changes_to_do(type_doc, corelated_objects_data, objectdocument)
    result = []
    result += infos_document(objectdocument)
    case type_doc
    when "adhesion"
      result += infos_adherent(corelated_objects_data) unless infos_adherent(corelated_objects_data).nil?
      result += infos_adhesion(corelated_objects_data) unless infos_adhesion(corelated_objects_data).nil?
    when "adherent"
      result += infos_adherent(corelated_objects_data) unless infos_adherent(corelated_objects_data).nil?
    when "etude"
      result += infos_etude(corelated_objects_data) unless infos_etude(corelated_objects_data).nil?
    when "phase"
      result += infos_etude(corelated_objects_data) unless infos_etude(corelated_objects_data).nil?
      result += infos_phase(corelated_objects_data) unless infos_phase(corelated_objects_data).nil?
    when "postulant"
      result += infos_etude(corelated_objects_data) unless infos_etude(corelated_objects_data).nil?
      result += infos_phase(corelated_objects_data) unless infos_phase(corelated_objects_data).nil?
      result += infos_adherent(corelated_objects_data) unless infos_adherent(corelated_objects_data).nil?
      result += infos_adhesion(corelated_objects_data) unless infos_adhesion(corelated_objects_data).nil?
      result += infos_postulant(corelated_objects_data) unless infos_postulant(corelated_objects_data).nil?
    when "intervenant"
      result += infos_etude(corelated_objects_data) unless infos_etude(corelated_objects_data).nil?
      result += infos_phase(corelated_objects_data) unless infos_phase(corelated_objects_data).nil?
      result += infos_adherent(corelated_objects_data) unless infos_adherent(corelated_objects_data).nil?
      result += infos_adhesion(corelated_objects_data) unless infos_adhesion(corelated_objects_data).nil?
      result += infos_intervenant(corelated_objects_data) unless infos_intervenant(corelated_objects_data).nil?
    end
    result += infos_junior(corelated_objects_data) unless infos_junior(corelated_objects_data).nil?
    return result
  end

  def infos_adhesion(objects_data)
    adhesion = objects_data[:adhesion]
    data = [{ keyword: "HEXHEX", datum: " " }]
    return data
  end

  def infos_document(objectdocument)
    document = objectdocument
    data = [{ keyword: "HEXReferenceDocumentHEX", datum: document.ref_doc },
            { keyword: "HEXDateSignatureDocumentHEX", datum: document.date_signature }]
    return data
  end

  def infos_adherent(objects_data)
    adherent = objects_data[:adherent]
    if adherent.nil?
      data = [{ keyword: "HEXNomAdherentHEX", datum: adherent.nom }, { keyword: "HEXPrenomAdherentHEX", datum: adherent.prenom },
              { keyword: "HEXTelephoneAdherentHEX", datum: adherent.telephone }, { keyword: "HEXAdressePostaleAdherentHEX", datum: adherent.adresse_postale },
              { keyword: "HEXCodePostalAdherentHEX", datum: adherent.code_postale }, { keyword: "HEXVilleAdherentHEX", datum: adherent.ville },
              { keyword: "HEXNiveauEtudeHEX", datum: adherent.niveau_etude }, { keyword: "HEXAnneeDiplomeHEX", datum: adherent.anneediplome },
              { keyword: "HEXSpecialisationEtudeHEX", datum: adherent.specialisation_etude }]
    end
    return data
  end

  def infos_etude(objects_data)
    etude = objects_data[:etude]
    client = objects_data[:client]
    phases = etude.phases
    data = []
    unless client.nil?
      data.concat([{ keyword: "HEXSexeClientHEX", datum: client.sexe }, { keyword: "HEXLangueClientHEX", datum: client.langue },
                   { keyword: "HEXPrenomClientHEX", datum: client.prenom }, { keyword: "HEXNomClientHEX", datum: client.nom },
                   { keyword: "HEXEmailClientHEX", datum: client.email }, { keyword: "HEXTelephoneClientHEX", datum: client.telephone },
                   { keyword: "HEXEntrepriseClientHEX", datum: client.entreprise }, { keyword: "HEXPosteClientHEX", datum: client.poste },
                   { keyword: "HEXSiteWebClientHEX", datum: client.site_web }, { keyword: "HEXTelephoneEntrepriseClientHEX", datum: client.telephone_entreprise },
                   { keyword: "HEXSiretClientHEX", datum: client.siret }, { keyword: "HEXTypeEntrepriseClientHEX", datum: client.type_entreprise },
                   { keyword: "HEXActiviteClientHEX", datum: client.activite }, { keyword: "HEXAdresseClientHEX", datum: client.adresse },
                   { keyword: "HEXVilleClientHEX", datum: client.ville }, { keyword: "HEXCodePostalClientHEX", datum: client.code_postal },
                   { keyword: "HEXPaysClientHEX", datum: client.pays }, { keyword: "HEXProvenanceClientHEX", datum: client.provenance },
                   { keyword: "HEXPremierContactClientHEX", datum: client.premier_contact }])
    end
    unless etude.nil?
      unless etude.charge_etude.nil?
        charge_etude = etude.charge_etude.adherent.prenom + " " + etude.charge_etude.adherent.nom
      end
      unless etude.charge_qualite.nil?
        charge_qualite = etude.charge_qualite.adherent.prenom + " " + etude.charge_qualite.adherent.nom
      end
      charge_rh = etude.charge_rh.adherent.prenom + " " + etude.charge_rh.adherent.nom unless etude.charge_rh.nil?
      data.concat([{ keyword: "HEXPrestationEtudeHEX", datum: etude.prestation.nom }, { keyword: "HEXConfidentialiteEtudeHEX", datum: etude.confidentielle },
                   { keyword: "HEXChargeEtudeHEX", datum: charge_etude }, { keyword: "HEXChargeQualiteEtudeHEX", datum: charge_qualite },
                   { keyword: "HEXEmailChargeEtudeHEX", datum: etude.charge_etude.user.email }, { keyword: "HEXTelephoneChargeEtudeHEX", datum: etude.charge_etude.adherent.telephone },
                   { keyword: "HEXEmailChargeQualiteHEX", datum: etude.charge_qualite.user.email }, { keyword: "HEXTelephoneChargeQualiteHEX", datum: etude.charge_qualite.adherent.telephone },
                   { keyword: "HEXEmailChargeRHHEX", datum: etude.charge_rh.user.email }, { keyword: "HEXTelephoneChargeRHHEX", datum: etude.charge_rh.adherent.telephone },
                   { keyword: "HEXChargeRHEtudeHEX", datum: charge_rh }, { keyword: "HEXStatutEtudeHEX", datum: etude.statut },
                   { keyword: "HEXDateDebutEtudeHEX", datum: etude.date_debut }, { keyword: "HEXReferenceEtudeHEX", datum: etude.ref_etude },
                   { keyword: "HEXDateSignatureHEX", datum: etude.date_signature }, { keyword: "HEXNomEtudeHEX", datum: etude.nom }])
    end
    unless phases.empty?
      phases.each_with_index do |phase, index|
        data.concat([{ keyword: "HEXNomPhase#{index}HEX", datum: phase.nom }, { keyword: "HEXDateDebutPhase#{index}HEX", datum: phase.date_debut },
                     { keyword: "HEXDateFinPhase#{index}HEX", datum: phase.date_fin }, { keyword: "HEXNombreIntervenantPhase#{index}HEX", datum: phase.nombre_intervenant },
                     { keyword: "HEXJehParIntervenantPhase#{index}HEX", datum: phase.jeh_par_intervenant }, { keyword: "HEXFraisPhase#{index}HEX", datum: phase.frais },
                     { keyword: "HEXDescriptionPhase#{index}HEX", datum: phase.description_phase }, { keyword: "HEXDescriptionMissionIntervenantPhase#{index}HEX", datum: phase.description_mission_intervenant },
                     { keyword: "HEXIndemnisationParJehPhase#{index}HEX", datum: phase.indemnisation_par_jeh }, { keyword: "HEXMontantParJehPhase#{index}HEX", datum: phase.remuneration_par_jeh },
                     { keyword: "HEXLieuxMissionPhase#{index}HEX", datum: phase.lieux_mission }, { keyword: "HEXSpecialisationPostulantPhase#{index}HEX", datum: phase.specialisation_postulant },
                     { keyword: "HEXNiveauEtudePostulantPhase#{index}HEX", datum: phase.niveau_etude_postulant }, { keyword: "HEXStatutPhase#{index}HEX", datum: phase.statut }])
      end
    end
    return data
  end

  def infos_phase(objects_data)
    phase = objects_data[:phase]
    unless phase.nil?
      data = [{ keyword: "HEXNomPhaseHEX", datum: phase.nom }, { keyword: "HEXDateDebutPhaseHEX", datum: phase.date_debut },
              { keyword: "HEXDateFinPhaseHEX", datum: phase.date_fin }, { keyword: "HEXNombreIntervenantPhaseHEX", datum: phase.nombre_intervenant },
              { keyword: "HEXJehParIntervenantPhaseHEX", datum: phase.jeh_par_intervenant }, { keyword: "HEXFraisPhaseHEX", datum: phase.frais },
              { keyword: "HEXDescriptionPhaseHEX", datum: phase.description_phase }, { keyword: "HEXDescriptionMissionIntervenantPhaseHEX", datum: phase.description_mission_intervenant },
              { keyword: "HEXIndemnisationParJehPhaseHEX", datum: phase.indemnisation_par_jeh }, { keyword: "HEXMontantParJehPhaseHEX", datum: phase.remuneration_par_jeh },
              { keyword: "HEXLieuxMissionPhaseHEX", datum: phase.lieux_mission }, { keyword: "HEXSpecialisationPostulantPhaseHEX", datum: phase.specialisation_postulant },
              { keyword: "HEXNiveauEtudePostulantPhaseHEX", datum: phase.niveau_etude_postulant }, { keyword: "HEXStatutPhaseHEX", datum: phase.statut }]
    end
    return data
  end

  def infos_postulant(objects_data)
    postulant = objects_data[:postulant]
    data = [{ keyword: "HEXilnyarieniciHEX", datum: " " }]
    return data
  end

  def infos_intervenant(objects_data)
    intervenant = objects_data[:intervenant]
    data = [{ keyword: "HEXreference_rmHEX", datum: intervenant.ref_rm }]
    return data
  end

  def infos_junior(objects_data)
    junior = objects_data[:junior]
    data = [{ keyword: "HEXNomJuniorHEX", datum: junior.nom }] unless junior.nil?
    return data
  end

  #=======================================================================================================================

  def downloading_document_from_db(temp_url, tempfile_type)
    tempfile_name = 20.times.map { rand(10) }.join
    if File.exist?("app/assets/docs/#{tempfile_name}.#{tempfile_type}")
      File.delete("app/assets/docs/#{tempfile_name}.#{tempfile_type}")
    end
    tempfile = Down.download(temp_url)
    FileUtils.mv(tempfile.path, "app/assets/docs/#{tempfile_name}.#{tempfile_type}")
    return(tempfile_name)
  end

  #=======================================================================================================================

  def getting_document_content(file_name, tempfile_type)
    buffer = []
    Zip::ZipFile.open("app/assets/docs/#{file_name}.#{tempfile_type}").each do |file|
      buffer << file.name
    end
    final = []
    buffer.each do |thing|
      buff = []
      buff << thing if thing.end_with?(".xml")
      buff.each do |object|
        final << object if object.start_with?("word/") || object.start_with?("ppt/")
      end
    end
    return final
  end

  #=======================================================================================================================

  def changing_document_content(pages_to_change, changes_to_do, file_name, tempfile_type)
    zip = Zip::ZipFile.open("app/assets/docs/#{file_name}.#{tempfile_type}")
    pages_to_change.each do |zip_file|
      file = zip.find_entry(zip_file)
      doc = Nokogiri::XML.parse(file.get_input_stream)
      changes_to_do.each do |change|
        doc.xpath("//*[contains(text(),'#{change[:keyword]}')]").each do |part|
          part.content = change[:datum]
        end
      end
      zip.get_output_stream(zip_file) { |f| f << doc.to_s }
    end
    zip.close
  end
end

#=======================================================================================================================

def save_generated_document(objectdocument, file_name, tempfile_type)
  objectdocument.generated_document.attach(io: File.open("app/assets/docs/#{file_name}.#{tempfile_type}"),
                                           filename: "#{file_name}.#{tempfile_type}")
end
