require 'spec_helper'

describe "RailsAdmin Navigation Section" do
  before { create_player_and_get_edit_page }
  
  it "should not display acts-as-taggable-on default models" do
    ['Acts As Taggable On/Tag', 'Acts As Taggable On/Tagging'].each do |aato_model_name|
      response.should_not contain(aato_model_name)
    end
  end
end
