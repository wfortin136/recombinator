require 'spec_helper'
require 'thor'

describe Recombinator do

  final_output = Hash["a"=> [1,nil,5], "b"=> [2,3,nil], "c"=> [nil,4,6]]
  
  it 'has a version number' do
    expect(Recombinator::VERSION).not_to be nil
  end

  it 'detects data format and returns type' do
    file = File.read("A_input.json")
    data = JSON.parse(file)
    expect(Recombinator::Convert.get_data_structure(data)).to eq("A")
    file = File.read("B_input.json")
    data = JSON.parse(file)
    expect(Recombinator::Convert.get_data_structure(data)).to eq("B")
  end

  it 'converts from matrix to array of hashes' do
    file = File.read("A_input.json")
    data = JSON.parse(file)
    expect(Recombinator::Convert.type_A(data)).to eq(final_output)
  end
  
  it 'converts from list of objects to array of hashes' do
    file = File.read("B_input.json")
    data = JSON.parse(file)
    expect(Recombinator::Convert.type_B(data)).to eq(final_output)
  end

  it 'saves as json' do
    if File.exist?("A_output.json")
      File.delete("A_output.json")
    end
    
    Recombinator::Convert.convert_file("A_input.json")
    expect(File.exist?("A_output.json")).to be true
  end

  it 'creates output file name' do
    expect(Recombinator::Convert.output_file("A_input.json")).to eq("A_output")
  end
  
  it 'Thor reads a single file name' do
    args = %w[convert -f A_input.json]
    options = Recombinator::Conversion.start(args)
    expect(options).to eq(["A_input.json"])
  end

  it 'Thor executes on a single file name' do
    if File.exist?("A_output.json")
      File.delete("A_output.json")
    end
    args = %w[convert -f A_input.json]
    options = Recombinator::Conversion.start(args)
    expect(File.exist?("A_output.json")).to be true
  end
  
  it 'Thor reads multiple files' do
    args = %w[convert -f A_input.json B_input.json]
    options = Recombinator::Conversion.start(args)
    expect(options).to eq(["A_input.json", "B_input.json"])
  end

  it 'executes multiple input files' do
    if File.exist?("A_output.json")
      File.delete("A_output.json")
    end
    if File.exist?("B_output.json")
      File.delete("B_output.json")
    end
    args = %w[convert -f A_input.json B_input.json]
    options = Recombinator::Conversion.start(args)
    expect(File.exist?("A_output.json")).to be true
    expect(File.exist?("B_output.json")).to be true
  end

end
