require 'json'

module Recombinator
  class Convert
    
    def self.convert_file(filename)

      file = File.read(filename) # read file
      data = JSON.parse(file)    # parse json to ruby object
      lv = convert_lv(data)      # convert to lists of values
      out_filename = output_file(filename) # create output filename withour extension
      save_json(lv, out_filename)          # save as json with output filename
    end
    
    # convert type_A data, which is in matrix form, or 2 dimensional array
    def Convert.type_A(matrix)
      out = Hash.new                          # return object
      matrix[0].length.times do |col_index|   # iterate through each column of matrix
        col_data = matrix.map {|col_to_row| col_to_row[col_index]} # get array of column
        key = col_data[0]                     # get variable name of column
        array = col_data[1..col_data.length]  # get all elements of array
        out[key] = array                      # add to hash
      end
      return out                              # return hash
    end

    # Convert Type_B data, which is in an array of lists
    # return Hash table of array values
    def Convert.type_B(array)
      out = Hash.new                          # return object
      num_elements =  array.length            # number of elements per each variable
      keys = []                               # empty array of key values
      array.each do |row|                     # iterate through each hash within array
        keys += row.keys                      # add key values of current hash
        keys.uniq!                            # remove duplicate key values
      end
      
      keys.each do |key|                      # iterate through each key value
        row_array=Array.new(num_elements)     # re-initialize new array of hash values
        array.each_with_index do |row, index| # iterate through each list in arrat
          val = row[key]                      # get value of key
          row_array[index] = val              # set row index to value form key:value pair
        end
        out[key]=row_array                    # set key to row array
      end
      return out
    end

    # save ruby object as json
    def Convert.save_json(object, name)
        object_json = object.to_json
        fname = name+".json"
        File.open(fname, "w") do |f|
          f.write(object_json)
        end
        puts fname
    end

    # Convert ruby data_object into list of values, which in ruby is a hash table
    # with kay to array value pairs
    def Convert.convert_lv(data_object)
      # Check inner data structure class of input object. Both type_A and type_B 
      # have an array as the outer structure. So diffentiate using inner structure
      # which in this case is an Array and Hash respectively.
     
      # Ruby uses the === in the case statement which checks to see if an object is part
      # of a set. In my case, I'm checking if the object is part of a class.
      case get_data_structure(data_object)
      when "A" then
        return output_A = type_A(data_object)
      when "B" then
        return output_B = type_B(data_object)
      end

    end

    def Convert.get_data_structure(data_object)
      case data_object
      when Array then
        case data_object[0]
        when Array then
          return "A" #matrix
        when Hash then
          return "B" #list of objects
        end
      end
    end
    # take an input file formatted as follows
    # XXXXX_inputYYYYY
    # and output
    # XXXXX_output
    # Note we drop the extension
    def Convert.output_file(input_filename)
      name = input_filename.split("_input")
      return name[0]+"_output"
    end

  end
end

