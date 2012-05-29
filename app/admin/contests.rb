# -*- coding: utf-8 -*-
ActiveAdmin.register Contest do
  menu label: "Конкурсы"
  
  index do
    id_column
    column :name
    column :category
    column :created_at
    column :updated_at
    default_actions
  end
end
