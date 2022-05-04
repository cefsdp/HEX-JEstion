class DocumentGeneratorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    raise
    treatment_info = getting_document_and_data_info(document)
    document_object = treatment_info[:document_object]
    tempfile_type = treatment_info[:document_type]
    temp_url = treatment_info[:document_url]
    changes_to_do = treatment_info[:changes_to_do]
    tempfile_name = downloading_document_from_db(document_url, tempfile_type)
    pages_to_change = getting_document_content(file_name, tempfile_type)
    changing_document_content(pages_to_change, changes_to_do)
    send_file "#{Rails.root}/app/assets/docs/#{file_name}.#{tempfile_type}", disposition: 'attachment'
  end

  
  private

  #=======================================================================================================================

  def getting_document_and_data_info(document)
    document_info = getting_document_object
    document_object = document_info[:object]
    document_url = document_info[:url]
    changes_to_do = getting_changes_to_do
    document_type = document.filename.extension_without_delimiter
    return {document_object: document_object, document_url: document_url, document_type: document_type, changes_to_do: changes_to_do}
  end


  def getting_document_object
  end


  def getting_changes_to_do
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
        doc.xpath("//text()[.='#{change[:title]}']").each do |part|
          part.content = change[:content]
        end
      end
      zip.get_output_stream(zip_file) { |f| f << doc.to_s }
    end
    zip.close
  end
end
