# -*- coding: utf-8 -*-
class AddDataPositionToArticleCategory < ActiveRecord::Migration
  def change
    categories = [
      { title: 'Новые места', position: 1},
      { title: 'Фоторепортаж', position: 2},
      { title: 'Колонка эксперта', position: 3},
      { title: 'Интервью', position: 4},
      { title: 'Личный опыт', position: 5},
      { title: 'Мастер-класс', position: 6},
      { title: 'Учителя', position: 7},
      { title: 'Зарубежный опыт', position: 8},
      { title: 'Личности', position: 9},
    ]
    categories.each do |category|
      if _category = ArticleCategory.find_by_title(category[:title])
        puts "ArticleCategory #{category[:title]} exist}" and next if _category.position == category[:position]
        _category.update_attribute(:position, category[:position])
        puts "Update ArticleCategory #{category[:title]} position"
      else
        puts "Create new ArticleCategory with #{category}"
        _category = ArticleCategory.new
        _category.title = category[:title]
        _category.position = category[:position]
        _category.save
      end
    end
  end
end
