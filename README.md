Introduction
============

For today(21 jan 2011) great [rails_admin](https://github.com/sferik/rails_admin) gem does not work with another great gem - [acts_as_taggable_on](https://github.com/mbleigh/acts-as-taggable-on). Due to two following problems:

* rails_admin does not yet support namespaced models(for example `ActsAsTaggableOn::Taggings` model) [issue](https://github.com/sferik/rails_admin/issues#issue/217)
* rails_admin knows nothing about the virtual attributes *_list(tag_list, skill_list etc.), which created by `acts_as_taggable_on` for display and edit tags.

The first problem can be **temporary** solved by using [my rails_admin fork](https://github.com/kryzhovnik/rails_admin).
The second problem is solved by this gem.

Installation
============

In your `Gemfile`:
    gem 'rails_admin', :git => 'https://github.com/kryzhovnik/rails_admin.git'
    gem 'rails_admin_tag_list_field', :git => 'https://github.com/kryzhovnik/rails_admin_tag_list_field.git'

And run:
    $ bundle install
    
If you want to use your own rails_admin fork first do the following:

1. Solve namespaced models issue in your rails_admin fork (for [example](https://github.com/kryzhovnik/rails_admin/commit/4afd632560109ea5324b66108ae3b764f55f73a7))

2. Fork this gem and correct dependences in the `rails_admin_tag_list_field/Gemfile`
    gem 'rails_admin', :git => '...'
    
Usage and Configuration
=======================

Gem [rails_admin_tag_list_field](https://github.com/kryzhovnik/rails_admin_tag_list_field) by default does the following:

1. Register new field type `TagList` for rails_admin
2. Finds acts_as_taggable_on virtual attributes (like `*_list`) and adds them to `RailsAdmin.config`
3. Hides associations created by acts_as_taggable_on

For example, this is your model:

    class Player < ActiveRecord::Base
      acts_as_taggable
      acts_as_taggable_on :skills
    end

rails_admin_tag_list_field creates the following fields with type of `:tag_list`:
    tag_list
    skill_list

You can do whatever what allows to do by the rails_admin:

**rename lable**

    RailsAdmin.config Player do
      edit do
        field :tag_list do
          label "Tags"
        end
        field :skill_list
      end
    end

**hide all tag_list fields**

    RailsAdmin.config Player do
      edit do
        fields_of_type :tag_list do
          hide
        end
      end
    end

**reassing partial**

    RailsAdmin.config Player do
      edit do
        fields_of_type :tag_list do
          partial 'awesome_tag_list'
        end
      end
    end


