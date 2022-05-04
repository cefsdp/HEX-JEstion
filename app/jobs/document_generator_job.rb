class DocumentGeneratorJob < ApplicationJob
  queue_as :default

  def perform(objectdocument, type_doc)
    treatment_info = getting_document_and_data_info(objectdocument, type_doc)
    document = treatment_info[:document]
    tempfile_type = treatment_info[:document_type]
    tempfile_url = treatment_info[:document_url]
    objects_data = preparing_data(objectdocument)
    changes_to_do = getting_changes_to_do(type_doc, objects_data)
    tempfile_name = downloading_document_from_db(tempfile_url, tempfile_type)
    raise
    pages_to_change = getting_document_content(tempfile_name, tempfile_type)
    changing_document_content(pages_to_change, changes_to_do)
    send_file "#{Rails.root}/app/assets/docs/#{file_name}.#{tempfile_type}", disposition: 'attachment'
  end

  
  private

  #=======================================================================================================================

  def getting_document_and_data_info(objectdocument, type_doc)
    document = objectdocument.document
    document_url = document.url
    document_type = document.filename.extension_without_delimiter
    return {document: document, document_url: document_url, document_type: document_type}
  end

  #=======================================================================================================================

  def preparing_data(objectdocument)
    result = []
    case objectdocument.class
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
    return {user: user, adherent: adherent, postulant: postulant, junior: junior, etude: etude,
            client: client, phase: phase, intervenant: intervenant}
  end

  #=======================================================================================================================

  def getting_changes_to_do(type_doc, corelated_objects_data)
    result = []
    case type_doc
    when "adhesion"
      result << infos_adherent(corelated_objects_data)
      result << infos_adhesion(corelated_objects_data)
    when "adherent"
      result << infos_adherent(corelated_objects_data)
    when "etude"
      result << infos_etude(corelated_objects_data)
    when "phase"
      result << infos_etude(corelated_objects_data)
      result << infos_phase(corelated_objects_data)
    when "postulant"
      result << infos_etude(corelated_objects_data)
      result << infos_phase(corelated_objects_data)
      result << infos_adherent(corelated_objects_data)
      result << infos_adhesion(corelated_objects_data)
      result << infos_postulant(corelated_objects_data)
    when "intervenant"
      result << infos_etude(corelated_objects_data)
      result << infos_phase(corelated_objects_data)
      result << infos_adherent(corelated_objects_data)
      result << infos_adhesion(corelated_objects_data)
      result << infos_intervenant(corelated_objects_data)
    end
    result << infos_junior
    return result
  end

  def infos_adhesion
    adhesion_data = objects_data[:adhesion]
    data = {keyword: "% %", datum: " "}
  end

  def infos_adherent
    adherent_data = objects_data[:adherent]
    data = {keyword: "%nom%", datum: adherent.nom}
  end

  def infos_etude
    etude_data = objects_data[:etude]
    data = {keyword: "% %", datum: " "}
  end

  def infos_phase
    phase_data = objects_data[:phase]
    data = {keyword: "% %", datum: " "}
  end

  def infos_postulant
    postulant_data = objects_data[:postulant]
    data = {keyword: "% %", datum: " "}
  end

  def infos_intervenant
    intervenant_data = objects_data[:intervenant]
    data = {keyword: "% %", datum: " "}
  end

  def infos_junior
    junior_data = objects_data[:junior]
    data = {keyword: "% %", datum: " "}
  end

  #=======================================================================================================================

  def downloading_document_from_db(temp_url, tempfile_type)
    tempfile_name = 20.times.map { rand(10) }.join
    File.delete("app/assets/docs/#{tempfile_name}.#{tempfile_type}") if File.exist?("app/assets/docs/#{tempfile_name}.#{tempfile_type}")
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
      final << object if object.start_with?("word/")
      end
    end
    return final
  end

  #=======================================================================================================================

  def changing_document_content(pages_to_change, changes_to_do)
    pages_to_change.each do |zip_file|
      file = zip.find_entry(zip_file)
      doc = Nokogiri::XML.parse(file.get_input_stream)
      changes.each do |change|
        doc.xpath("//text()[.='#{changes_to_do[:keyword]}']").each do |part|
          part.content = changes_to_do[:datum]
        end
      end
      zip.get_output_stream(zip_file) { |f| f << doc.to_s }
    end
    zip.close
  end
end
