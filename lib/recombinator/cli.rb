require 'thor'
#require "convert"

module Recombinator
  class Conversion < Thor
    desc "convert", "Choose a File(s) to convert"
    option :file, :required => true, :type => :array, :aliases => '-f', :desc => "Specify names of files separated by a space"
    def convert
       
      options[:file].each do |f|
        Recombinator::Convert.convert_file(f)
      end
    end

    desc "create", "Create sample input files of type A and B"
    def create
      #load('./create_files.rb')
    end
  end
end
