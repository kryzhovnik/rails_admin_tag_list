== Введение
На сегодня(20 января 2011) замечательный [rails_admin](https://github.com/sferik/rails_admin) не работает с другим замечательным гемом [acts_as_taggable_on](https://github.com/mbleigh/acts-as-taggable-on). Для связано с двумя проблемами:
*   rails_admin пока не умеет работать с именами моделей во вложнном пространстве имен(например ActsAsTaggableOn::Taggings) [issue](https://github.com/sferik/rails_admin/issues#issue/217)
*   rails_admin ничего не знает про виртуальные атрибуты *_list(tag_list, skill_list и т.д.), которые создает acts_as_taggable_on для отображения и редактирования тегов моделей

Первая проблема может быть **времменно** решена использованием [моего форка rails_admin](https://github.com/kryzhovnik/rails_admin).
Вторую решает этот гем.

== Установка
В вашем `Gemfile`:
    gem 'rails_admin', :git => 'https://github.com/kryzhovnik/rails_admin.git'
    gem 'rails_admin_tag_list_field', :git => 'https://github.com/kryzhovnik/rails_admin_tag_list_field.git'

Запустите:
    $ bundle install
Если вы хотите использовать ваш собственный форк rails_admin: 
    1. Исправить проблему с именами моделей в rails_admin (например [так](https://github.com/kryzhovnik/rails_admin/commit/4afd632560109ea5324b66108ae3b764f55f73a7))
    2. Сделайте форк этого гема, исправив зависимость от моего форка rails_admin в файле `rails_admin_tag_list_field/Gemfile`
    
== Использование
Гем [rails_admin_tag_list_field](https://github.com/kryzhovnik/rails_admin_tag_list_field) по-умолчанию делает следующее:

1. Добавляет в rails_admin новый тип поля `tag_list`
2. Находит виртуальные аттрибуты *_list созданные acts_as_taggable_on и добавляет для них поля в RailsAdmin.config
3. Скрывает ассоциации создаваемые acts_as_taggable_on

Например, ваша модель:
    class Player < ActiveRecord::Base
      acts_as_taggable
      acts_as_taggable_on :skills
    end

rails_admin_tag_list_field создаст следующие поля типа tag_list:
    tag_list
    skill_list

С этими полями можно делать все, что позволяет rails_admin:

* переименовать метку
    RailsAdmin.config Player do
      edit do
        field :tag_list do
          label "Теги"
        end
        field :skill_list
      end
    end

* скрыть поля с тегими
    RailsAdmin.config Player do
      edit do
        fields_of_type :tag_list do
          hide
        end
      end
    end
    
* переназначить партиал
    RailsAdmin.config Player do
      edit do
        fields_of_type :tag_list do
          partial 'awesome_tag_list'
        end
      end
    end


