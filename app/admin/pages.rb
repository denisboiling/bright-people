# -*- coding: utf-8 -*-
ActiveAdmin.register Page do
  menu label: 'Страницы', :parent => "Фестиваль"

  filter :permalink

  index do
    id_column
    column :permalink
    column :created_at
    column :updated_at
    column :year
    default_actions
  end

  form partial: 'form'

  show do
    attributes_table :permalink, :created_at, :updated_at, :year

    panel 'Текст' do
      raw resource.text
    end
  end
end
