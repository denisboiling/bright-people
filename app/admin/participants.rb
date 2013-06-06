# -*- coding: utf-8 -*-
ActiveAdmin.register Participant do
  menu label: 'Участники фестиваля', :parent => "Фестиваль"

  scope :all, :default => true
  scope :headliners
  scope :not_headliners
  
  Stage.all.each do |stage|
    scope stage.category.to_sym do |participants|
      participants.where(category: stage.category)
    end
  end

  filter :title

  index do
    id_column
    column :year
    column "Фотография" do |p|
      link_to image_tag(p.logo.url(:thumb), alt: p.title), p.logo.url(:original)
    end
    column :title
    column :headliner
    column :category
    column :priority
    column :description
    default_actions
  end

  form partial: 'form'

  show do
    attributes_table :year, :title, :headliner, :priority, :category, :updated_at

    panel 'Лого' do
      image_tag resource.logo.url(:medium)
    end

    panel 'Текст' do
      raw resource.description
    end
  end
end
