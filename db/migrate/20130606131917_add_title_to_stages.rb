#coding: utf-8

class AddTitleToStages < ActiveRecord::Migration
  def up
    add_column :stages, :title, :string

    Stage.reset_column_information
    stages = [
      { 'title' => 'Музыкальная сцена', 'category' => 'music_stage'     },
      { 'title' => 'Театральная сцена', 'category' => 'theater_stage'   },
      { 'title' => 'Цирковая сцена'   , 'category' => 'circus_stage'    },
      { 'title' => 'Уличные театры'   , 'category' => 'street_theater'  },
      { 'title' => 'Мастер-классы'    , 'category' => 'master_class'    }
    ]
    stages.each do |stage|
      sts = Stage.find_all_by_category(stage['category'])
      sts.each do |s|
        s.update_column(:title, stage['title'])
      end
    end
  end

  def down
    remove_column :stages, :title
  end
end
