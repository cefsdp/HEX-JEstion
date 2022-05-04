class GeneratedDocumentsController < ApplicationController
    def new
        generated_document_data = generated_document_params
        document = generated_document_data[:document]
        type_doc = generated_document_data[:type_doc]
        DocumentGeneratorJob.perform_now(document, type_doc)
    end

    private

      def generated_document_params
        params.require(:generated_document).permit!
      end
end
