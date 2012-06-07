# -*- coding: utf-8 -*-
ActiveAdmin.register User do
  menu label: "Пользователи"

  filter :email

  index do
    id_column
    column :email
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs 'Основное' do
      f.input :email
      f.input :role, as: :select, collection: Role.all
      f.input :description
      f.buttons
    end
  end
end
