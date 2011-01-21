require 'spec_helper'

describe "RailsAdmin Config DSL Edit Section" do
  it "should show tag list fields by default" do
    get_new_player_page
    response.should have_tag("input#players_tag_list")
    response.should have_tag("input#players_skill_list")
  end
  
  describe "tag list field" do
    it "should be renameable" do
      RailsAdmin.config Player do
        edit do
          field :tag_list do
            label "Renamed field"
          end
          field :name
        end
      end
      get_new_player_page

      response.should have_tag(".field") do |elements|
        elements[0].should have_tag("label", :content => "Renamed field")
        elements[1].should have_tag("label", :content => "Name")
      end
      # Reset
      RailsAdmin::Config.reset Player
    end

    it "should be renameable by type" do
      RailsAdmin.config Player do
        edit do
          fields_of_type :tag_list do
            label { "#{label} (associated words)" }
          end
        end
      end
      get_new_player_page
      response.should have_tag(".field") do |elements|
        elements.should have_tag("label", :content => "Name")
        elements.should have_tag("label", :content => "Tag list (associated words)")
        elements.should have_tag("label", :content => "Skill list (associated words)")
      end

      # Reset
      RailsAdmin::Config.reset Player
    end

    it "should be hideable" do
      RailsAdmin.config Player do
        edit do
          field :tag_list do
            hide
          end
          field :skill_list
          field :name
        end
      end
      get_new_player_page
      response.should have_tag(".field") do |elements|
        elements[0].should have_tag("#players_skill_list")
        elements[1].should have_tag("#players_name")
      end
      response.should_not contain("Tag list")
      # Reset
      RailsAdmin::Config.reset Player
    end

    it "should be hideable by type" do
      RailsAdmin.config Player do
        edit do
          fields_of_type :tag_list do
            hide
          end
        end
      end
      get_new_player_page
      response.should have_tag(".field") do |elements|
        elements.should have_tag("label", :content => "Name")
        elements.should_not have_tag("label", :content => "Tag list")
        elements.should_not have_tag("label", :content => "Skill list")
      end

      # Reset
      RailsAdmin::Config.reset Player
    end

    it "should have option to customize the help text" do
      RailsAdmin.config Player do
        edit do
          field :tag_list do
            help "#{help}. Additional help text for tag list field"
          end
          field :skill_list
        end
      end
      get_new_player_page
      response.should have_tag(".field") do |elements|
        elements[0].should have_tag("p.help", :content => "Use commas to separate tags. Additional help text for tag list field")
        elements[1].should have_tag("p.help", :content => "Use commas to separate tags")
      end

      # Reset
      RailsAdmin::Config.reset Player
    end
  end
end
