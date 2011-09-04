require 'spec_helper'

describe "RailsAdmin Edit Page" do
  before { create_player_and_get_edit_page }
    
  it "should contain tag list field" do
    response.should have_selector(".field #player_tag_list")
  end
    
  it "should contain skill list field" do
    response.should have_selector(".field #player_skill_list")
  end
    
  it "should not display acts-as-taggable-on default associations" do
    ['Taggings', 'Base tags'].each do |aato_associations|
      response.should_not contain(aato_associations)
    end
  end
    
  it "should not display acts-as-taggable-on 'on' associations" do
    ['Tags', 'Tag taggings', 'Skills', 'Skill taggings'].each do |aato_associations|
      response.should_not contain(aato_associations)
    end
  end
end
