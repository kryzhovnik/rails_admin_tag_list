# coding: utf-8
require 'spec_helper'

describe 'RailsAdmin I18n' do
  before(:all) { I18n.locale = :ru  }
  it 'should be internationalizable' do
    get rails_admin_dashboard_path
    response.should contain('Панель управления')
  end
  
  describe "Edit Page" do
    
    it 'tag list field label can be set into the I18n' do
      I18n.backend.store_translations :ru, 
        { :activerecord => { :attributes => { :player => { :tag_list  => 'Теги' } } } }
      get_new_player_page
      
      response.should have_selector('label', :content => 'Теги')
    end
    
    it 'tag list field help message can be set into the I18n' do
      I18n.backend.store_translations :ru, 
        { :admin => { :new => { :tag_list_help => 'Пишите теги с маленькой буквы' } } } 
      get_new_player_page
      
      response.should have_selector('.help', :content => 'Пишите теги с маленькой буквы')
    end
    
  end

  after(:all) { I18n.locale = Dummy::Application.config.i18n.default_locale }
end
