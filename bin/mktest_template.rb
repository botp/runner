#-------------------------------------
#!env ruby
#
#-------------------------------------

require 'fileutils'

TEMPLATE_LOCATION  ="#{ENV['RUNNER_ROOT']}/templates"

def mktest_template pathname
   dict_ext_w_template = {
      ".py"=>"test_file_template.py",
      ".js"=>"test_file_template.js",
      ".rb"=>"test_file_template.rb",
   }


   test_folder,filename = File.split(pathname)
   extension    = File.extname(filename).downcase
   basefilename = File.basename(filename,extension)

   template_filename = dict_ext_w_template[extension]
   unless template_filename
      print "Unrecognized file extension\n"
      print "Valid file extensions are: %s" % dict_ext_w_template.keys.join(",") 
      exit 1
   end

   # test_folder   = File.join dirname , "test"
   test_filename = basefilename + extension
   test_pathname = File.join test_folder, test_filename

   unless File.directory? test_folder
      FileUtils.mkdir_p test_folder
   end

   unless File.file? test_pathname
      File.open(test_pathname,"w") do |f2|
         f1 = File.read ( File.join(TEMPLATE_LOCATION,template_filename) )
         f2.write( f1 % {filename: basefilename.capitalize} )
      end
   end

   exit 0

end

if $0 == __FILE__
   pathname = ARGV[0] || raise( "syntax: %s <file_to_edit>" % __FILE__ )
   mktest_template pathname
end

