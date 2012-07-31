# -*- coding: utf-8 -*-
class RemoveNewsFromArticleCategory < ActiveRecord::Migration
  def change
    unless category = ArticleCategory.find_by_title('Новости')
      puts "INFO!!! ArticleCategory by title 'Новости' not found"
    else
      puts "Destroy all articles with category 'Новости'"
      category.articles.destroy_all
      if category.destroy
        puts "INFO!!! ArticelCategory 'Новости' successfuly destroed"
      else
        puts "WARNING!!! ArticleCategory 'Новости' cannot be destroyd!!!"
      end
    end
  end
end
