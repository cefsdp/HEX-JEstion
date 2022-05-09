class GeneratedDocumentsController < ApplicationController
  def new
    generated_document_data = generated_document_params
    document_id = generated_document_data[:document_id]
    document_class = generated_document_data[:document_class]
    type_doc_id = generated_document_data[:document_class]
    document = document_class.classify.safe_constantize.find(document_id.to_i)
    case document_class
    when "DocumentAdhesion"
      type_doc = "adhesion"
    else
      type_doc = ConfigDocEtude.find_by(nom: document.nom).type_doc
    end
    DocumentGeneratorJob.perform_now(document, type_doc)
  end

  private

  def generated_document_params
    params.require(:generated_document).permit!
  end
end
