class Respaldo < ActiveRecord::Base


  private

    def sanitize_filename(filename)
      # Get only the filename, not the whole path (for IE)
      # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
      return File.basename(filename)
    end

    NUM_BYTES_IN_MEGABYTE = 1048576
    def file_size_under_one_mb
      if (this.file_contents.size.to_f / NUM_BYTES_IN_MEGABYTE) > 10
        errors.add(:file, 'File size cannot be over ten megabytes.')
      end
    end

end