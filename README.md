Introduction
============

Greate [rails_admin](https://github.com/sferik/rails_admin) gem does not work with another great gem - [acts_as_taggable_on](https://github.com/mbleigh/acts-as-taggable-on), because rails_admin knows nothing about the virtual attributes *_list (tag_list, skill_list etc.), which created by acts_as_taggable_on for display and edit tags.

This problem is solved with [rails_admin_tag_list](https://github.com/kryzhovnik/rails_admin_tag_list) gem.

Installation
============

In your `Gemfile`:

    gem 'rails_admin'
    gem 'rails_admin_tag_list'

and run:

    $ bundle install

Usage and Configuration
=======================

rails_admin_tag_list by default does the following:

1. Register new field type `TagList` for rails_admin
2. Finds acts_as_taggable_on virtual attributes (`*_list` - `tag_list`, `skill_list` etc.) and adds them to `RailsAdmin.config`

There is your model:

    class Player < ActiveRecord::Base
      attr_accessible :name
      attr_accessible :tag_list, :skill_list

      acts_as_taggable
      acts_as_taggable_on :skills
    end



> *Note that tag_list (skill_list, etc.) attribute should be available for mass-assignment by rails_admin users.*

> *Since Rails 3.2.3 `config.active_record.whitelist_attributes` option is true by default; this means that you should put tag_list (skill_list, etc.) attribute in the white list, like in example above:*

> `attr_accessible :tag_list, :skill_list`

**edit field view**

In addition to default field view (named `form_tag_list`) this gem provides two custom views `tag_list_with_suggestions` and `tag_list_with_autocomplete`. To enable any of them specify partial name:

    RailsAdmin.config do |config|
      config.model Player do
        edit do
          fields_of_type :tag_list do
            partial 'tag_list_with_suggestions'
            
            # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
            ratl_max_suggestions -1
          end
        end
      end
    end

You can do with tag_list fields whatever what allows to do rails_admin:

**rename lable**

    RailsAdmin.config do |config|
      config.model Player do
        edit do
          field :tag_list do
            label "Tags"
          end
          field :skill_list
        end
      end
    end

**hide all tag_list fields**

    RailsAdmin.config do |config|
      config.model Player do
        edit do
          fields_of_type :tag_list do
            hide
          end
        end
      end
    end

**reassing partial**

    RailsAdmin.config do |config|
      config.model Player do
        edit do
          fields_of_type :tag_list do
            partial 'awesome_tag_list'
          end
        end
      end
    end

Create you custom partial and put it to `app/views/rails_admin/main/` in your own project folder 
