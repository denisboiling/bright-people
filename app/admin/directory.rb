# -*- coding: utf-8 -*-
ActiveAdmin.register Region do
  menu parent: 'Справочники', label: 'Регионы'

  filter :title

  show do
    attributes_table :title, :created_at, :updated_at
  end
end

ActiveAdmin.register MetroStation do
  menu parent: 'Справочники', label: 'Станции метро'

  filter :title

  show do
    attributes_table :title, :metro_branch, :region, :created_at, :updated_at
  end
end
