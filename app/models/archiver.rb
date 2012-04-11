require 'zip/zip'
require 'zip/zipfilesystem'

class Archiver
  @public_path = "downloads"
  
  def self.public_path
    @public_path
  end
  
  # Creates a ZIP file from an array of files with the file name (including format)
  # as the key, and the file contents as the value
  def self.bundle(files,prefix='')
    filename = prefix + Digest::SHA1.hexdigest("#{Time.now.to_i}")[0..19].to_s + ".zip"
    file_path = File.join("public",@public_path,filename)
    tmpfile = Tempfile.new(filename,Rails.root + '/tmp')
    # Give the path of the temp file to the zip outputstream, it won't try to open it as an archive.
    Zip::ZipOutputStream.open(tmpfile.path) do |zos|
      files.each do |key,value|
        zos.put_next_entry(key)
        zos.write value
      end
    end

    FileUtils.chmod(0644, tmpfile.path)
    FileUtils.copy(tmpfile.path,File.join("public",public_path,filename))
    # The temp file will be deleted some time...
    tmpfile.close

    return File.join(public_path,filename)
  end
end