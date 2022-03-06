class AdherentSingleUpdateFileStatusJob < ApplicationJob
  queue_as :default

  def perform(adherent)
    necessary_documents = ConfigDocAdherent.where(junior_configuration_id: JuniorConfiguration.where(junior_id: adherent.junior.id))
    adherent_documents = DocumentAdhesion.where(adherent_id: adherent.id, validite: ['valid', 'pending'])
    file_status = nil
    necessary_documents.each do |nec_doc|
      if adherent_documents.where(nom: nec_doc.nom).empty?
        return file_status = 'invalid'
      else
        adherent_documents.where(nom: nec_doc.nom).each do |doc|
          case doc.validite
          when 'valid'
            case file_status
            when nil
              file_status = 'valid'
            when 'valid'
              file_status = 'valid'
            when 'pending'
              file_status = 'pending'
            when 'invalid'
              file_status = 'invalid'
            end
          when 'pending'
            if [nil, 'valid', 'pending'].include?(file_status)
              file_status = 'pending'
            elsif file_status == 'invalid'
              file_status = 'invalid'
            end
          end
        end
      end
    end
    adherent.update(file_status: file_status)
  end
end
