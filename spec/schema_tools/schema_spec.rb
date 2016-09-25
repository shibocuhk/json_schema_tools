require 'spec_helper'

describe SchemaTools::Schema do

  context '.initialize' do
    after :each do
      SchemaTools::Reader.registry_reset
    end

    it 'reads all schemas' do
      schema = SchemaTools::Schema.new("#{SchemaTools.schema_path}/client.json")
      expect(schema['name']).to eq 'client'
    end
  end

  context 'handel_version' do
    it 'can modify' do
      SchemaTools.schema_version = 20160101
      schema = SchemaTools::Schema.new("#{SchemaTools.schema_path}/versions/line_item.json")
      hash = schema.to_h
      expect(hash['properties']['price'].present?).to be true
      expect(hash['properties']['description'].present?).to be true
      expect(hash['properties']['tag'].present?).to be true
    end

    it 'can remove' do
      SchemaTools.schema_version = 20160102
      schema = SchemaTools::Schema.new("#{SchemaTools.schema_path}/versions/line_item.json")
      hash = schema.to_h
      expect(hash['properties']['price'].present?).to be true
      expect(hash['properties']['description'].present?).to be true
      expect(hash['properties']['tag'].present?).to be false
    end

    it 'apply all previous versions' do
      SchemaTools.schema_version = 20160103
      schema = SchemaTools::Schema.new("#{SchemaTools.schema_path}/versions/line_item.json")
      hash = schema.to_h
      expect(hash['properties']['price'].present?).to be true
      expect(hash['properties']['description'].present?).to be true
      expect(hash['properties']['tag'].present?).to be false
      expect(hash['properties']['rating'].present?).to be true
    end
  end

  context '.to_h' do
    after :each do
      SchemaTools::Reader.registry_reset
    end

    it 'returns hash with de-referenced $refs' do
      schema = SchemaTools::Schema.new("#{SchemaTools.schema_path}/one_of_definition.json")
      hash = schema.to_h
      first = hash['properties']['person']['oneOf'][0]
      expect(first['title']).to eq 'client'
    end

  end
end

