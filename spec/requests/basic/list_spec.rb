require 'spec_helper'

describe "RailsAdmin List Page" do
  before do
    Player.create(
      :name => 'Smith', 
      :tag_list => 'cool, funny', 
      :skill_list => 'cook, swim, dance'
    )
    get rails_admin_list_path(:model_name => 'players', :set => '1')
  end    
  it "should contain player's tag list" do
    response.should contain('cool')
    response.should contain('funny')
  end
    
  it "should contain player's skill list" do
    response.should contain('cook')
    response.should contain('swim')
    response.should contain('dance')
  end
end
