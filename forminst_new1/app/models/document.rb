class Document < ActiveRecord::Base

  validate :file_size_under_one_mb
  validate :only_pdf

  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
        self.filename = sanitize_filename(@file.original_filename)
        self.content_type = @file.content_type
        self.file_contents = @file.read
    end
  end

  private

    def sanitize_filename(filename)
      # Get only the filename, not the whole path (for IE)
      # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
      return File.basename(filename)
    end

    NUM_BYTES_IN_MEGABYTE = 1048576
    def file_size_under_one_mb
      if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 1
        errors.add(:file, 'El tamaño del archivo no puede ser mayor a 1 MB.')
      end
    end

    def only_pdf
      if (@file.content_type != "application/pdf")
        errors.add(:file, 'El archivo solo puede ser PDF')
      end
    end

end